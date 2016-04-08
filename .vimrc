"-----------------------------------------------------------------------------------"
"
" Mappings                                                                          |
"-----------------------------------------------------------------------------------"
" コマンド        | ノーマル | 挿入 | コマンドライン | ビジュアル | 選択 | 演算待ち |
" map  / noremap  |    @     |  -   |       -        |     @      |  @   |    @     |
" map! / noremap! |    -     |  @   |       @        |     -      |  -   |    -     |
" nmap / nnoremap |    @     |  -   |       -        |     -      |  -   |    -     |
" imap / inoremap |    -     |  @   |       -        |     -      |  -   |    -     |
" cmap / cnoremap |    -     |  -   |       @        |     -      |  -   |    -     |
" vmap / vnoremap |    -     |  -   |       -        |     @      |  @   |    -     |
" xmap / xnoremap |    -     |  -   |       -        |     @      |  -   |    -     |
" smap / snoremap |    -     |  -   |       -        |     -      |  @   |    -     |
" omap / onoremap |    -     |  -   |       -        |     -      |  -   |    @     |
"-----------------------------------------------------------------------------------"
"check mappings
":help index.txt
":map
":nmap   " ノーマルモードだけ表示
":imap   " インサートモードだけ表示
":vmap   " ビジュアルモードだけ表示

"-------------------
".vimrc編集ショートカット
"-------------------
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>et :<C-u>edit $HOME/.vim/dein.toml<CR>
nnoremap <silent> <Space>eg :<C-u>edit ~/dotfiles/.zprezto/modules/git/alias.zsh<CR>
nnoremap <silent> <Space>sv :<C-u>source $MYVIMRC<CR>

"----------------------
"dein
"----------------------
filetype off
filetype plugin indent off

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim.bundle')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  let s:toml      = '~/.vim/dein.toml'
  let s:lazy_toml = '~/.vim/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  "call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものがあったらインストール
if dein#check_install()
  call dein#install()
endif

"--------------------
" vimfiler
" ------------------
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default = 0

nnoremap <silent> <space>f :VimFiler -split -simple -explorer -winwidth=36 -toggle  -find<CR>

autocmd! FileType vimfiler call s:my_vimfiler_settings()

function! s:my_vimfiler_settings()
  nmap <buffer><C-Q> <Plug>(vimfiler_hide)
  nmap <buffer>H <Plug>(vimfiler_switch_to_parent_directory)
  nmap <buffer>L <Plug>(vimfiler_cd_or_edit)
  nnoremap <silent> <buffer>s :call vimfiler#mappings#do_action('my_split')<Cr>
  nnoremap <silent> <buffer>v :call vimfiler#mappings#do_action('my_vsplit')<Cr>
  nmap <buffer><space>w [myWindow]
  nmap <buffer><space>t [myWindowTab]
  nmap <S-Space> <Plug>(vimfiler_toggle_mark_current_line)
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
nmap <space>u [unite]
let g:unite_enable_start_insert=1
let g:unite_enable_ignore_case=1
let g:unite_enable_smart_case=1
let g:unite_update_time = 100
let g:unite_enable_split_vertically=1
let g:unite_winwidth = 70
let g:unite_split_rule = 'rightbelow'
let g:unite_source_history_yank_enable = 1

" バッファ一覧
noremap [unite]b :Unite buffer<CR>
" 最近使ったファイルの一覧
noremap [unite]m :Unite file_mru<CR>
" カレントディレクトリ以下のファイル
nnoremap [unite]f :Unite file_rec/async:!<CR>
" レジスタ一覧
nnoremap [unite]R :Unite -buffer-name=register register<CR>
"ブックマーク一覧
nnoremap [unite]c :Unite bookmark<CR>
"ブックマークに追加
nnoremap [unite]a :UniteBookmarkAdd<CR>
"vim hacks
nnoremap [unite]h :Unite vim_hacks<CR>
"vim outline
nnoremap [unite]o :Unite outline<CR>
"yank histroy
nnoremap [unite]y :Unite history/yank<CR>
" 全部乗せ
nnoremap [unite]u :Unite -buffer-name=files buffer file_mru bookmark file<CR>

"unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:my_unite_settings()
function! s:my_unite_settings()
  " ウィンドウを分割して開く
  nnoremap <silent> <buffer> <expr> <C-S> unite#do_action('below')
  inoremap <silent> <buffer> <expr> <C-S> unite#do_action('below')
  " ウィンドウを縦に分割して開く
  nnoremap <silent> <buffer> <expr> <C-V> unite#do_action('right')
  inoremap <silent> <buffer> <expr> <C-V> unite#do_action('right')
  " C-Qで終了
  nmap <silent> <buffer> <C-Q> <Plug>(unite_exit)
  imap <silent> <buffer> <C-Q> <Plug>(unite_exit)
endfunction

" unite-grepをsilver searcherに
"if executable('ag')
"  let g:unite_source_grep_command = 'ag'
"  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
"  let g:unite_source_grep_recursive_opt = ''
"  let g:unite_source_grep_max_candidates = 200
"endif

"--------------------
" neocomplcache/neocomplete
" ------------------
if dein#tap('neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_camel_case_completion = 1
  let g:neocomplete#enable_underbar_completion = 1
  let g:neocomplete#smart_case = 1
  let g:neocomplete#min_syntax_length = 3
  let g:neocomplete#auto_completion_start_length = 3
  let g:neocomplete#manual_completion_start_length = 3
  let g:neocomplete#enable_skip_completion = 1
  let g:neocomplete#enable_auto_select = 0
  let g:neocomplete#max_list = 20

  let $DOTVIM = $HOME . '/.vim'
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'javascript' : $DOTVIM.'/dict/javascript.dict',
        \ 'php' : $DOTVIM.'/dict/php.dict'
        \ }
endif

"--------------------
" Neosnippet
"--------------------

"" Plugin key-mappings.
"imap <Tab> <Plug>(neosnippet_expand_or_jump)
"smap <Tab> <Plug>(neosnippet_expand_or_jump)
"
"" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets'

" SuperTab like snippets behavior.
imap <expr><TAB>
      \ pumvisible() ? "\<Plug>(neosnippet_expand_or_jump)" :
      \ neosnippet#expandable_or_jumpable() ?
      \   "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif
set conceallevel=0
let g:vim_json_syntax_conceal = 0

"--------------------
" Tweetvim
"--------------------
nnoremap <silent> [unite]t :Unite tweetvim<CR>
nnoremap <silent> [unite]<c-t> :Unite tweetvim<CR>
nnoremap <silent> <space>ts :TweetVimSay<CR>


"--------------------
" Align
" ------------------
let g:Align_xstrlen = 3

"--------------------
" matchit
" ------------------
let b:match_ignorecase = 1

"------------
"lightline
"------------
set background=dark
colorscheme mopkai

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'enable': {
      \   'statusline': 1,
      \   'tabline': 0
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'jpmode', 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
      \   'filename': 'MyFilename',
      \   'jpmode': 'MyJpMode'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

function! MyJpMode()
  if exists('IMState')
    if IMState == 2
      return "[JPMode]"
    elseif IMState == 0
      return ""
    endif
  else
    return ""
  endif
endfunction

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
"imap <c-c> = nop
let g:user_emmet_leader_key = '<c-c>'
let g:user_emmet_settings = {
      \  'indentation': '  ',
      \  'lang':'ja',
      \  'custom_expands1': {
      \    '^\%(lorem\|lipsum\)\(\d*\)$' : function('emmet#lorem#ja#expand'),
      \  },
      \  'html' : {
      \    'filters' : 'html',
      \    'indentation' : '  '
      \  },
      \  'css' : {
      \    'filters' : 'fc',
      \  },
      \  'php' : {
      \    'extends' : 'html',
      \    'filters' : 'html,c',
      \  }
      \}

"--------------------
"vim-quickrun
"--------------------
"nnoremap <C-q>r :QuickRun<CR>
"let g:quickrun_config['babel'] = {
"      \ 'cmdopt': '--stage 1',
"      \ 'exec': "babel %o %s | node"
"      \ }
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
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=2
let g:syntastic_mode_map={ 'mode': 'active',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': ['html'] }


"--------------------
" simple javascript indenter
"--------------------
"let g:SimpleJsIndenter_BriefMode=1

"--------------------
" php completion
"--------------------
"let g:phpcomplete_extended_auto_add_use = 0
"let g:phpcomplete_index_composer_command = "composer"
"let g:phpcomplete_extended_use_default_mapping = 0

"--------------------
" Indent guide
"--------------------
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

"--------------------
" Markdown
"--------------------
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a "Google Chrome"'

"-----------------------
" 表示系
"-----------------------
set t_Co=256

"" カーソルの色
"autocmd ColorScheme * hi CursorLine term=underline cterm=none ctermbg=237
"" タブラインの色
autocmd ColorScheme * hi TabLineSel  term=bold cterm=underline,bold ctermfg=White ctermbg=Black gui=bold,underline guifg=LightGray guibg=DarkBlue
autocmd ColorScheme * hi TabLine     term=reverse cterm=underline ctermfg=Gray ctermbg=black guifg=Black guibg=black
autocmd ColorScheme * hi TabLineFill term=bold cterm=underline,bold ctermfg=Gray ctermbg=black gui=reverse,bold guifg=black guibg=black

""補完メニューの色
autocmd ColorScheme * hi Pmenu ctermfg=73 ctermbg=16 guifg=#66D9EF guibg=#000000
autocmd ColorScheme * hi PmenuSel ctermfg=252 ctermbg=23 guibg=#808080
autocmd ColorScheme * hi PmenuSbar ctermbg=232 guibg=#080808
autocmd ColorScheme * hi PmenuThumb ctermfg=103 ctermbg=15 guifg=#66D9EF guibg=White
" vimfiler 名前変更時の文字色
" autocmd ColorScheme * hi Todo term=standout ctermfg=yellow ctermbg=11 gui=italic guifg=#BC9458

syntax enable
set nonumber
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
nnoremap <silent> <ESC><ESC> :noh<cr>

" tags
"set tags&
"set tags+=plugins/tags,lib/vendor/tags,tags;
if has('path_extra')
  set tags+=tags;
endif
nnoremap <C-O> <C-T>
"let g:auto_ctags = 1
let g:auto_ctags_directory_list = ['.git', '.svn']
let g:auto_ctags_tags_args = '--tag-relative --recurse --sort=yes --exclude=*.js'

if dein#tap('incsearch.vim')
  map / <Plug>(incsearch-forward)
  map ? <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  highlight IncSearchCursor ctermfg=0 ctermbg=9 guifg=#000000 guibg=#FF0000
  set hlsearch | nohlsearch
  let g:incsearch#auto_nohlsearch = 1
  let g:incsearch#consistent_n_direction = 1
  let g:incsearch#do_not_save_error_message_history = 1
  map  n <Plug>(incsearch-nohl-n)
  map  N <Plug>(incsearch-nohl-N)
endif

"---------------------------------
"ファイル操作
"--------------------------------
set autoread                        " 更新時自動再読込み
set hidden                          " 編集中でも他のファイルを開けるようにする
set noswapfile                      " スワップファイルを作らない
set nobackup                        " バックアップを取らない
"autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去する

" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

"Unite Beautiful Attack!
command! Uba :Unite -auto-preview colorscheme

"ヘルプを水平分割に
nnoremap H q:vert help<space>

"backspaceの挙動
set backspace=start,eol,indent

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
"noremap ; :
noremap ; q:
noremap q; :

augroup RemapSubstitutme
  autocmd VimEnter * noremap S q:%s/\v
  autocmd VimEnter * vnoremap S q:s/\v
augroup END

set scrolloff=0
set history=1000
set cmdwinheight=3

autocmd CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  nnoremap <buffer> <silent> <Esc><Esc> :<C-u>quit<CR>
  inoremap <buffer> <silent> <Esc><Esc> <Esc>:<C-u>quit<CR>
  startinsert!
endfunction

" 検索時語句を中心にする
nnoremap * *zz
nnoremap n nzz
nnoremap N Nzz

" ----------------------------------------
" <t> commands
" ウィンドウ、タブ、バッファの分割・移動
" Window Tab Buffer
" ----------------------------------------
nmap <space>t [myWindowTab]
nmap <space>w [myWindow]

nnoremap [myWindow] <C-w>


nnoremap <silent> [myWindowTab] <Nop>
nnoremap <silent> [myWindowTab]l :<C-u>tabnext<CR>
nnoremap <silent> [myWindowTab]h :<C-u>tabprevious<CR>

nnoremap <silent> [myWindowTab]1 :<C-u>tabn 1<CR>
nnoremap <silent> [myWindowTab]2 :<C-u>tabn 2<CR>
nnoremap <silent> [myWindowTab]3 :<C-u>tabn 3<CR>
nnoremap <silent> [myWindowTab]4 :<C-u>tabn 4<CR>
nnoremap <silent> [myWindowTab]5 :<C-u>tabn 5<CR>
nnoremap <silent> [myWindowTab]6 :<C-u>tabn 6<CR>
nnoremap <silent> [myWindowTab]7 :<C-u>tabn 7<CR>
nnoremap <silent> [myWindowTab]8 :<C-u>tabn 8<CR>
nnoremap <silent> [myWindowTab]9 :<C-u>tabn 9<CR>
nnoremap <silent> [myWindowTab]0 :<C-u>tabn 10<CR>

" タブ操作
nnoremap <silent> [myWindowTab]t :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> [myWindowTab]d :<C-u>tabclose<CR>

" ウィンドウの分割<C-T>
nnoremap <silent> [myWindow]v :<C-u>vsp<CR>
nnoremap <silent> [myWindow]s :<C-u>sp<CR>

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
"set tabstop=2
set softtabstop=-1
set shiftwidth=2
"set cindent

" 行末の空白文字を可視化
highlight WhitespaceEOL cterm=underline ctermbg=red guibg=red
au BufWinEnter * let w:m1 = matchadd("WhitespaceEOL", '\ +$')
au WinEnter * let w:m1 = matchadd("WhitespaceEOL", '\ +$')

" 行頭のTAB文字を可視化
highlight TabString ctermbg=red guibg=red
au BufWinEnter * let w:m2 = matchadd("TabString", '^\t+')
au WinEnter * let w:m2 = matchadd("TabString", '^\t+')

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline
au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')

augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

" ファイル読み込み時の文字コード検索順
set termencoding=utf-8
set enc=utf-8
set fencs=utf-8,utf-16,sjis,ucs-bom,euc-jp,cp932,iso-2022-jp,ucs-2le,ucs-2
set ffs=unix,mac,dos

"file format
command! Unix :set ff=unix
command! Dos :set ff=dos
command! Mac :set ff=mac

set cmdheight=1


if has('mac')
  if has('gui_running')
    let IM_CtrlMode = 4
  else
    let IM_CtrlMode = 1

    function! IMCtrl(cmd)
      let cmd = a:cmd
      if cmd == 'On'
        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {104})" > /dev/null 2>&1')
      elseif cmd == 'Off'
        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {102})" > /dev/null 2>&1')
      elseif cmd == 'Toggle'
        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {55, 49})" > /dev/null 2>&1')
      endif
      return ''
    endfunction
  endif

  "「日本語入力固定モード」のMacVimKaoriya対策を無効化
  let IM_CtrlMacVimKaoriya = 0
  " ctrl+jで日本語入力固定モードをOnOff
  inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
  nnoremap <silent> <expr> <C-j> IMState('FixMode')
endif

set helplang=ja,en

filetype plugin indent on
