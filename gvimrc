scriptencoding utf-8

let g:gruvbox_italic = 0
colorscheme gruvbox

set background=dark
set guifont=ゆたぽん（コーディング）Backsl:h12:cSHIFTJIS:qDRAFT
set printfont=ゆたぽん（コーディング）Backsl:h10:cSHIFTJIS:qDRAFT
set printheader=%<%t%h%m%=%N\ \ 

highlight clear CursorLine
highlight CursorLine gui=underline

command! ViewVideoModeToggle call <SID>ViewVideoModeToggle()
let s:view_mode = v:true

" http://c4se.hatenablog.com/entry/2013/05/04/093446
func! s:ViewVideoModeToggle()
	if s:view_mode
		augroup MyGVimrc
			au!
			autocmd GUIEnter * set transparency=230
			autocmd FocusGained * set transparency=230
			autocmd FocusLost * set transparency=200
		augroup END
		set transparency=230
		let s:view_mode = v:false
	else
		augroup MyGVimrc
			au!
			autocmd GUIEnter * set transparency=190
			autocmd FocusGained * set transparency=190
			autocmd FocusLost * set transparency=190
		augroup END
		set transparency=190
		let s:view_mode = v:true
	endif
endf

" 初回
ViewVideoModeToggle
