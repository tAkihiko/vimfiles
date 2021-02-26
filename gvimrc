scriptencoding utf-8

" カラースキームの設定
let s:has_color = []
if !empty(globpath(&rtp, 'colors/tokyonight.vim'))
	let g:tokyonight_style = 'night' " available: night, storm
	let g:tokyonight_enable_italic = 0
	let g:tokyonight_disable_italic_comment = 1
	let s:has_color += ['tokyonight']
endif
if !empty(globpath(&rtp, 'colors/gruvbox.vim'))
	let g:gruvbox_italic = 0
	let s:has_color += ['gruvbox']
endif
if !empty(globpath(&rtp, 'colors/dracula.vim'))
	let g:dracula_italic = 0
	let s:has_color += ['dracula']
endif
if len(s:has_color) > 0
	" 先頭のカラースキームを選ぶ
	exe 'colorscheme' s:has_color[0]
endif

set background=dark
set guifont=ゆたぽん（コーディング）Backsl:h12:cSHIFTJIS:qDRAFT
set printfont=ゆたぽん（コーディング）Backsl:h10:cSHIFTJIS:qDRAFT
set printheader=%<%t%h%m%=%N\ \ 

highlight clear CursorLine
highlight CursorLine gui=underline

command! ChangeViewMode    call <SID>ChangeViewMode()
command! ChangeTransparent call <SID>ChangeTransparent()

let s:view_mode = v:true
let s:is_transparent = v:true

func! s:ChangeViewMode()
	call <SID>SetGuiParam(s:is_transparent, !s:view_mode)
endf

func! s:ChangeTransparent()
	call <SID>SetGuiParam(!s:is_transparent, s:view_mode)
endf

func! s:SetGuiParam(is_transparent, view_mode)
	if a:is_transparent
		if a:view_mode
			call s:SetTransparency(230, 200)
		else
			call s:SetTransparency(190, 150)
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
call s:SetGuiParam(v:true, v:true)
