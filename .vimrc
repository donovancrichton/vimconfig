execute pathogen#infect()
syntax on

filetype plugin indent on
au BufRead,BufNewFile *.p™ddl setf lisp
colorscheme slate
hi comment ctermfg=LightGrey
hi statement ctermfg=Red cterm=Bold
hi function ctermfg=Brown cterm=Bold
:set textwidth=79
:set fo+=t
:set tabstop=3
:set expandtab
:set number
:set ruler
