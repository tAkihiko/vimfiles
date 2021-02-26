scriptencoding utf-8

let $VIMHOME = expand("~/vimfiles")

set viminfo+=c

set backupdir^=$VIMHOME/backupfiles
set undodir^=$VIMHOME/undofiles
set directory^=$VIMHOME/swpfiles

set number
set list listchars=tab:>-,trail:.
set cursorline
set shiftwidth=0 tabstop=4
set nofixendofline
set undofile
set migemo

" Visual Studio
set errorformat+=%m%\\t%f%\\t%l%\\t

augroup MySetting
	au!
	au FileType qf setlocal nocursorline
augroup END

call plug#begin('$VIMHOME/plugged')

" {{{ Plugin

"Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'thinca/vim-localrc'
Plug 'junegunn/vim-easy-align'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'airblade/vim-gitgutter'
Plug 'h1mesuke/vim-alignta'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/ctrlp-matchfuzzy'
Plug 'itchyny/vim-cursorword'
"Plug 'mattn/vim-vsopen'
Plug 'osyo-manga/vim-jplus'
Plug 'majutsushi/tagbar'
Plug 'timcharper/textile.vim'
Plug 'tyru/open-browser.vim'
Plug 'previm/previm'
"Plug 'mattn/webapi-vim'
Plug 'vim-jp/vital.vim'
Plug 'thinca/vim-partedit'
Plug 'andymass/vim-matchup'
Plug 'aklt/plantuml-syntax'
Plug 'qpkorr/vim-renamer'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-lsp-icons'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'sheerun/vim-polyglot'
Plug 'ghifarit53/tokyonight-vim'

Plug '~\vimfiles\myplugin\_tanikawa'
Plug '~\vimfiles\myplugin\vim-vsopen'
Plug '~\vimfiles\myplugin\vim-region-edit'
Plug '~\vimfiles\myplugin\vim-fugitive'

let s:my_plugin_vimrc = $VIMHOME . '/secret/my_plugin.vimrc'
if filereadable(s:my_plugin_vimrc)
	exe 'source' s:my_plugin_vimrc
endif

" }}}

call plug#end()

nnoremap <C-L> :nohlsearch<CR><C-L>

nnoremap <C-C> "*yiw
nnoremap g<C-C> ^"*yg_
xnoremap <C-C> "*y
nnoremap ciy ciw<C-R>0<ESC>

inoremap <C-V> <C-R>0
cnoremap <C-V> <C-R>0

nnoremap <C-]> g<C-]>
nnoremap <C-W><C-]> <C-W>g<C-]>
"nnoremap <C-W>} <C-W>g}
nnoremap <silent> <C-W>} :call PreviewWord()<CR>

nnoremap R gR

" {{{ My Command 

func! PreviewWord()
	if &previewwindow			" プレビューウィンドウ内では実行しない
		return
	endif
	let w = expand("<cword>")		" カーソル下の単語を得る
	if w =~ '\a'			" その単語が文字を含んでいるなら

		" 別のタグを表示させる前にすでに存在するハイライトを消去する
		silent! wincmd P			" プレビューウィンドウにジャンプ
		if &previewwindow			" すでにそこにいるなら
			match none			" 存在するハイライトを消去する
			wincmd p			" もとのウィンドウに戻る
		endif

		" カーソル下の単語にマッチするタグを表示してみる
		try
			exe "ptjump" w
		catch
			return
		endtry

		silent! wincmd P			" プレビューウィンドウにジャンプ
		if &previewwindow		" すでにそこにいるなら
			if has("folding")
				silent! .foldopen		" 閉じた折り畳みを開く
			endif
			call search("$", "b")		" 前の行の最後へ
			let w = substitute(w, '\\', '\\\\', "")
			call search('\<\V' . w . '\>')	" カーソルをマッチしたところへ
			" ここで単語にハイライトをつける
			hi previewWord term=bold ctermbg=green guibg=green guifg=Black
			exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
			wincmd p			" もとのウィンドウへ戻る
		endif
	endif
endfun

func! MyXxdSyntaxHightlight() abort

	" {{{
	"syn match myXxdHex1 contained /[ 0-9a-f]\{5}/
	"syn match myXxdHex2 contained /[ 0-9a-f]\{5}/
	"syn match myXxdHex3 contained /[ 0-9a-f]\{5}/
	"syn match myXxdHex4 contained /[ 0-9a-f]\{5}/
	"syn match myXxdHex5 contained /[ 0-9a-f]\{5}/
	"syn match myXxdHex6 contained /[ 0-9a-f]\{5}/
	"syn match myXxdHex7 contained /[ 0-9a-f]\{5}/
	"syn match myXxdHex8 contained /[ 0-9a-f]\{5}/
	"syn match myXxdString1 contained /../
	"syn match myXxdString2 contained /../
	"syn match myXxdString3 contained /../
	"syn match myXxdString4 contained /../
	"syn match myXxdString5 contained /../
	"syn match myXxdString6 contained /../
	"syn match myXxdString7 contained /../
	"syn match myXxdString8 contained /../

	"syn region myXxdHexRegion1 matchgroup=myXxdHexRegionMark1 excludenl start=@^\x\{8}:@ end=@\%([ 0-9a-f]\{5}\)\{,7}\s\{2,}@ contains=myXxdHexRegion2,myXxdHex1
	" }}}

	" {{{
	"syn match myXxdHex1 containedin=ALL /^\x\{8}:\zs[ 0-9a-f]\{5}/
	"syn match myXxdHex2 containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{1}\zs[ 0-9a-f]\{5}/
	"syn match myXxdHex3 containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{2}\zs[ 0-9a-f]\{5}/
	"syn match myXxdHex4 containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{3}\zs[ 0-9a-f]\{5}/
	"syn match myXxdHex5 containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{4}\zs[ 0-9a-f]\{5}/
	"syn match myXxdHex6 containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{5}\zs[ 0-9a-f]\{5}/
	"syn match myXxdHex7 containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{6}\zs[ 0-9a-f]\{5}/
	"syn match myXxdHex8 containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{7}\zs[ 0-9a-f]\{5}/
	"syn match myXxdString1 containedin=ALL /\s\{2,}\zs../
	"syn match myXxdString2 containedin=ALL /\s\{2,}\%(..\)\{1}\zs../
	"syn match myXxdString3 containedin=ALL /\s\{2,}\%(..\)\{2}\zs../
	"syn match myXxdString4 containedin=ALL /\s\{2,}\%(..\)\{3}\zs../
	"syn match myXxdString5 containedin=ALL /\s\{2,}\%(..\)\{4}\zs../
	"syn match myXxdString6 containedin=ALL /\s\{2,}\%(..\)\{5}\zs../
	"syn match myXxdString7 containedin=ALL /\s\{2,}\%(..\)\{6}\zs../
	"syn match myXxdString8 containedin=ALL /\s\{2,}\%(..\)\{7}\zs../
	" }}}

	" {{{
	syn match myXxdHex1 display containedin=ALL /^\x\{8}:[ 0-9a-f]\{5}/hs=s+9
	syn match myXxdHex2 display containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{1}[ 0-9a-f]\{5}/hs=s+14
	syn match myXxdHex3 display containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{2}[ 0-9a-f]\{5}/hs=s+19
	syn match myXxdHex4 display containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{3}[ 0-9a-f]\{5}/hs=s+24
	syn match myXxdHex5 display containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{4}[ 0-9a-f]\{5}/hs=s+29
	syn match myXxdHex6 display containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{5}[ 0-9a-f]\{5}/hs=s+34
	syn match myXxdHex7 display containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{6}[ 0-9a-f]\{5}/hs=s+39
	syn match myXxdHex8 display containedin=ALL /^\x\{8}:\%([ 0-9a-f]\{5}\)\{7}[ 0-9a-f]\{5}/hs=s+44
	syn match myXxdString1 display containedin=ALL /\s\{2,}../hs=s+2
	syn match myXxdString2 display containedin=ALL /\s\{2,}\%(..\)\{1}../hs=s+4
	syn match myXxdString3 display containedin=ALL /\s\{2,}\%(..\)\{2}../hs=s+6
	syn match myXxdString4 display containedin=ALL /\s\{2,}\%(..\)\{3}../hs=s+8
	syn match myXxdString5 display containedin=ALL /\s\{2,}\%(..\)\{4}../hs=s+10
	syn match myXxdString6 display containedin=ALL /\s\{2,}\%(..\)\{5}../hs=s+12
	syn match myXxdString7 display containedin=ALL /\s\{2,}\%(..\)\{6}../hs=s+14
	syn match myXxdString8 display containedin=ALL /\s\{2,}\%(..\)\{7}../hs=s+16
	" }}}

	" {{{
	" syn match myXxdHex1 display containedin=ALL /\%>10v.\{4}\%<16v/
	" "syn match myXxdHex2 display containedin=ALL /\%>15v.\{4}\%<21v/
	" "syn match myXxdHex3 display containedin=ALL /\%>20v.\{4}\%<26v/
	" "syn match myXxdHex4 display containedin=ALL /\%>25v.\{4}\%<31v/
	" syn match myXxdHex5 display containedin=ALL /\%>30v.\{4}\%<36v/
	" "syn match myXxdHex6 display containedin=ALL /\%>35v.\{4}\%<41v/
	" "syn match myXxdHex7 display containedin=ALL /\%>40v.\{4}\%<46v/
	" "syn match myXxdHex8 display containedin=ALL /\%>45v.\{4}\%<51v/
	" syn match myXxdString1 display containedin=ALL /\%>51v.\{2}\%<55v/
	" "syn match myXxdString2 display containedin=ALL /\%>53v.\{2}\%<57v/
	" "syn match myXxdString3 display containedin=ALL /\%>55v.\{2}\%<59v/
	" "syn match myXxdString4 display containedin=ALL /\%>57v.\{2}\%<61v/
	" syn match myXxdString5 display containedin=ALL /\%>59v.\{2}\%<63v/
	" "syn match myXxdString6 display containedin=ALL /\%>61v.\{2}\%<65v/
	" "syn match myXxdString7 display containedin=ALL /\%>63v.\{2}\%<67v/
	" syn match myXxdString8 display containedin=ALL /\%>65v.\{2}\%<69v/
	" }}}

	hi myXxd1 guifg=Green
	hi myXxd2 guifg=Yellow
	hi myXxd3 guifg=Pink
	hi myXxd4 guifg=Orange
	hi myXxd5 guifg=Green
	hi myXxd6 guifg=Yellow
	hi myXxd7 guifg=Pink
	hi myXxd8 guifg=Orange

	hi link myXxdHex1 myXxd1
	hi link myXxdHex2 myXxd2
	hi link myXxdHex3 myXxd3
	hi link myXxdHex4 myXxd4
	hi link myXxdHex5 myXxd5
	hi link myXxdHex6 myXxd6
	hi link myXxdHex7 myXxd7
	hi link myXxdHex8 myXxd8
	hi link myXxdString1 myXxd1
	hi link myXxdString2 myXxd2
	hi link myXxdString3 myXxd3
	hi link myXxdString4 myXxd4
	hi link myXxdString5 myXxd5
	hi link myXxdString6 myXxd6
	hi link myXxdString7 myXxd7
	hi link myXxdString8 myXxd8

endf

func! MyXxdSyntaxHightlightClear() abort
	syn clear myXxdHex1
	syn clear myXxdHex2
	syn clear myXxdHex3
	syn clear myXxdHex4
	syn clear myXxdHex5
	syn clear myXxdHex6
	syn clear myXxdHex7
	syn clear myXxdHex8
	syn clear myXxdString1
	syn clear myXxdString2
	syn clear myXxdString3
	syn clear myXxdString4
	syn clear myXxdString5
	syn clear myXxdString6
	syn clear myXxdString7
	syn clear myXxdString8
endf
" }}}

" {{{ My Script

let s:my_script_vimrc = $VIMHOME . '/secret/my_script.vimrc'
if filereadable(s:my_script_vimrc)
	exe 'source' s:my_script_vimrc
endif

" }}}

" {{{ vim-easy-align

xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" }}}

" {{{ GitGutter

if !empty(globpath(&rtp, 'autoload/gitgutter.vim'))
	nmap [h <Plug>(GitGutterPrevHunk)
	nmap ]h <Plug>(GitGutterNextHunk)

	let g:gitgutter_enabled = 1
	let g:gitgutter_diff_args = "--ignore-cr-at-eol"
	let g:gitgutter_sign_removed_first_line = '^^'
	let g:gitgutter_sign_removed_above_and_below = '_^'

	autocmd BufWritePost,WinEnter * GitGutter
endif

" }}}

" {{{ fugitive

nnoremap <leader>gs :<C-U>Gstatus<CR>
nnoremap <leader>gd :<C-U>Gdiff<CR>

" }}}

" {{{ LightLine

let g:lightline = {
			\ 'mode_map': {'c': 'NORMAL'},
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'tagname' ] ],
			\   'right': [ [ 'lineinfo' ],
			\            [ 'percent' ],
			\            [ 'highlight', 'fileformat', 'fileencoding', 'filetype' ] ]
			\ },
			\ 'component_function': {
			\   'modified': 'LightlineModified',
			\   'readonly': 'LightlineReadonly',
			\   'fugitive': 'LightlineFugitive',
			\   'filename': 'LightlineFilename',
			\   'fileformat': 'LightlineFileformat',
			\   'filetype': 'LightlineFiletype',
			\   'fileencoding': 'LightlineFileencoding',
			\   'mode': 'LightlineMode',
			\   'highlight' : 'LightlineHightlight',
			\   'tagname' : 'LightlineTagName'
			\ }
			\ }

function! LightlineModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightlineFilename()
	return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
				\ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
				\  &ft == 'unite' ? unite#get_status_string() :
				\  &ft == 'vimshell' ? vimshell#get_status_string() :
				\ '' != expand('%:t') ? expand('%') : '[No Name]') .
				\ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
	if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
		return fugitive#head()
	else
		return ''
	endif
endfunction

function! LightlineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
	return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()

	"if winwidth(0) > 60
	"	return ''
	"endif

	return expand('%:t') ==# '__Tagbar__' ? 'Tagbar':
				\ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
				\ &filetype ==# 'unite' ? 'Unite' :
				\ &filetype ==# 'vimfiler' ? 'VimFiler' :
				\ &filetype ==# 'vimshell' ? 'VimShell' :
				\ lightline#mode()
endfunction

function! LightlineHightlight()
	if exists('g:loaded_tanikawa') && g:loaded_tanikawa
		return winwidth(0) > 100 ? tanikawa#show_highlight#ShowHlItem() : ''
	else
		return ''
	endif
endfunction

function! LightlineTagName()
	if exists('g:loaded_tagbar') && g:loaded_tagbar
		return tagbar#currenttag('%s', '')
	else
		return ''
	endif
endfunction

" }}}

" {{{ Jplus

nmap J <Plug>(jplus)
vmap J <Plug>(jplus)

nmap <Leader>J <Plug>(jplus-input)
vmap <Leader>J <Plug>(jplus-input)

" }}}

" {{{ CtrlP

let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp/'.&enc
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn)$|' . escape($VIM,' /\'),
			\ 'file': '\v\.(exe|so|dll)$',
			\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
			\ }
function! MigemoMatch(items, str, limit, mmode, ispath, crfile, regex)
	if a:str =~ '^\s*$'
		return copy(a:items)
	endif
	let ptns = split(a:str)
	let migemos = []
	for ptn in ptns
		let migemos += [migemo(ptn)]
	endfor
	let migemo_ptn = join(migemos, '\|')
	let output = []
	for item in a:items
		let ml = matchlist(item, migemo_ptn)
		if 0 < len(ml)
			call matchadd('CtrlPMatch', ml[0])
			call matchadd('CtrlPLinePre', '^>')
			let output += [ item ]
		endif
	endfor
	return copy(output)
endfunction
"let g:ctrlp_match_func = {'match' : 'MigemoMatch' }
"let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}

" }}}

" {{{ Tagbar

nnoremap <silent> <F9> :TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

" }}}

" {{{ PartEdit

let g:partedit#opener = "tabnew"

" }}}

" {{{ LSP

" https://mattn.kaoriya.net/software/vim/20191231213507.htm
function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	setlocal signcolumn=yes
	nmap <buffer> gd <plug>(lsp-definition)
	nmap <buffer> <f2> <plug>(lsp-rename)
	inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction

augroup lsp_install
	au!
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

" }}}

" {{{ AsyncComplete

let g:asyncomplete_auto_popup = 0
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200

" }}}

" {{{ Migemo

let &migemodict = $VIMHOME . "/dict/".&enc."/migemo-dict"

" }}}

" DEBUG
"let g:gitgutter_log = 1

" vim: fdm=marker
