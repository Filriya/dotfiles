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

set nocompatible

"-------------------
".vimrc編集ショートカット
"-------------------
noremap <Leader> <Nop>
let mapleader = "\<Space>"

nnoremap <silent> <Leader>ev :<C-u>tabnew $MYVIMRC<CR>
nnoremap <silent> <Leader>es :<C-u>source $MYVIMRC<CR>
nnoremap <silent> <Leader>et :<C-u>tabnew $HOME/.vim/dein.toml<CR>
nnoremap <silent> <Leader>ez :<C-u>tabnew $HOME/.zshrc<CR>
nnoremap <silent> <Leader>eg :<C-u>tabnew $HOME/.zsh.d/git.zsh<CR>


"--------------
"space 系ショートカットまとめ
"--------------

" Unite
noremap <Leader>b :Unite buffer<CR>
nnoremap <Leader>u :Unite -buffer-name=files file_mru bookmark file<CR>
" nnoremap <Leader>r :Unite file_rec/async:!<CR>

nnoremap <Leader>r :Unite -buffer-name=register register<CR>
nnoremap <Leader>y :Unite history/yank<CR>
nnoremap <Leader>o :Unite outline -vertical<CR>

"ファイルのリロード
nnoremap <silent> <Leader>R :<C-u>e<CR>

" ペーストモード
nnoremap <silent> <Leader>P :<C-u>a!<CR>

" ヘルプ
nnoremap <Leader>H :vert help<space>

" 保存
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :wq<CR>
nnoremap <Leader>Q :qa!<CR>

"----------------------
"dein
"----------------------
filetype off
filetype plugin indent off

let s:dein_dir = expand('~/.vim.bundle') " プラグインが実際にインストールされるディレクトリ
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim' " dein.vim 本体

" deinが入っていなければinstall
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" 設定開始
let &runtimepath = s:dein_repo_dir .",". &runtimepath
if dein#load_state(s:dein_dir)
  let s:toml      = '~/.vim/dein.toml'
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml])
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものがあったらインストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

"--------------------
" vimfiler
" ------------------
let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_enable_auto_cd = 1
let g:vimfiler_ignore_pattern = '^\%(.git\|.DS_Store\)$'

nnoremap <silent> <C-e> :VimFiler -split -simple -explorer -winwidth=40 -toggle  -find<CR>

function! s:my_vimfiler_settings()
  nmap <silent><buffer> , <Plug>(vimfiler_toggle_mark_current_line)
  vmap <silent><buffer> , <Plug>(vimfiler_toggle_mark_selected_lines)

  nnoremap <silent><buffer> H <Plug>(vimfiler_switch_to_parent_directory)
  nnoremap <silent><buffer> L <Plug>(vimfiler_cd_or_edit)
  nnoremap <silent><buffer><expr> t vimfiler#do_switch_action('tabopen')
  nnoremap <silent><buffer><expr> v vimfiler#do_switch_action('vsplit')
  nnoremap <silent><buffer><expr> s vimfiler#do_switch_action('split')
  nnoremap <buffer><silent>? :call MyUniteFileCurrentDir()<CR>
endfunction

function! MyUniteFileCurrentDir()
    if exists('b:vimfiler.current_dir')
        let buffer_dir = b:vimfiler.current_dir
    else
        let buffer_dir = expand('%:p:h')
    endif
    let s  = ':Unite -horizontal -start-insert file_rec/async:'
    " "let s  = ':Unite file_rec -horizontal -start-insert -path='
    let s .= buffer_dir
    execute s
endfunction

set modifiable


"-----------
"unite
"----------
let g:unite_enable_start_insert=1
let g:unite_enable_ignore_case=1
let g:unite_enable_smart_case=1
let g:unite_update_time = 100
" let g:unite_enable_split_vertically=1
let g:unite_winwidth = 40
let g:unite_winheight = 10
let g:unite_split_rule = 'rightbelow'
let g:unite_source_history_yank_enable = 1
let g:unite_source_rec_max_cache_files = 0
call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 0)

"unite.vimを開いている間のキーマッピング
if dein#tap('unite.vim')
    autocmd!
    autocmd FileType unite call <SID>unite_settings()
    autocmd FileType vimfiler call s:my_vimfiler_settings()
endif

function! s:unite_settings()
    " ウィンドウを分割して開く
    nnoremap <silent><buffer><expr> <C-S> unite#do_action('below')
    inoremap <silent><buffer><expr> <C-S> unite#do_action('below')
    " ウィンドウを縦に分割して開く
    nnoremap <silent><buffer><expr> <C-V> unite#do_action('right')
    inoremap <silent><buffer><expr> <C-V> unite#do_action('right')

    " ESCで終了
    nmap <silent><buffer> <ESC> q
    nmap <silent><buffer> <C-[> q

    "unite_source別設定
    for source in unite#get_current_unite().sources
        let source_name = substitute(source.name, '[-/]', '_', 'g')
        if !empty(source_name) && has_key(s:unite_hooks, source_name)
            call s:unite_hooks[source_name]()
        endif
    endfor

endfunction

let s:unite_hooks = {}

if executable('rg')
  let g:unite_source_grep_command = 'rg'
  let g:unite_source_grep_default_opts = '-n --no-heading --color never'
  let g:unite_source_grep_recursive_opt = ''
endif

if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif


"--------------------
" neocomplcache/neocomplete
" ------------------"
" let g:auto_ctags = 1
let g:auto_ctags_directory_list = ['.git', '.svn']
let g:auto_ctags_tags_args = "--tag-relative"." "
      \ "--recurse"." "
      \ "--sort=yes"." "
      \ "--exclude=*.js"." "
      \ "--regex-php=/get([a-z|A-Z|0-9]+)Attribute/\1/"." "
      \ "--regex-php=/scope([a-z|A-Z|0-9]+)/\1/"

set tags+=.git/tags


if dein#tap('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_camel_case_completion = 1
  let g:deoplete#enable_underbar_completion = 1
  let g:deoplete#smart_case = 1
  let g:deoplete#min_syntax_length = 2

  let g:deoplete#auto_completion_start_length = 2
  let g:deoplete#manual_completion_start_length = 2
  let g:deoplete#enable_skip_completion = 1
  let g:deoplete#enable_auto_select = 0
  let g:deoplete#max_list = 500

  let $DOTVIM = $HOME . '/.vim'

  let g:deoplete#sources = {}
  let g:deoplete#sources.php = ['omni', 'phpactor', 'ultisnips', 'buffer']


elseif dein#tap('neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_camel_case_completion = 1
  let g:neocomplete#enable_underbar_completion = 1
  let g:neocomplete#smart_case = 1
  let g:neocomplete#min_syntax_length = 2

  let g:neocomplete#auto_completion_start_length = 2
  let g:neocomplete#manual_completion_start_length = 2
  let g:neocomplete#enable_skip_completion = 1
  let g:neocomplete#enable_auto_select = 0
  let g:neocomplete#max_list = 20

  let $DOTVIM = $HOME . '/.vim'
  let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : ''
        \ }
endif



" --------------------
" php documentor
" --------------------
" nnoremap <Leader>P :call PhpDocSingle()<CR>
" vnoremap <Leader>P :call PhpDocRange()<CR>

"--------------------
" Neosnippet
"--------------------

"" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets,~/.vim.bundle/repos/github.com/Shougo/neosnippet-snippets/neosnippets'

" SuperTab like snippets behavior.
imap <expr><TAB>
      \ pumvisible() ? "\<Plug>(neosnippet_expand_or_jump)" :
      \ neosnippet#expandable_or_jumpable() ?
      \   "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

set conceallevel=0
let g:vim_json_syntax_conceal = 0


"--------------------
" EasyAlign
" ------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"----------------------
" caw.vim
"----------------------
"" 行の最初の文字の前にコメント文字をトグル
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)

"----------------------
" easymotion
"----------------------
let g:EasyMotion_do_mapping = 0 " デフォルトマップを無効化

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_migemo = 1
let g:EasyMotion_startofline = 0
let g:EasyMotion_use_upper = 1 " Show target key with upper case to improve readability
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_keys = ";WERTASDFFFGZXCVUIOPHJNM"

" <Leader>f{char} to move to {char}
map  f <Plug>(easymotion-fl)
map  F <Plug>(easymotion-Fl)
map  t <Plug>(easymotion-tl)
map  T <Plug>(easymotion-Tl)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
vmap s <Plug>(easymotion-bd-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)


function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
        \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
        \   'keymap': {
        \     "\<C-l>": '<Over>(easymotion)'
        \   },
        \   'is_expr': 0
        \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> / incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
" noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

if dein#tap('incsearch.vim')
  highlight IncSearchCursor ctermfg=0 ctermbg=9 guifg=#000000 guibg=#FF0000
  set hlsearch | nohlsearch
  let g:incsearch#auto_nohlsearch = 1
  let g:incsearch#consistent_n_direction = 1
  let g:incsearch#do_not_save_error_message_history = 2
  let g:incsearch#magic = '\V' " very nomagic

  " noremap / <Plug>(incsearch-forward)
  " noremap ? <Plug>(incsearch-backward)
  " noremap g/ <Plug>(incsearch-stay)
  noremap n  <Plug>(incsearch-nohl-n)
  noremap N  <Plug>(incsearch-nohl-N)
  noremap *  <Plug>(incsearch-nohl-*)
  noremap #  <Plug>(incsearch-nohl-#)
  noremap g* <Plug>(incsearch-nohl-g*)
  noremap g# <Plug>(incsearch-nohl-g#)
endif

"--------------------
" haya14busa/incsearch-migemo.vim
"--------------------
function! s:config_migemo(...) abort
  return extend(copy({
        \   'converters': [
        \     incsearch#config#migemo#converter(),
        \   ],
        \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
        \   'keymap': {"\<C-l>": '<Over>(easymotion)'},
        \   'is_expr': 0,
        \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Leader>/ incsearch#go(<SID>config_migemo())
noremap <silent><expr> <Leader>? incsearch#go(<SID>config_migemo({'command': '?'}))
" noremap <silent><expr> <Leader>g/ incsearch#go(<SID>config_migemo({'is_stay': 1}))

"--------------------
" matchit
" ------------------
let b:match_ignorecase = 1

"------------
"lightline
"------------

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
      \ }
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
  return exists('*fugitive#head') && strlen(fugitive#head()) ? ''.fugitive#head() : ''
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
"imap <c-c> = <nop>
let g:user_emmet_eader_key = '<c-c>'
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
let g:quickrun_config ={}
let g:quickrun_config.scheme = { 'scheme': { 'command': 'gosh'}}

"--------------------
"vim-unite-giti
"--------------------
" nnoremap <silent><Leader>gP :Unite giti/pull_request/base -no-start-insert -horizontal<CR>
nnoremap <silent><Leader>gs :Unite giti/status -no-start-insert<CR>
nnoremap <silent><Leader>gb :Unite giti/branch_all -no-start-insert<CR>
nnoremap <silent><Leader>gl :Unite giti/log -no-start-insert<CR>

function! s:unite_hooks.giti_status()
  " nnoremap <silent><buffer><expr>gM unite#do_action('ammend')
  nnoremap <silent><buffer><expr>gm unite#do_action('commit')
  nnoremap <silent><buffer><expr>ga unite#do_action('stage')
  nnoremap <silent><buffer><expr>gc unite#do_action('checkout')
  nnoremap <silent><buffer><expr>gd unite#do_action('diff')
  nnoremap <silent><buffer><expr>gu unite#do_action('unstage')
endfunction

function! s:unite_hooks.giti_branch()
  nnoremap <silent><buffer><expr>d unite#do_action('delete')
  nnoremap <silent><buffer><expr>D unite#do_action('delete_force')
endfunction

function! s:unite_hooks.giti_branch_all()
  call s:unite_hooks.source_giti_branch()
endfunction

function! s:unite_hooks.giti_log()
  nnoremap <silent><buffer><expr>gd unite#do_action('diff')
  nnoremap <silent><buffer><expr>d unite#do_action('diff')
endfunction

"--------------------
"vim-fugitive
"--------------------
nnoremap <C-g>l :Glog --oneline<CR>
" nnoremap <C-g>s :Gstatus<CR>
" nnoremap <C-g>a :Gwrite<CR>
" nnoremap <C-g>r :Gread<CR>
" nnoremap <C-g>c :Gcommit<CR>
" nnoremap <C-g>b :Gblame<CR>
" nnoremap <C-g>d :Gdiff<CR>
" nnoremap <C-g>v :Gitv<CR>

"--------------------
" syntastic
"--------------------
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=2
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes': ['php', 'sh', 'vim', 'python'],
      \ 'passive_filetypes': ['html', 'haskell']
      \}


"--------------------
" simple javascript indenter
"--------------------
"let g:SimpleJsIndenter_BriefMode=1

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
syntax on
augroup vimrc-highlight
  autocmd!
  autocmd Syntax * if 100000 < line('$') | syntax off | endif
augroup END

function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction

function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction

function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

set t_Co=256
"" タブラインの色
autocmd ColorScheme * hi TabLineSel  term=bold cterm=underline,bold ctermfg=White ctermbg=Black gui=bold,underline guifg=LightGray guibg=DarkBlue
autocmd ColorScheme * hi TabLine     term=reverse cterm=underline ctermfg=Gray ctermbg=black guifg=Black guibg=black
autocmd ColorScheme * hi TabLineFill term=bold cterm=underline,bold ctermfg=Gray ctermbg=black gui=reverse,bold guifg=black guibg=black

""補完メニューの色
autocmd ColorScheme * hi Pmenu ctermfg=73 ctermbg=16 guifg=#66D9EF guibg=#000000
autocmd ColorScheme * hi PmenuSel ctermfg=252 ctermbg=23 guibg=#808080
autocmd ColorScheme * hi PmenuSbar ctermbg=232 guibg=#080808
autocmd ColorScheme * hi PmenuThumb ctermfg=103 ctermbg=15 guifg=#66D9EF guibg=White

" 選択
autocmd ColorScheme * hi Visual ctermbg=238

"" その他
autocmd ColorScheme * hi CursorLine ctermbg=236
autocmd ColorScheme * hi Delimiter ctermfg=247
autocmd ColorScheme * hi Comment ctermfg=73

set t_Co=256
set background=dark
colorscheme mopkai

"set nonumber
set nomore
set number
set showmode          " モード表示
set title             " 編集中のファイル名を表示
set ruler             " ルーラーの表示
set showcmd           " 入力中のコマンドをステータスに表示する
set laststatus=2      " ステータスラインを常に表示
set cursorline        " 下線
set wrap              " 画面幅で折り返す
set list              " 不可視文字表示
set listchars=tab:>\  " 不可視文字の表示方法
set display=uhex      " 印字不可能文字を16進数で表示
set nf=hex            " 数値インクリメントは10進数か16進数
set splitbelow        " 水平分割時は新しいwindowを下に
set splitright        " 垂直分割時は新しいwindowを右に
set ambiwidth=double  " 絵文字>


function! ToggleRelativenumber() abort
  if &number == 1
    setlocal nonumber
  else
    setlocal number
  endif
endfunction
nnoremap <silent> <Leader>n :call ToggleRelativenumber()<cr>


" paste 
nnoremap <Leader>p "0p
vnoremap <Leader>p "0p

nnoremap x "_x

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
set tagstack
if has('path_extra')
  set tags+=tags;
endif
nnoremap <C-O> <C-T>

"---------------------------------
"ファイル操作
"--------------------------------
set autoread                        " 更新時自動再読込み
set hidden                          " 編集中でも他のファイルを開けるようにする
set noswapfile                      " スワップファイルを作らない
set nobackup                        " バックアップを取らない
" autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去する

" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" vnoremap <silent> y y`]
" vnoremap <silent> p p`]
" nnoremap <silent> p p`]

"backspaceの挙動
set backspace=start,eol,indent

"挿入モード便利キー
noremap! <C-P> <Up>
noremap! <C-N> <Down>
noremap! <C-F> <Right>
noremap! <C-B> <Left>
noremap! <C-D> <Del>
noremap! <C-[> <ESC>

"加算
"screenと被るので、<C-Q>へ
noremap <C-Q> <C-A>

"command line windowを表示
"swap semicolon and colon
noremap : ;
noremap ; q:
"noremap ; :

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
  resize 3
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

" タブの操作

nnoremap <silent> <C-t>l :<C-u>tabnext<CR>
nnoremap <silent> <C-t><C-l> :<C-u>tabnext<CR>
nnoremap <silent> <C-t>h :<C-u>tabprevious<CR>
nnoremap <silent> <C-t><C-h> :<C-u>tabprevious<CR>

nnoremap <silent> <C-t>1 :<C-u>tabn 1<CR>
nnoremap <silent> <C-t>2 :<C-u>tabn 2<CR>
nnoremap <silent> <C-t>3 :<C-u>tabn 3<CR>
nnoremap <silent> <C-t>4 :<C-u>tabn 4<CR>
nnoremap <silent> <C-t>5 :<C-u>tabn 5<CR>
nnoremap <silent> <C-t>6 :<C-u>tabn 6<CR>
nnoremap <silent> <C-t>7 :<C-u>tabn 7<CR>
nnoremap <silent> <C-t>8 :<C-u>tabn 8<CR>
nnoremap <silent> <C-t>9 :<C-u>tabn 9<CR>
nnoremap <silent> <C-t>0 :<C-u>tabn 10<CR>

" タブ操作
nnoremap <silent> <C-t>t :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> <C-t><C-t> :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> <C-t>d :<C-u>tabclose<CR>
nnoremap <silent> <C-t><C-d> :<C-u>tabclose<CR>

" ウィンドウの分割<C-T>
nnoremap <silent> <C-w>v :<C-u>vsp<CR>
nnoremap <silent> <C-w>s :<C-u>sp<CR>


"<C-d>とあわせて左手だけでスクロール
" nnoremap <C-e> <C-u>
" vnoremap <C-e> <C-u>

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
if has('persistent_undo')
  set undodir=./.vim.undo,~/.vim.undo
  augroup SaveUndoFile
    autocmd!
    autocmd BufReadPre ~/* setlocal undofile
  augroup END
endif

set expandtab
set tabstop=2
set softtabstop=-1
set shiftwidth=2

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
set fencs=utf-8,sjis,utf-16,ucs-bom,euc-jp,cp932,iso-2022-jp,ucs-2le,ucs-2
set ffs=unix,mac,dos

"file format
command! Unix :set ff=unix
command! Dos :set ff=dos
command! Mac :set ff=mac

"file enc
command! Sjis :e ++enc=sjis
command! Utf8 :e ++enc=utf8

set cmdheight=1


" Jq
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
  if 0 == a:0
    let l:arg = "."
  else
    let l:arg = a:1
  endif
  execute "%! jq \"" . l:arg . "\""
endfunction


"if has('mac')
"  if has('gui_running')
"    let IM_CtrlMode = 4
"  else
"    let IM_CtrlMode = 1
"
"    function! IMCtrl(cmd)
"      let cmd = a:cmd
"      if cmd == 'On'
"        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {104})" > /dev/null 2>&1')
"      elseif cmd == 'Off'
"        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {102})" > /dev/null 2>&1')
"      elseif cmd == 'Toggle'
"        let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {55, 49})" > /dev/null 2>&1')
"      endif
"      return ''
"    endfunction
"  endif
"
"  "「日本語入力固定モード」のMacVimKaoriya対策を無効化
"  let IM_CtrlMacVimKaoriya = 0
"  " ctrl+jで日本語入力固定モードをOnOff
"  inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
"  nnoremap <silent> <expr> <C-j> IMState('FixMode')
"endif

set helplang=ja,en
filetype plugin indent on
