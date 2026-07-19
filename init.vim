call plug#begin('~/.local/share/nvim/plugged')
  Plug 'neovim/nvim-lspconfig'
  Plug 'Avi-D-coder/whisper.nvim'
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
:digr -- 8211 "–
:digr ^# 9839 "♯
:digr ^b 9837 "♭
:digr EN 8866   "⊢
:digr UU 120036 "𝓤
:digr JJ 120025 "𝓙
:digr CC 120018 "𝓒 
:digr BB 120121 "𝔹
:digr RR 8477   "ℝ
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
:digr ~~ 8776 "≈

:digr =D 8796 "≜
:digr TT 8868 "⊤
:digr FF 8869 "⊥
:digr TI 120035 "𝓣 
:digr IN 8712 "∈
:digr NI 8713 "∉
:digr SU 8746 "∪
:digr SI 8745 "∩
":digr (C 8834 "⊂
":digr )C 8835 "⊃
":digr (_ 8838 "⊆
"t:digr )_ 8839 "⊇
"
:digr .. 8228 "․
:digr TO 8614 "↦
:digr UP 8593 "↑
:digr DO 8595 "↓
:digr SE 8600 "↘
:digr SW 8601 "↙ 
:digr NW 8598 "↖
:digr NE 8599 "↗
:digr OL 128275 "🔓 open lock
:digr SL 128274 "🔒 shut lock
:digr << 10092 "❬
:digr >> 10093 "❭
:digr (( 10098 "❲
:digr )) 10099 "❳
:digr [] 10072 "❘
:digr [[ 10635 "⦋
:digr ]] 10636 "⦌
:digr {{ 8261 "⁅
:digr }} 8262 "⁆



" ------------------ IDRIS2 LSP CONFIG -----------------------
lua << EOF
-- 1. Extend the default configuration for the Idris2 LSP
vim.lsp.config('idris2_lsp', {
  on_attach = function(client, bufnr)
    -- Modern Neovim handles semantic tokens natively.
    -- No custom capability hacks or handlers are required.

    -- Define buffer-local options for keymaps
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- KEY MAPS
    vim.keymap.set('n', '<Leader>c', function() vim.lsp.buf.code_action({diagnostics={}, only={"refactor.rewrite.CaseSplit"}}) end, opts)
    vim.keymap.set('n', '<Leader>d', function() vim.lsp.buf.code_action({diagnostics={}, only={"refactor.rewrite.AddClause"}}) end, opts)
    vim.keymap.set('n', '<Leader>p', function() vim.lsp.buf.code_action({diagnostics={}, only={"refactor.rewrite.ExprSearch"}}) end, opts)
    vim.keymap.set('n', '<Leader>t', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Leader>g', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
    
    -- If you previously used a custom_attach(client) function defined elsewhere,
    -- you can call it here:
    -- custom_attach(client, bufnr)
  end,
})

-- 2. Enable the server (replaces require('lspconfig').idris2_lsp.setup)
vim.lsp.enable('idris2_lsp')
EOF


