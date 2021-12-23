scriptencoding utf-8

" メニューの文字化け対策
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim

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
"if len(s:has_color) > 0
"	" 先頭のカラースキームを選ぶ
"	exe 'colorscheme' s:has_color[0]
"endif
colorscheme torte

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

" タブ表示
" 引用：Vim のタブをそこそこ活用する | ⬢ Appirits spirits https://spirits.appirits.com/doruby/9017/?cn-reloaded=1
" 個別のタブの表示設定をします
function! GuiTabLabel()
	" タブで表示する文字列の初期化をします
	let l:label = ''

	" タブに含まれるバッファ(ウィンドウ)についての情報をとっておきます。
	let l:bufnrlist = tabpagebuflist(v:lnum)

	" 表示文字列にバッファ名を追加します
	" パスを全部表示させると長いのでファイル名だけを使います 詳しくは help fnamemodify()
	let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
	" バッファ名がなければ No title としておきます。ここではマルチバイト文字を使わないほうが無難です
	let l:label .= l:bufname == '' ? 'No title' : l:bufname

	" タブ内にウィンドウが複数あるときにはその数を追加します(デフォルトで一応あるので)
	let l:wincount = tabpagewinnr(v:lnum, '$')
	if l:wincount > 1
		let l:label .= '[' . l:wincount . ']'
	endif

	" このタブページに変更のあるバッファがるときには '[+]' を追加します(デフォルトで一応あるので)
	for bufnr in l:bufnrlist
		if getbufvar(bufnr, "&modified")
			let l:label .= '[+]'
			break
		endif
	endfor

	" 表示文字列を返します
	return l:label
endfunction

" guitablabel に上の関数を設定します
" その表示の前に %N というところでタブ番号を表示させています
set guitablabel=%N:\ %{GuiTabLabel()}
