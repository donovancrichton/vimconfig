call plug#begin('~/.vim/plugged')
  Plug 'neovim/nvim-lspconfig'
  Plug 'edwinb/idris2-vim'
call plug#end()

filetype indent off
:set wrap
:set number
:set expandtab
:set clipboard+=unnamedplus
:set textwidth=61


" ------------------------- DIGRAPHS -----------------------

:digr ^# 9839 "♯
:digr ^b 9837 "♭
:digr EN 8866   "⊢
:digr UU 120036 "𝓤
:digr JJ 120025 "𝓙
:digr BB 120121 "𝔹
:digr .W 9702   "◦
"digr .M        "·
"digr PR        "▶
"digr Tr        "▷
:digr >> 10230  "⟶
"digr -!        "↑
"digr -v        "↓
:digr =v 8659 "⇓
:digr NN 8469 "ℕ
:digr ZZ 8484 "ℤ
:digr ** 9734 "☆
:digr ox 8855 "⊗
:digr iI 120336 "𝘐
:digr EQ 8801 "≡
:digr -~ 8771 "≃
:digr ~> 8669 "⇝
:digr =~ 8773 "≅
:digr TT 8868 "⊤
:digr Tt 120035 "𝓣 
:digr RR 119929 "𝑹

" ------------------------ HASKELL LSP -----------------------
set rtp+=~/.vim/pack/XXX/start/LanguageClient-neovim
let g:LanguageClient_serverCommands = {'haskell': ['haskell-language-server-wrapper' , '--lsp']}
let g:haskell_enable_quantification = 1   
  " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      
  " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      
  " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 
  " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        
  " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  
  " to enable highlighting of `static`
let g:haskell_backpack = 1                
  " to enable highlighting of backpack keywords
let g:haskell_classic_highlighting = 1

" ------------------ IDRIS2 LSP CONFIG -----------------------
lua << EOF
local lspconfig = require('lspconfig')
-- Flag to enable semantic highlightning on start, 
-- if false you have to issue a first command manually
local autostart_semantic_highlightning = true
lspconfig.idris2_lsp.setup {
  on_new_config = function(new_config, new_root_dir)
    new_config.capabilities['workspace']['semanticTokens'] = {refreshSupport = true}
  end,
  on_attach = function(client)
    if autostart_semantic_highlightning then
      vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
        {textDocument = vim.lsp.util.make_text_document_params()}, nil)
    end
    -- KEY MAPS
    vim.cmd [[nnoremap <Leader>c <Cmd>lua vim.lsp.buf.code_action({diagnostics={},only={"refactor.rewrite.CaseSplit"}})<CR>]]
    vim.cmd [[nnoremap <Leader>d <Cmd>lua vim.lsp.buf.code_action({diagnostics={},only={"refactor.rewrite.AddClause"}})<CR>]]
    vim.cmd [[nnoremap <Leader>p <Cmd>lua vim.lsp.buf.code_action({diagnostics={},only={"refactor.rewrite.ExprSearch"}})<CR>]]
    vim.cmd [[nnoremap <Leader>t <Cmd>lua vim.lsp.buf.hover()<CR>]]
    vim.cmd [[nnoremap <Leader>g <Cmd>lua vim.lsp.buf.definition()<CR>]]
    -- vim.cmd [[nnoremap <Leader>e <Cmd>lua vim.lsp.show_line_diagnostic()<CR>]]
    vim.cmd [[nnoremap <Leader>e <Cmd>lua vim.diagnostic.open_float()<CR>]]
    -- replace show_line_diagnostics() with 
    -- vim.lsp.diagnostics.open_float()
    -- if things stop working
    --custom_attach(client) -- remove this line if you don't have a customized attach function
  end,
  autostart = true,
  flags = { debounce_text_changes = 150 },
  -- HANDLERS
  handlers = {
    ['workspace/semanticTokens/refresh'] = function(err, result, context, config)
      if autostart_semantic_highlightning then
        vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
          { textDocument = vim.lsp.util.make_text_document_params() }, nil)
      end
      return vim.NIL
    end,
    ['textDocument/semanticTokens/full'] = function(error, result, context, config)
        -- Temporary handler until native support lands
        -- <https://github.com/idris-community/idris2-lsp/wiki/Editor-specific-configuration#neovim-05-builtin-lsp>
        local client_id = context.client_id
        local bufnr = context.bufnr
        local data = result.data

        local client = vim.lsp.get_client_by_id(client_id)
        local legend = client.server_capabilities.semanticTokensProvider.legend
        local token_types = legend.tokenTypes

        local ns = vim.api.nvim_create_namespace('nvim-lsp-semantic')
        vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

        local prev_line, prev_start = nil, 0
        for i = 1, #data, 5 do
          local delta_line = data[i]
          prev_line = prev_line and prev_line + delta_line or delta_line
          local delta_start = data[i + 1]
          prev_start = delta_line == 0 and prev_start + delta_start or delta_start

          local line = vim.api.nvim_buf_get_lines(bufnr, prev_line, prev_line + 1, false)[1]
          local byte_start = vim.str_byteindex(line, prev_start)
          local byte_end = vim.str_byteindex(line, prev_start + data[i + 2])

          local token_type = token_types[data[i + 3] + 1]
          local highlight_group = 'LspSemantic_' .. token_type

          vim.api.nvim_buf_add_highlight(bufnr, ns, highlight_group, prev_line, byte_start, byte_end)
          -- vim.cmd(string.format([[echom '%s %s %s %s %s']], ns, highlight_group, prev_line, byte_start, byte_end))

        end
      end,
  },
}

-- Set here your preferred colors for semantic values
vim.cmd [[highlight link LspSemantic_type Include]]   -- Type constructors
vim.cmd [[highlight link LspSemantic_function Identifier]] -- Functions names
vim.cmd [[highlight link LspSemantic_enumMember Number]]   -- Data constructors
vim.cmd [[highlight LspSemantic_variable guifg=gray]] -- Bound variables
vim.cmd [[highlight link LspSemantic_keyword Structure]]  -- Keywords
vim.cmd [[highlight link LspSemantic_namespace Identifier]] -- Explicit namespaces
vim.cmd [[highlight link LspSemantic_postulate Define]] -- Postulates
vim.cmd [[highlight link LspSemantic_module Identifier]] -- Module identifiers

local set_hl_for_floating_window = function()
  vim.api.nvim_set_hl(0, 'NormalFloat', {
    link = 'Normal',
  })
  vim.api.nvim_set_hl(0, 'FloatBorder', {
    bg = 'none',
  })
end

set_hl_for_floating_window()

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  desc = 'Avoid overwritten by loading color schemes later',
  callback = set_hl_for_floating_window,
})

-- Add the following command to a mapping if you want to send a manual request for semantic highlight
-- :lua vim.lsp.buf_request(0, 'textDocument/semanticTokens/full', {textDocument = vim.lsp.util.make_text_document_params()}, nil)
EOF
