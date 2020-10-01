scriptencoding utf-8

let g:gruvbox_italic = 0
colorscheme gruvbox

set background=dark
set guifont=ゆたぽん（コーディング）Backsl:h12:cSHIFTJIS:qDRAFT
set printfont=ゆたぽん（コーディング）Backsl:h10:cSHIFTJIS:qDRAFT
set printheader=%<%t%h%m%=%N\ \ 

highlight clear CursorLine
highlight CursorLine gui=underline

command! ChangeViewMode call <SID>ChangeViewMode(s:is_transparent, !s:view_mode)
command! ChangeTransparent call <SID>ChangeViewMode(!s:is_transparent, s:view_mode)

let s:view_mode = v:true
let s:is_transparent = v:true

func! s:ChangeViewMode(is_transparent, view_mode)
	if a:is_transparent
		if a:view_mode
			call s:SetTransparency(230, 200)
		else
			call s:SetTransparency(190, 190)
		endif
	else
		call s:SetTransparency(255, 255)
	endif
	let s:is_transparent = a:is_transparent
	let s:view_mode = a:view_mode
endf

func! s:SetTransparency(onFocus, outFocus)
	" http://c4se.hatenablog.com/entry/2013/05/04/093446
	augroup MyGVimrc
		au!
		exec "autocmd GUIEnter    * set transparency=" . string(a:onFocus)
		exec "autocmd FocusGained * set transparency=" . string(a:onFocus)
		exec "autocmd FocusLost   * set transparency=" . string(a:outFocus)
	augroup END
	exec "set transparency=" . string(a:onFocus)
endf

" 初回
call s:ChangeViewMode(v:true, v:true)
