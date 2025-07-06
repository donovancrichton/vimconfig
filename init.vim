call plug#begin('~/.local/share/nvim/plugged')
  Plug 'neovim/nvim-lspconfig'
call plug#end()

filetype indent off
:set wrap                                                           
:set number
:set expandtab
:set textwidth=160
:set clipboard=unnamedplus
colorscheme donovan

" ------------------------- DIGRAPHS -----------------------

":digr Sb "∙
":digr Ob "∘
":digr PR "▶
:digr ^# 9839 "♯
:digr ^b 9837 "♭
:digr EN 8866   "⊢
:digr UU 120036 "𝓤
:digr JJ 120025 "𝓙
:digr CC 120018 "𝓒 
:digr BB 120121 "𝔹
:digr .W 9702   "◦
:digr CO 8728   "∘
"digr .M        "·
"digr Ob        "∘
"digr Sb        "∙
:digr >> 10230  "⟶
"digr -!        "↑
"digr -v        "↓
"digr PR        "▶
"digr Tr        "▷
"digr fS        "■
:digr =v 8659 "⇓
:digr NN 8469 "ℕ
:digr ZZ 8484 "ℤ
:digr ** 9734 "☆
:digr ox 8855 "⊗
:digr o+ 8853 "⊕
:digr II 120336 "𝘐
:digr EQ 8801 "≡
:digr -~ 8771 "≃
:digr ~> 8669 "⇝
:digr =~ 8773 "≅
:digr =D 8796 "≜
:digr TT 8868 "⊤
:digr FF 8869 "⊥
:digr TI 120035 "𝓣 
:digr RR 119929 "𝑹
:digr IN 8712 "∈
:digr NI 8713 "∉
:digr SU 8746 "∪
:digr SI 8745 "∩
:digr UP 8593 "↑
:digr DO 8595 "↓
:digr OL 128275 "🔓 open lock
:digr SL 128274 "🔒 shut lock
:digr << 65378 "｢
:digr >> 65379 "｣

" ------------------ IDRIS2 LSP CONFIG -----------------------
lua << EOF
local lspconfig = require('lspconfig')
-- Flag to enable semantic highlightning on start, 
-- if false you have to issue a first command manually
local autostart_semantic_highlightning = true
-- setup
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
--    vim.cmd [[nnoremap <Leader>e <Cmd>lua vim.lsp.show_line_diagnostic()<CR>]]
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
-- Types
vim.cmd [[highlight link LspSemantic_type Type]]
-- Function Names
vim.cmd [[highlight link LspSemantic_function Identifier]]
-- Data Constuctors
vim.cmd [[highlight link LspSemantic_enumMember Constant]]
-- Bound Variables
vim.cmd [[highlight LspSemantic_variable guifg=orange]]
-- Keywords
vim.cmd [[highlight link LspSemantic_keyword Statement]]
-- Explicit Namespace
vim.cmd [[highlight link LspSemantic_namespace Identifier]]
-- Postulates
vim.cmd [[highlight link LspSemantic_postulate Define]]
-- Module Identifiers
vim.cmd [[highlight link LspSemantic_module PreProc]]

local set_hl_for_floating_window = function()
  vim.api.nvim_set_hl(0, 'NormalFloat', {
    link = 'Normal',
  })
  vim.api.nvim_set_hl(0, 'FloatBorder', {
    fg = "#FFFFFF",
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



