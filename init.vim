
call plug#begin('~/.vim/plugged')
  Plug 'neovim/nvim-lspconfig'
  Plug 'edwinb/idris2-vim'
  Plug 'whonore/Coqtail'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': 'markdown' }
call plug#end()

filetype indent off

let mapleader = '\'
set number
set expandtab


"---------------------- digraphs -------------------

digr NN 8469 "ℕ
digr UU 120036 "𝓤
digr TT 8868 "⊤
"digr -T gives ⊥
digr EN 8866 "⊢
"digr .M gives ·
digr _a 8336 "subscript a
"digr *X gives ×
digr .W 9702 "◦

"-------------------------IDRIS2 LSP CONFIG----------------------------------

lua << EOF
local lspconfig = require('lspconfig')
-- Flag to enable semantic highlightning on start, if false you have to issue a first command manually
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
    -- Example of how to request a single kind of code action with a keymap,
    -- refer to the table in the README for the appropriate key for each command.
    vim.cmd [[nnoremap <Leader>c <Cmd>lua vim.lsp.buf.code_action({diagnostics={},only={"refactor.rewrite.CaseSplit"}})<CR>]]
    vim.cmd [[nnoremap <Leader>d <Cmd>lua vim.lsp.buf.code_action({diagnostics={},only={"refactor.rewrite.AddClause"}})<CR>]]
    vim.cmd [[nnoremap <Leader>p <Cmd>lua vim.lsp.buf.code_action({diagnostics={},only={"refactor.rewrite.ExprSearch"}})<CR>]]
    vim.cmd [[nnoremap <Leader>t <Cmd>lua vim.lsp.buf.hover()<CR>]]
    vim.cmd [[nnoremap <Leader>g <Cmd>lua vim.lsp.buf.definition()<CR>]]
    vim.cmd [[nnoremap <Leader>e <Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>]]

    --custom_attach(client) -- remove this line if you don't have a customized attach function
  end,
  autostart = true,
  handlers = {
    ['workspace/semanticTokens/refresh'] = function(err,  params, ctx, config)
      if autostart_semantic_highlightning then
        vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
          { textDocument = vim.lsp.util.make_text_document_params() }, nil)
      end
      return vim.NIL
    end,
    ['textDocument/semanticTokens/full'] = function(err,  result, ctx, config)
      -- temporary handler until native support lands
      local bufnr = ctx.bufnr
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      local legend = client.server_capabilities.semanticTokensProvider.legend
      local token_types = legend.tokenTypes
      local data = result.data

      local ns = vim.api.nvim_create_namespace('nvim-lsp-semantic')
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
      local tokens = {}
      local prev_line, prev_start = nil, 0
      for i = 1, #data, 5 do
        local delta_line = data[i]
        prev_line = prev_line and prev_line + delta_line or delta_line
        local delta_start = data[i + 1]
        prev_start = delta_line == 0 and prev_start + delta_start or delta_start
        local token_type = token_types[data[i + 3] + 1]
        local line = vim.api.nvim_buf_get_lines(bufnr, prev_line, prev_line + 1, false)[1]
        local byte_start = vim.str_byteindex(line, prev_start)
        local byte_end = vim.str_byteindex(line, prev_start + data[i + 2])
        vim.api.nvim_buf_add_highlight(bufnr, ns, 'LspSemantic_' .. token_type, prev_line, byte_start, byte_end)
      end
    end
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


-- Add the following command to a mapping if you want to send a manual request for semantic highlight
-- :lua vim.lsp.buf_request(0, 'textDocument/semanticTokens/full', {textDocument = vim.lsp.util.make_text_document_params()}, nil)
EOF
