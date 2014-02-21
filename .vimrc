"-----------------------------------------------------------------------------------"
" Mappings                                                                          |
"-----------------------------------------------------------------------------------"
" コマンド        | ノーマル | 挿入 | コマンドライン | ビジュアル | 選択 | 演算待ち |
" map  / noremap  |    @     |  -   |       -        |     @      |  @   |    @     |
" nmap / nnoremap |    @     |  -   |       -        |     -      |  -   |    -     |
" vmap / vnoremap |    -     |  -   |       -        |     @      |  @   |    -     |
" omap / onoremap |    -     |  -   |       -        |     -      |  -   |    @     |
" xmap / xnoremap |    -     |  -   |       -        |     @      |  -   |    -     |
" smap / snoremap |    -     |  -   |       -        |     -      |  @   |    -     |
" map! / noremap! |    -     |  @   |       @        |     -      |  -   |    -     |
" imap / inoremap |    -     |  @   |       -        |     -      |  -   |    -     |
" cmap / cnoremap |    -     |  -   |       @        |     -      |  -   |    -     |
"-----------------------------------------------------------------------------------"
"-------------------
".vimrc編集ショートカット
"-------------------

nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>sv :<C-u>source $MYVIMRC<CR>

"----------------------
"neobundle
"----------------------
filetype off
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" doc
NeoBundle 'vim-scripts/vimdoc-ja'

" unite
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 't9md/vim-unite-ack'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'tsukkee/unite-tag'

" web on vim
NeoBundle 'choplin/unite-vim_hacks'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/wwwrenderer-vim'
NeoBundle 'thinca/vim-openbuf'

" syntax
NeoBundle 'othree/html5.vim'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'othree/javascript-libraries-syntax.vim'

" development:general
NeoBundle 'Align'
NeoBundle 'sudo.vim'
NeoBundle 'vim-scripts/catn.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-surround'
NeoBundle 'deton/jasegment.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'rhysd/clever-f.vim'
"NeoBundle 'kakkyz81/evervim'
"NeoBundle 'osyo-manga/vim-over'

" development:frontend
NeoBundle 'mattn/emmet-vim'
NeoBundle 'jiangmiao/simple-javascript-indenter'

" development:backend


" colorscheme
NeoBundle 'itchyny/lightline.vim'

NeoBundle 'mopp/mopkai.vim'
NeoBundle 'baskerville/bubblegum'
NeoBundle 'altercation/solarized'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'vim-scripts/desert256.vim'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'therubymug/vim-pyte'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'vim-scripts/rdark'
NeoBundle 'reloaded.vim'
NeoBundle 'chlordane.vim'
NeoBundle 'vim-scripts/jammy.vim'

NeoBundle 'thinca/vim-scouter'
NeoBundle 'deris/vim-duzzle'

"ja
NeoBundle 'fuenor/JpFormat.vim'

"--------------------
" vimproc
" ------------------

"--------------------
" vimfiler
" ------------------
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default = 0

nnoremap <silent> <C-U>f :VimFiler -split -auto-cd -simple -winwidth=35 -toggle -no-quit <CR>
nnoremap <silent> <C-U><C-F> :VimFiler -split -auto-cd -simple -winwidth=35 -toggle -no-quit <CR>

autocmd! FileType vimfiler call g:my_vimfiler_settings()

function! g:my_vimfiler_settings()
  nmap     <silent> <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
  nnoremap <silent> <buffer>s :call vimfiler#mappings#do_action('my_split')<Cr>
  nnoremap <silent> <buffer>v :call vimfiler#mappings#do_action('my_vsplit')<Cr>
endfunction

let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
  wincmd p
  exec 'split '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_split', s:my_action)

let s:my_action = { 'is_selectable' : 1 }
function! s:my_action.func(candidates)
  wincmd p
  exec 'vsplit '. a:candidates[0].action__path
endfunction
call unite#custom_action('file', 'my_vsplit', s:my_action)

"-----------
"unite
"----------
"unite prefix key.
nnoremap [unite] <Nop>
nmap <C-U> [unite]
let g:unite_enable_start_insert=1
let g:unite_enable_ignore_case=1
let g:unite_enable_smart_case=1
let g:unite_update_time = 100
let g:unite_enable_split_vertically=1
let g:unite_winwidth = 100
let g:unite_split_rule = 'rightbelow'

" バッファ一覧
noremap [unite]b :Unite buffer<CR>
noremap [unite]<C-B> :Unite buffer<CR>
" 最近使ったファイルの一覧
noremap [unite]m :Unite file_mru<CR>
noremap [unite]<C-M> :Unite file_mru<CR>
" レジスタ一覧
nnoremap [unite]r :Unite -buffer-name=register register<CR>
nnoremap [unite]<C-R> :Unite -buffer-name=register register<CR>
"ブックマーク一覧
nnoremap [unite]c :Unite bookmark<CR>
nnoremap [unite]<C-C> :Unite bookmark<CR>
"ブックマークに追加
nnoremap [unite]a :UniteBookmarkAdd<CR>
nnoremap [unite]<C-A> :UniteBookmarkAdd<CR>
"vim hacks
nnoremap [unite]h :Unite vim_hacks<CR>
nnoremap [unite]<C-H> :Unite vim_hacks<CR>
"vim outline
nnoremap [unite]o :Unite outline<CR>
nnoremap [unite]<C-O> :Unite outline<CR>
" 全部乗せ
nnoremap [unite]<C-U> :Unite -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-S> unite#do_action('below')
au FileType unite inoremap <silent> <buffer> <expr> <C-S> unite#do_action('below')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-V> unite#do_action('right')
au FileType unite inoremap <silent> <buffer> <expr> <C-V> unite#do_action('right')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" unite-grepをsilver searcherに
""if executable('ag')
""  let g:unite_source_grep_command = 'ag'
""  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
""  let g:unite_source_grep_recursive_opt = ''
""  let g:unite_source_grep_max_candidates = 200
""endif


"--------------------
" neocomplcache/neocomplete
" ------------------
function! s:meet_neocomplete_requirements()
  return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

if s:meet_neocomplete_requirements()
  NeoBundle 'Shougo/neocomplete.vim'
  NeoBundleFetch 'Shougo/neocomplcache.vim'
else
  NeoBundleFetch 'Shougo/neocomplete.vim'
  NeoBundle 'Shougo/neocomplcache.vim'
endif

if s:meet_neocomplete_requirements()
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_camel_case_completion = 1
  let g:neocomplete#enable_underbar_completion = 1
  let g:neocomplete#smart_case = 1
  let g:neocomplete#min_syntax_length = 2
  let g:neocomplete#manual_completion_start_length = 0
  let g:neocomplete#caching_percent_in_statusline = 1
  let g:neocomplete#enable_skip_completion = 1

  let $DOTVIM = $HOME . '/.vim'
  let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'javascript' : $DOTVIM.'/dict/javascript.dict',
      \ 'php' : $DOTVIM.'/dict/php.dict'
          \ }
else
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_underbar_completion = 1
  let g:neocomplcache_smart_case = 1
  let g:neocomplcache_min_syntax_length = 2
  let g:neocomplcache_manual_completion_start_length = 0
  let g:neocomplcache_caching_percent_in_statusline = 1
  let g:neocomplcache_enable_skip_completion = 1
endif

"--------------------
" Align
" ------------------
let g:Align_xstrlen = 3

"------------
"lightline
"------------

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
      \   'filename': 'MyFilename'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! MyFugitive()
  return exists('*fugitive#head') && strlen(fugitive#head()) ? ' '.fugitive#head() : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != expand('%t') ? expand('%t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

"--------------------
"emmet
"--------------------
"ショートカットキー変更
let g:user_emmet_expandabbr = '<C-C>'
"zencodingのインデントをタブに変換する
"zencodingのenをjaに変更する
let g:user_emmet_settings = { 'indentation':'  ', 'lang':'ja'}

"--------------------
"vim-quickrun
"--------------------
:command! Qr :QuickRun

"--------------------
"vim-fugitive
"--------------------
nnoremap <C-g>s :Gstatus<CR>
nnoremap <C-g>a :Gwrite<CR>
nnoremap <C-g>r :Gread<CR>
nnoremap <C-g>c :Gcommit<CR>
nnoremap <C-g>b :Gblame<CR>
nnoremap <C-g>d :Gdiff<CR>
nnoremap <C-g>v :Gitv<CR>

"--------------------
" syntastic
"--------------------
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

"--------------------
" simple javascript indenter
"--------------------
let g:SimpleJsIndenter_BriefMode=1

"-----------------------
" 表示系
"-----------------------

set t_co=256

" カーソルの色
autocmd ColorScheme * hi CursorLine term=underline cterm=none ctermbg=237
" タブラインの色
autocmd ColorScheme * hi TabLineSel  term=bold cterm=underline,bold ctermfg=White ctermbg=Black gui=bold,underline guifg=LightGray guibg=DarkBlue
autocmd ColorScheme * hi TabLine     term=reverse ctermfg=Gray ctermbg=black guifg=Black guibg=black
autocmd ColorScheme * hi TabLineFill term=bold cterm=underline,bold ctermfg=Gray ctermbg=black gui=reverse,bold guifg=black guibg=black
"補完メニューの色
autocmd ColorScheme * hi Pmenu ctermfg=73 ctermbg=16 guifg=#66D9EF guibg=#000000
autocmd ColorScheme * hi PmenuSel ctermfg=252 ctermbg=23 guibg=#808080
autocmd ColorScheme * hi PmenuSbar ctermbg=232 guibg=#080808
autocmd ColorScheme * hi PmenuThumb ctermfg=103 ctermbg=15 guifg=#66D9EF guibg=White

set background=dark
syntax enable
colorscheme railscasts

set number
set helplang=ja,en
set showmode         " モード表示
set title            " 編集中のファイル名を表示
set ruler            " ルーラーの表示
set showcmd          " 入力中のコマンドをステータスに表示する
set showmatch        " 括弧入力時の対応する括弧を表示
set laststatus=2     " ステータスラインを常に表示
set cursorline       " 下線
set wrap           " 画面幅で折り返す
set list             " 不可視文字表示
set listchars=tab:>\  " 不可視文字の表示方法
set display=uhex     " 印字不可能文字を16進数で表示
set nf=hex           " 数値インクリメントは10進数か16進数
set splitbelow       " 水平分割時は新しいwindowを下に
set splitright       " 垂直分割時は新しいwindowを右に

augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

"-------------------------------
" 行文字
"------------------------------
:command! Nonum :set nonumber
:command! Num :set number

"-------------------------------
"検索系
"------------------------------
set wrapscan        " 最後まで検索したら先頭へ戻る
set ignorecase      " 大文字小文字無視
set smartcase       " 大文字ではじめたら大文字小文字無視しない
set incsearch       " インクリメンタルサーチ
"set hlsearch        " 検索文字をハイライト

"esc2回でハイライトを消す
nnoremap <ESC><ESC> :noh<cr>

"---------------------------------
"ファイル操作
"--------------------------------
set autoread                        " 更新時自動再読込み
set hidden                          " 編集中でも他のファイルを開けるようにする
set noswapfile                      " スワップファイルを作らない
set nobackup                        " バックアップを取らない
autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去する

" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"Unite Beautiful Attack!
:command! Uba :Unite -auto-preview colorscheme

"ヘルプを水平分割に
nnoremap H q:vert help<space>

"backspaceの挙動
set backspace=start,eol,indent

"vim縛りプレイ
noremap <Right> <Nop>
noremap <Left> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Del> <Nop>

"挿入モード便利キー
noremap! <C-P> <Up>
noremap! <C-N> <Down>
noremap! <C-F> <Right>
noremap! <C-B> <Left>
noremap! <C-D> <Del>

"加算
"screenと被るので、<C-Z>へ
noremap <C-Z> <C-A>

"command line windowを表示
"swap semicolon and colon
noremap : ;
noremap ; q:
noremap / q/
noremap ? q?
noremap S q:%s/\v
vnoremap S q:s/\v

set scrolloff=5
set history=1000
set cmdwinheight=5

autocmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  nnoremap <buffer> <silent> <Esc><Esc> :<C-u>quit<CR>
  inoremap <buffer> <silent> <Esc><Esc> <Esc>:<C-u>quit<CR>
  startinsert!
endfunction

" 検索時語句を中心にする
nnoremap n nzz
nnoremap N Nzz

" ----------------------------------------
" <t> commands
" ウィンドウ、タブ、バッファの分割・移動
" ----------------------------------------
" タブ移動
nnoremap <silent> <C-T>l :<C-u>tabnext<CR>
nnoremap <silent> <C-T>h :<C-u>tabprevious<CR>

" タブ操作
nnoremap <silent> <C-T>t :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> <C-T><C-T> :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> <C-T>d :<C-u>tabclose<CR>
nnoremap <silent> <C-T><C-D> :<C-u>tabclose<CR>

" ウィンドウの分割<C-T>
nnoremap <silent> <C-T>v :<C-u>vsp<CR>
nnoremap <silent> <C-T>s :<C-u>sp<CR>

"<C-d>とあわせて左手だけでスクロール
nnoremap <C-e> <C-u>
vnoremap <C-e> <C-u>

set tabline=%!MyTabLine()

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let label =  bufname(buflist[winnr - 1])
  let label = fnamemodify(label, ":t")

  "タブ番号を付加
  let label = a:n . ':' . label

  return label
endfunction

"---------------
"タブキーの処理
"--------------
set expandtab
set tabstop=2
set softtabstop=0
set shiftwidth=2
set smartindent

" 行末の空白文字を可視化
highlight WhitespaceEOL cterm=underline ctermbg=red guibg=red
au BufWinEnter * let w:m1 = matchadd("WhitespaceEOL", ' +$')

" 行頭のTAB文字を可視化
highlight TabString ctermbg=red guibg=red
au BufWinEnter * let w:m2 = matchadd("TabString", '^\t+')
au WinEnter * let w:m2 = matchadd("TabString", '^\t+')

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermbg=red guibg=red
au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

" ファイル読み込み時の文字コード検索順
set termencoding=utf-8
set enc=utf-8
set fencs=utf-8,ucs-bom,euc-jp,cp932,iso-2022-jp,ucs-2le,ucs-2,utf-8
set ffs=unix,mac,dos

"file format
command! Unix :set ff=unix
command! Dos :set ff=dos
command! Mac :set ff=mac

filetype plugin indent on
