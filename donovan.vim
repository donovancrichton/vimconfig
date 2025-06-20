" Name:         Donovan
" Author:       original Author Donovan Crichton

set background=dark

hi clear
let g:colors_name = 'donovan'

" let s:t_Co = &t_Co


hi! link Terminal Normal
hi! link Boolean Constant
hi! link Character Constant
hi! link Conditional Statement
hi! link Debug Special
hi! link Define PreProc
hi! link Delimiter Special
hi! link Exception Statement
hi! link Float Constant
hi! link Function Identifier
hi! link Include PreProc
hi! link Keyword Statement
hi! link Macro PreProc
hi! link Number Constant
hi! link PopupSelected PmenuSel
hi! link PreCondit PreProc
hi! link Repeat Statement
hi! link SpecialChar Special
hi! link SpecialComment Special
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link StorageClass Type
hi! link String Constant
hi! link Structure Type
hi! link Tag Special
hi! link LspSemantic_Variable Special
hi! link Typedef Type
hi! link lCursor Cursor
hi! link CurSearch Search
hi! link CursorLineFold CursorLine
hi! link CursorLineSign CursorLine
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link MessageWindow Pmenu
hi! link PopupNotification Todo
hi! link Spell Normal

" Normal Vim Test
hi Normal guifg=#ffffff guibg=NONE gui=NONE cterm=NONE

" Line Number
hi LineNr guifg=#ffffff guibg=NONE gui=NONE cterm=NONE

" Comments e.g -- This is a comment
hi Comment guifg=#c0c0c0 guibg=NONE gui=NONE cterm=NONE

" Data Constructor e.g Nil | Cons a List a
hi Constant guifg=#00ff00 guibg=NONE gui=bold cterm=NONE

" Function name color e.g foo = ...
hi Identifier guifg=#00ffff guibg=NONE gui=NONE cterm=NONE

" Types e.g List a, List b, Int, etc
hi PreProc guifg=#ffffff guibg=NONE gui=NONE cterm=NONE

" Keywords and arrows/colons
hi Type guifg=#ffff00 guibg=NONE gui=bold cterm=NONE

" Function/Index Arguments
hi Special guifg=#ffaf00 guibg=NONE gui=bold cterm = None
