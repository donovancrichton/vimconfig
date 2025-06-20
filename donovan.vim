" Name:         Donovan
" Author:       Donovan Crichton
" License:      Same as Vim

set background=dark

hi clear
let g:colors_name = 'donovan'

let s:t_Co = &t_Co

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
hi! link Typedef Type
hi! link lCursor Cursor
hi! link CurSearch Search
hi! link CursorLineFold CursorLine
hi! link CursorLineSign CursorLine
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link MessageWindow Pmenu
hi! link PopupNotification Todo

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#000000', '#cd0000', '#00cd00', '#cdcd00', '#0000ee', '#cd00cd', '#00cdcd', '#e5e5e5', '#7f7f7f', '#ff0000', '#00ff00', '#ffff00', '#5c5cff', '#ff00ff', '#00ffff', '#ffffff']
  " Nvim uses g:terminal_color_{0-15} instead
  for i in range(g:terminal_ansi_colors->len())
    let g:terminal_color_{i} = g:terminal_ansi_colors[i]
  endfor
endif
hi Normal guifg=#ffffff guibg=#000000 gui=NONE cterm=NONE
hi ColorColumn guifg=NONE guibg=#cd0000 gui=NONE cterm=NONE
hi CursorColumn guifg=NONE guibg=#666666 gui=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#666666 gui=NONE cterm=NONE
hi CursorLineNr guifg=#ffff00 guibg=NONE gui=bold cterm=NONE
hi QuickFixLine guifg=#000000 guibg=#00cdcd gui=NONE cterm=NONE
hi Conceal guifg=#ff00ff guibg=#a9a9a9 gui=NONE cterm=NONE
hi Cursor guifg=#ffffff guibg=#60a060 gui=NONE cterm=NONE
hi Directory guifg=#00ffff guibg=NONE gui=NONE cterm=NONE
hi EndOfBuffer guifg=#ffff00 guibg=#303030 gui=NONE cterm=NONE
hi ErrorMsg guifg=#ffffff guibg=NONE gui=bold cterm=None
hi FoldColumn guifg=#ffffff guibg=NONE gui=NONE cterm=NONE
hi Folded guifg=NONE guibg=#4d4d4d gui=NONE cterm=NONE
hi IncSearch guifg=NONE guibg=#4682b4 gui=NONE cterm=NONE
hi LineNr guifg=#ffffff guibg=NONE gui=NONE cterm=NONE
hi MatchParen guifg=NONE guibg=#008b8b gui=NONE cterm=NONE
hi ModeMsg guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=NONE
hi MoreMsg guifg=#ff00ff guibg=NONE gui=bold cterm=NONE
hi NonText guifg=#ffff00 guibg=#303030 gui=NONE cterm=NONE
hi Pmenu guifg=#ff00ff guibg=#444444 gui=NONE cterm=NONE
hi PmenuSbar guifg=NONE guibg=#000000 gui=NONE cterm=NONE
hi PmenuSel guifg=#000000 guibg=#00cdcd gui=NONE cterm=NONE
hi PmenuThumb guifg=NONE guibg=#e5e5e5 gui=NONE cterm=NONE
hi Question guifg=#00ff00 guibg=#000000 gui=bold cterm=NONE
hi Search guifg=#000000 guibg=#a9a9a9 gui=bold cterm=NONE
hi SignColumn guifg=#00ffff guibg=NONE gui=NONE cterm=NONE
hi SpecialKey guifg=#00ffff guibg=NONE gui=NONE cterm=NONE
hi StatusLine guifg=#00ffff guibg=#0000ff gui=bold cterm=NONE
hi StatusLineNC guifg=#ff00ff guibg=#00008b gui=NONE cterm=NONE
hi VertSplit guifg=#add8e6 guibg=#00008b gui=NONE cterm=NONE
hi TabLine guifg=#000000 guibg=#008b8b gui=NONE cterm=NONE
hi TabLineFill guifg=#a9a9a9 guibg=#7f7f7f gui=NONE cterm=NONE
hi TabLineSel guifg=#00ffff guibg=#000000 gui=bold cterm=NONE
hi Terminal guifg=#00ffff guibg=#000000 gui=NONE cterm=NONE
hi Title guifg=#a9a9a9 guibg=NONE gui=NONE cterm=NONE
hi Visual guifg=NONE guibg=NONE gui=reverse ctermfg=NONE ctermbg=NONE cterm=reverse
hi VisualNOS guifg=NONE guibg=#000000 gui=bold,underline cterm=underline
hi WarningMsg guifg=#ffff00 guibg=NONE gui=NONE cterm=NONE
hi WildMenu guifg=#000000 guibg=#ffff00 gui=NONE cterm=NONE
hi SpellBad guifg=#ff00ff guibg=NONE gui=bold cterm=underline
hi SpellCap guifg=#ff00ff guibg=NONE gui=bold cterm=underline
hi SpellLocal guifg=#ff00ff guibg=NONE gui=bold cterm=underline
hi SpellRare guifg=#ff00ff guibg=NONE gui=bold cterm=underline
"Idris2 commment
hi Comment guifg=#808080 guibg=NONE gui=NONE cterm=NONE
"Idris2 Data Constructor/Value
hi Constant guifg=#00ff00 guibg=NONE gui=bold cterm=NONE
"Idris2 Floating Error
hi Error guifg=#ff0000 guibg=NONE gui=bold cterm=NONE
"Idris2 Funcion Name
hi Identifier guifg=#00ffff guibg=NONE gui=NONE cterm=NONE
"Idris2 ????
hi Ignore guifg=#000000 guibg=#000000 gui=NONE cterm=NONE
"Idris2 ????
hi Label guifg=#ffaf00 guibg=NONE gui=NONE cterm=NONE
"Idris2 ????
hi Operator guifg=#ff00ff guibg=NONE gui=NONE cterm=NONE
"Idris2 Module Name, File Path, etc
hi PreProc guifg=#ffffff guibg=NONE gui=NONE cterm=NONE
"Idris2 Hover Text Colour
hi Special guifg=#ff00ff guibg=NONE gui=NONE cterm=NONE
"Idris2 keyword colon arrow parens etc
hi Statement guifg=#ffff00 guibg=NONE gui=NONE cterm=NONE
"Idris2 ????
hi Todo guifg=#ff00ff guibg=#ffa500 gui=NONE cterm=NONE
"Idris2 Floating Error
hi DiagnosticError guifg=#ff0000 guibg=NONE gui=NONE cterm=None
"Idris2 Error Underline
hi DiagnosticUnderlineError guifg=None guibg=NONE gui=underline guisp=#ff0000 cterm=NONE
"Idris2 Datatype-Name/Type.
hi Type guifg=#ffffff guibg=NONE gui=bold cterm=NONE
"Idris2 ????
hi Underlined guifg=#ff00ff guibg=NONE gui=underline cterm=underline
hi CursorIM guifg=NONE guibg=fg gui=NONE cterm=NONE
hi ToolbarLine guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
hi ToolbarButton guifg=#000000 guibg=#e5e5e5 gui=bold cterm=NONE
hi DiffAdd guifg=#ff00ff guibg=NONE gui=NONE cterm=NONE
hi DiffChange guifg=#ff00ff guibg=NONE gui=NONE cterm=NONE
hi DiffText guifg=#000000 guibg=NONE gui=NONE cterm=NONE
hi DiffDelete guifg=#ff00ff guibg=NONE gui=NONE cterm=NONE

