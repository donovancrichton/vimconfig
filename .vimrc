execute pathogen#infect()
syntax on

filetype plugin indent on
au BufRead,BufNewFile *.p™ddl setf lisp
colorscheme desert
hi comment ctermfg=LightGrey
hi statemant cterm=Bold
hi function cterm=Bold
:set textwidth=79
:set fo+=t
:set tabstop=3
:set expandtab
:set number
:set ruler
