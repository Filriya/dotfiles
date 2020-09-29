"-----------------------------------------------------------------------------------
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

scriptencoding utf-8

filetype off
filetype plugin indent off

"----------------------
"dein
"----------------------
let s:dein_dir = expand('~/.config/nvim.bundle')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim' " dein.vim 本体
let g:dein#install_process_timeout =  600

" deinが入っていなければinstall
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" 設定開始
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let s:toml = '~/.config/nvim/dein.toml'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml])

  call dein#load_toml(s:toml, {'lazy': 0})

  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" :call dein#recache_runtimepath()

"-------------------
" keymap
"-------------------
noremap <Leader> <Nop>
let mapleader = "\<Space>"
nmap <Leader><Leader> <Space>

"esc2回でハイライトを消す
nnoremap <silent> <ESC><ESC> :noh<cr>
"挿入モード便利キー
noremap! <C-P> <Up>
noremap! <C-N> <Down>
noremap! <C-F> <Right>
noremap! <C-B> <Left>
noremap! <C-[> <ESC>

" jump時カーソルを中心にする
nnoremap <C-O> <C-O>zz
nnoremap <C-I> <C-I>zz

"加算
"screenと被るので、<C-A>を<C-Q>へ
nnoremap <C-Q> <C-A>


"command line windowを表示
"swap semicolon and colon
noremap : ;
noremap ; :
set cedit=\<C-w>

" 検索時語句を中心にする
nnoremap * *zz
nnoremap n nzz
nnoremap N Nzz

" exモードを無効に
nnoremap Q <Nop>

" macの辞書を開く
nnoremap g? :!open dict://<cword><CR>

" clipboardにコピーする
vnoremap Y "*y
vnoremap D "*d

"fold
nnoremap zl zo
nnoremap zL zO
nnoremap zh zc
nnoremap zH zC


" ----------------------------------------
" <t> commands
" ウィンドウ、タブ、バッファの分割・移動
" Window Tab Buffer
" ----------------------------------------
nnoremap <silent> <C-t>n :echo noaction<CR>
nnoremap <silent> <C-t><C-n> :echo noaction<CR>
nnoremap <silent> <C-t>p :echo noaction<CR>
nnoremap <silent> <C-t><C-p> :echo noaction<CR>

" タブの操作
nnoremap <silent> <C-w>n :<C-u>tabnext<CR>
nnoremap <silent> <C-w><C-n> :<C-u>tabnext<CR>
nnoremap <silent> <C-w>p :<C-u>tabprevious<CR>
nnoremap <silent> <C-w><C-p> :<C-u>tabprevious<CR>

nnoremap <silent> <C-w>1 :<C-u>tabn 1<CR>
nnoremap <silent> <C-w>2 :<C-u>tabn 2<CR>
nnoremap <silent> <C-w>3 :<C-u>tabn 3<CR>
nnoremap <silent> <C-w>4 :<C-u>tabn 4<CR>
nnoremap <silent> <C-w>5 :<C-u>tabn 5<CR>
nnoremap <silent> <C-w>6 :<C-u>tabn 6<CR>
nnoremap <silent> <C-w>7 :<C-u>tabn 7<CR>
nnoremap <silent> <C-w>8 :<C-u>tabn 8<CR>
nnoremap <silent> <C-w>9 :<C-u>tabn 9<CR>
nnoremap <silent> <C-w>0 :<C-u>tabn 10<CR>

nnoremap <silent> <C-w>c :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> <C-w><C-c> :<C-u>tabnew<CR>:tabmove<CR>

nnoremap <silent> <C-w><bar> :<C-u>vsp<CR>
nnoremap <silent> <C-w>- :<C-u>sp<CR>
nnoremap <silent> <C-w>_ <C-w>-

" nnoremap <C-z> `.zz

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>

".edit config
nnoremap <silent> <Leader>es :<C-u>source $MYVIMRC<CR>
nnoremap <silent> <Leader>ev :<C-u>tabnew $MYVIMRC<CR>

" reload file
nnoremap <silent> <Leader>R :<C-u>e<CR>

" help
nnoremap          <Leader>H :vert help<space>

" save and quit
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>W :w sudo:%<CR>
nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Leader>Q :qa!<CR>

" jump same indent
nnoremap <silent> <C-k> k:call search ("^". matchstr (getline (line (".")+ 1), '\(\s*\)') ."\\S", 'b')<CR>^
nnoremap <silent> <C-j> :call search ("^". matchstr (getline (line (".")), '\(\s*\)') ."\\S")<CR>^

if dein#tap('defx.nvim')
  " nnoremap <silent> <C-e> :Defx -split=vertical -winwidth=40 -direction=topleft<CR>
  nnoremap <silent> <C-e> :Defx -split=vertical -winwidth=40 -direction=topleft `expand('%:p:h')` -search=`expand('%:p')` <CR>
endif

if dein#tap('fzf.vim')
  nnoremap <silent> <Leader>f :<C-u>GFiles<CR>
  nnoremap <silent> <Leader>F :<C-u>Files<CR>
  nnoremap <silent> <Leader>ee :<C-u>Dotfiles<CR>
  nnoremap <silent> <Leader>gf :<C-u>GFiles?<CR>
  nnoremap <silent> <Leader>u :<C-u>Buffers<CR>
  " nnoremap <silent> <Leader>b :<C-u>LoadedBuffers<CR>
  " nnoremap          <Leader>a :<C-u>Ag<Space>
  nnoremap          <Leader>a :<C-u>Rg<Space>
  nnoremap <silent> <Leader>/ :<C-u>Lines<CR>
  nnoremap <silent> <Leader>? :<C-u>BLines<CR>
  nnoremap <silent> <Leader>h :<C-u>History<CR>
  nnoremap <silent> <Leader>i :call fzf#vim#tags(expand('<cword>'))<CR>
  nnoremap <silent> <Leader>I :<C-u>Tags<CR>
endif

if dein#tap('coc.nvim')

  " ポップアップメニュー 
  " 補完モードのコマンド(|popupmenu-keys| を参照)
  " <CR>で補完せず下の行
  " <Tab>で補完 スニペットのジャンプ
  inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

  " inoremap <expr> <CR> pumvisible() ? "\<C-e>" : "\<C-g>u\<CR>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  nnoremap <silent> <C-L> :<C-u>CocRestart<CR>


  " Use `g[` and `g]` to navigate diagnostics
  " エラーのある位置までジャンプ
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  " 定義ジャンプ
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nnoremap <silent> gD :call <SID>show_documentation()<CR>
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Introduce function text object
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  " Remap for rename current word
  " リネーム
  nmap <silent> gR <Plug>(coc-rename)
  " nmap gR <Plug>(coc-refactor)

  " Remap for format selected region
  " 整形
  xmap <silent> gF <Plug>(coc-format-selected)
  " nmap <silent> gF <Plug>(coc-format-selected)
  nnoremap <silent> gF :<C-u>Format<CR>

  " 折りたたみ
  nnoremap <silent> gf :<C-u>Fold<CR>

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  " 選択ファイルを関数化したり、別ファイルに書き出したり
  xmap <silent> ga <Plug>(coc-codeaction-selected)
  nmap <silent> ga <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  " actionのカレント行バージョン
  nmap <silent> gac  <Plug>(coc-codeaction)

  " Fix autofix problem of current line
  " エラーの自動修正
  nmap <silent> gq  <Plug>(coc-fix-current)

  " Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
  " 謎
  " nmap <silent> <TAB> <Plug>(coc-range-select)
  " xmap <silent> <TAB> <Plug>(coc-range-select)
  " xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

  " Using CocList
  " Show all diagnostics
  nnoremap <silent> gld  :<C-u>CocList diagnostics<cr>
  " " Manage extensions
  nnoremap <silent> gle  :<C-u>CocList extensions<cr>
  " " Show commands
  nnoremap <silent> glc  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent> glo  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent> gls  :<C-u>CocList -I symbols<cr>
  " " Do default action for next item.
  " nnoremap <silent> gj  :<C-u>CocNext<CR>
  " " Do default action for previous item.
  " nnoremap <silent> gk  :<C-u>CocPrev<CR>
  " " Resume latest coc list
  " nnoremap <silent> gp  :<C-u>CocListResume<CR>

endif

if dein#tap('PDV--phpDocumentor-for-Vim')
  augroup php-dev
    autocmd!
    autocmd FileType php nnoremap <Leader>P :call PhpDocSingle()<CR>
    autocmd FileType php vnoremap <Leader>P :call PhpDocRange()<CR>
  augroup End
endif

if dein#tap('vim-easy-align')
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap <Leader>ea <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap <Leader>ea <Plug>(EasyAlign)
endif
 
if dein#tap('caw.vim')
  "" 行の最初の文字の前にコメント文字をトグル
  nmap <Leader>c <Plug>(caw:hatpos:toggle)
  nmap <Leader>C <Plug>(caw:wrap:toggle)
  vmap <Leader>c <Plug>(caw:hatpos:toggle)
  vmap <Leader>C <Plug>(caw:wrap:toggle)
endif

if dein#tap('incsearch-migemo.vim')
  nmap <silent> g/ <Plug>(incsearch-migemo-/)
  " nmap g? <Plug>(incsearch-migemo-?)
endif

if dein#tap('vim-easymotion')
  " <Leader>f{char} to move to {char}
  map  f <Plug>(easymotion-fl)
  map  F <Plug>(easymotion-Fl)
  map  t <Plug>(easymotion-tl)
  map  T <Plug>(easymotion-Tl)

  " s{char}{char} to move to {char}{char}
  nmap <Leader>[ <Plug>(easymotion-overwin-f2)
  vmap <Leader>[ <Plug>(easymotion-bd-f2)

  " Move to line
  map <Leader>l <Plug>(easymotion-bd-jk)
  nmap <Leader>l <Plug>(easymotion-overwin-line)
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)
endif

if dein#tap('vim-sandwich')
  runtime macros/sandwich/keymap/surround.vim
  xmap S <Nop>
  xmap s <Plug>(operator-sandwich-add)
endif


map <Leader>g [git]
if dein#tap("vim-fugitive")
  nnoremap [git]w :Gstatus<CR>
  nnoremap [git]c :Gcommit<CR>
  nnoremap [git]d :Gdiff<CR>
  nnoremap [git]B :Gblame<CR>
  vnoremap [git]B :Gbrowse<CR>
endif

if dein#tap("agit.vim")
  nnoremap [git]l :Agit<CR>
endif

if dein#tap("vim-merginal")
  nnoremap [git]b :Merginal<CR>
endif

if dein#tap('vim-gitgutter')
  nmap ]h <Plug>(GitGutterNextHunk)
  nmap [h <Plug>(GitGutterPrevHunk)

  nmap [git]p <Plug>(GitGutterPreviewHunk)
  nmap [git]a <Plug>(GitGutterStageHunk)
  nmap [git]r <Plug>(GitGutterUndoHunk)
  nmap [git]t <Plug>(GitGutterSignsToggle)
endif

if dein#tap('vim-table-mode')
  let g:table_mode_disable_mappings = 0

  let g:table_mode_map_prefix = "<C-t>"
  let g:table_mode_corner = "|"
  let g:table_mode_toggle_map = 'm'
  let g:table_mode_tableize_map = '<C-t>T'
  let g:table_mode_tableize_d_map = '<C-t>t'
  let g:table_mode_motion_up_map = '<C-k>'
  let g:table_mode_motion_down_map = '<C-j>'
  let g:table_mode_motion_left_map = '<C-h>'
  let g:table_mode_motion_right_map = '<C-l>'
  let g:table_mode_realign_map = '<C-t>r'
  let g:table_mode_delete_row_map = '<C-t>dr'
  let g:table_mode_delete_column_map = '<C-t>dc'
  let g:table_mode_add_formula_map = '<C-t>fa'
  let g:table_mode_eval_formula_map = '<C-t>fe'
  let g:table_mode_echo_cell_map = '<C-t>?'
  let g:table_mode_sort_map = '<C-t>s'
endif

if dein#tap('memolist.vim')
  nnoremap <Leader>mn  :MemoNew<CR>
  nnoremap <Leader>ml  :FzfMemoList<CR>
  nnoremap <Leader>mg  :MemoGrep<CR>
endif

if dein#tap('tagbar')
  nnoremap <Leader>o :TagbarToggle<CR>
endif

" if dein#tap('vim-cutlass')
"   nnoremap m d
"   xnoremap m d
"   nnoremap mm dd
"   nnoremap M D
"
"   " nnoremap x d
"   " xnoremap x d
"   " nnoremap xx dd
"   " nnoremap X D
" endif
"

" if dein#tap('vim-yoink')
"   nmap <C-n> <plug>(YoinkPostPasteSwapBack)
"   nmap <C-p> <plug>(YoinkPostPasteSwapForward)
"
"   nmap p <plug>(YoinkPaste_p)
"   nmap P <plug>(YoinkPaste_P)
"
"   nmap [y <plug>(YoinkRotateBack)
"   nmap ]y <plug>(YoinkRotateForward)
"   nmap <C-=> <plug>(YoinkPostPasteToggleFormat)
" endif

" if dein#tap('vim-subversive')
"   nmap s <plug>(SubversiveSubstitute)
"   nmap ss <plug>(SubversiveSubstituteLine)
"   " nmap S <plug>(SubversiveSubstituteToEndOfLine)
"
"   " 置換したい文字列を範囲指定 -> 変更する範囲を指定
"   nmap <Leader>s <plug>(SubversiveSubstituteRange)
"   xmap <Leader>s <plug>(SubversiveSubstituteRange)
"   nmap <Leader>ss <plug>(SubversiveSubstituteWordRange)
"
"   " <Leader>sの確認ありバージョン
"   nmap <Leader>r <plug>(SubversiveSubstituteRangeConfirm)
"   xmap <Leader>r <plug>(SubversiveSubstituteRangeConfirm)
"   nmap <Leader>rr <plug>(SubversiveSubstituteWordRangeConfirm)
" endif

nnoremap S :%s/\v
vnoremap S :s/\v

" --------------------
" Keymap ここまで
" --------------------







" --------------------
" setting ここから
" --------------------

"-----------
" defx
"----------
if dein#tap('defx.nvim')
  autocmd FileType defx call s:defx_my_settings()

  function! s:defx_my_settings() abort

    function! Defx_git_root_dir(context) abort
      let l:path = system('git rev-parse --show-toplevel')
      let l:path = substitute(l:path, "[\n\r]", "", "g")
      call defx#call_action('cd', l:path)
    endfunction

    " Define mappings
    " move cursor
    nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G': 'k'

    " change directory
    nnoremap <silent><buffer><expr> <CR>
          \ defx#is_directory() ?
          \ defx#do_action('open'):
          \ defx#do_action('drop')
    nnoremap <silent><buffer><expr> l
          \ defx#is_directory() ?
          \ defx#do_action('open_tree'):
          \ defx#do_action('drop')
    nnoremap <silent><buffer><expr> L
          \ defx#do_action('open_tree_recursive', [5]):
    nnoremap <silent><buffer><expr> h
          \ defx#do_action('close_tree')
    nnoremap <silent><buffer><expr> u defx#do_action('cd', ['..'])
    " nnoremap <silent><buffer><expr> <CR>
    "      \ defx#is_directory() ?
    "      \ defx#do_action('open_or_close_tree'):
    "      \ defx#do_action('drop')
    " nnoremap <silent><buffer><expr> l
    "      \ defx#is_directory() ?
    "      \ defx#do_action('open'):
    "      \ defx#do_action('drop')
    nnoremap <silent><buffer><expr> ` defx#do_action('call', 'Defx_git_root_dir')
    nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
    nnoremap <silent><buffer><expr> \ defx#do_action('cd', ['/'])

    " open file
    nnoremap <silent><buffer><expr> s
          \ defx#do_action('multi', ['quit', ['open', 'split']])
    nnoremap <silent><buffer><expr> v
          \ defx#do_action('multi', ['quit', ['open', 'vsplit']])
    nnoremap <silent><buffer><expr> t
          \ defx#do_action('multi', ['quit', ['open', 'tabnew']])
    nnoremap <silent><buffer><expr> P defx#do_action('open', 'pedit')

    " move file
    nnoremap <silent><buffer><expr> c     defx#do_action('copy')
    nnoremap <silent><buffer><expr> m     defx#do_action('move')
    nnoremap <silent><buffer><expr> p     defx#do_action('paste')

    " edit file
    nnoremap <silent><buffer><expr> K     defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N     defx#do_action('new_file')
    nnoremap <silent><buffer><expr> d     defx#do_action('remove')
    nnoremap <silent><buffer><expr> r     defx#do_action('rename')

    " select file
    nnoremap <silent><buffer><expr> J     defx#do_action('toggle_select').'j'
    vnoremap <silent><buffer><expr> J     defx#do_action('toggle_select_visual').'j'
    nnoremap <silent><buffer><expr> *        defx#do_action('toggle_select_all')

    " other
    nnoremap <silent><buffer><expr> x     defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy    defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .     defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
    nnoremap <silent><buffer><expr> q     defx#do_action('quit')
    nnoremap <silent><buffer><expr> cd    defx#do_action('change_vim_cwd')

  endfunction
endif

"--------------------
" fzf.vim
"--------------------

if dein#tap('fzf.vim')
  set rtp+=/usr/local/opt/fzf,/home/linuxbrew/.linuxbrew/opt/fzf
  " let g:fzf_command_prefix = 'Fzf'

  " TODO: 多分遅い
  function! s:build_quickfix_list(lines)
    if len(a:lines) == 1
      execute 'edit '.a:lines[0]
    else
      call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
      copen
      " cc
    endif
  endfunction

  function! s:fzf_dot_files() abort
    let l:dirname = system("cd $(dirname ".$MYVIMRC."); git rev-parse --show-toplevel")
    let l:dirname = substitute(l:dirname, "[\n\r]", "", "g")
    call fzf#run({
          \ 'source': 'fd --type f --hidden --follow --exclude ".git/*" --exclude "*.app*" . '.l:dirname,
          \ 'sink': 'tab split',
          \ 'down': '40%'
          \ })
  endfunction
  " let g:memolist_path = $HOME."/posts/"

  if dein#tap('memolist.vim')
    function! s:fzf_memolist() abort
      echo g:memolist_path
      call fzf#run({
            \ 'source': 'fd --type f . '.g:memolist_path,
            \ 'sink': 'tab split',
            \ 'down': '40%',
            \ 'options': '--tac'
            \ })
    endfunction
    command! FzfMemoList call s:fzf_memolist()
  endif

  function! s:fzf_emoji(...) abort
    if a:0 >= 1
      let l:file = a:1
    else
      let l:file = "*"
    end
    call fzf#run({
          \ 'source': 'cat ~/.config/nvim/cheatsheet/emoji/'.l:file,
          \ 'sink': function('s:insert_emoji'),
          \ 'down': '40%'
          \ })
  endfunction

  function! s:insert_emoji(line) abort
    let l:splitted = split(a:line)

    if l:splitted[0] == "*"
      call s:fzf_emoji(l:splitted[1])
    else
      let pos = getpos(".")
      execute ":normal i" . l:splitted[1]
      call setpos('.', pos)
    endif
  endfunction

  " This is the default extra key bindings
  let g:fzf_action = {
        \ 'enter': function('s:build_quickfix_list'),
        \ 'ctrl-m': 'open',
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit'}

  " Default fzf layout
  " - down / up / left / right
  let g:fzf_layout = { 'down': '40%' }

  let g:fzf_buffers_jump = 1
  " let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
  let g:fzf_tags_command = 'ctags --exclude=node_modules --exclude=vendor'

  command! Dotfiles call s:fzf_dot_files()
  command! -nargs=? Emoji call s:fzf_emoji(<f-args>)
  command! -bang -nargs=+ -complete=dir Ag call fzf#vim#ag_raw(<q-args>, <bang>0)

  command! -bang -nargs=* -complete=dir Rg
        \  call fzf#vim#grep(
        \    'rg --column --line-number --no-heading --color=always --smart-case '.(<q-args>), 1,
        \    <bang>0 ? fzf#vim#with_preview('up:60%')
        \            : fzf#vim#with_preview('right:50%:hidden'),
        \    <bang>0)

  " Likewise, Files command with preview window
  command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

  command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

  function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=161 ctermbg=251
    highlight fzf2 ctermfg=23 ctermbg=251
    highlight fzf3 ctermfg=237 ctermbg=251
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
  endfunction
  autocmd! User FzfStatusLine call <SID>fzf_statusline()
endif

" --------------------
" coc.nvim
" --------------------
if dein#tap('coc.nvim')
  set hidden
  set nobackup
  set nowritebackup
  set cmdheight=2
  set updatetime=100
  set shortmess+=cI
  set signcolumn=yes

  " let g:coc_config_home='~/.config/nvim/coc/'
  augroup cocmygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call CocAction('fold', <f-args>)

  " fold
  " manual 手動で折畳を定義する
  " indent インデントの数を折畳のレベル(深さ)とする
  " expr 折畳を定義する式を指定する
  " syntax 構文強調により折畳を定義する
  " diff 変更されていないテキストを折畳対象とする
  " marker テキスト中の印で折畳を定義する
  set foldmethod=indent
  set foldlevel=1

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR  :call CocAction('runCommand', 'editor.action.organizeImport')

  " Add status line support, for integration with other plugin, checkout `:h coc-status`
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  let g:coc_global_extensions = [
        \  'coc-lists',
        \  'coc-marketplace',
        \  'coc-snippets',
        \  'coc-json',
        \  'coc-vetur',
        \  'coc-tsserver',
        \  'coc-eslint',
        \  'coc-rls',
        \  'coc-python',
        \  'coc-html',
        \  'coc-css',
        \  'coc-yaml'
        \ ]

        "\  'coc-phpls',

endif

"--------------------
" auto-ctags
" ------------------
"  auto-ctagsはコマンドで全生成するのためだけに使う
if dein#tap('auto-ctags.vim')
  let g:auto_ctags = 0
  let g:auto_ctags_tags_args = '--exclude=node_modules --exclude=vendor'
endif

"--------------------
" vim-autotags
" ------------------
if dein#tap('vim-autotag')
  let g:autotagCtagsCmd = 'ctags --exclude=node_modules --exclude=vendor'
  " tags
  set tagstack
  if has('path_extra')
    set tags+=./**2/tags;$HOME
  endif
endif

"--------------------
" majutsushi/tagbar
"--------------------
if dein#tap('tagbar')
  " let g:tagbar_autofocus = 1
  let g:tagbar_show_linenumbers = 1
  let g:tagbar_iconchars = ['▸', '▾']
  let g:tagbar_autofocus = 1
  let g:tagbar_sort = 0
  let g:tagbar_width = 60

  augroup tagbarhighlight
    autocmd!
    autocmd ColorScheme * hi link TagbarVisibilityPublic Type
    autocmd ColorScheme * hi link TagbarVisibilityProtected String
    " autocmd ColorScheme * hi link TagbarVisibilityPrivate Special
    autocmd ColorScheme * hi link TagbarVisibilityPrivate Todo
    " autocmd ColorScheme * hi link TagbarHighlight Visual
    " autocmd ColorScheme * hi TagbarHighlight term=underline cterm=underline gui=underline
    autocmd ColorScheme * hi TagbarHighlight term=underline cterm=underline gui=underline
  augroup END

  let g:tagbar_type_yaml = {
    \ 'ctagstype' : 'yaml',
    \ 'kinds' : [
        \ 'a:anchors',
        \ 's:section',
        \ 'e:entry'
    \ ],
  \ 'sro' : '.',
    \ 'scope2kind': {
      \ 'section': 's',
      \ 'entry': 'e'
    \ },
    \ 'kind2scope': {
      \ 's': 'section',
      \ 'e': 'entry'
    \ },
    \ 'sort' : 0
    \ }
endif

"----------------------
" easymotion
"----------------------
if dein#tap('vim-easymotion')
  let g:EasyMotion_do_mapping = 0 " デフォルトマップを無効化

  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_use_migemo = 1
  let g:EasyMotion_startofline = 0
  let g:EasyMotion_use_upper = 1 " Show target key with upper case to improve readability
  let g:EasyMotion_enter_jump_first = 1
  let g:EasyMotion_space_jump_first = 1
  let g:EasyMotion_do_shade = 0
  let g:EasyMotion_keys = "awefjioptyusdklzxcvbnmgh;"
  "asdf jiop qwert yukl zxcvbnm gh;"
endif

" a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a a

" --------------------
" matchit
" --------------------
if dein#tap('matchit')
  let b:match_ignorecase = 1
  nnoremap % %zz
endif

" --------------------
" vim-expand-region
" --------------------
if dein#tap('vim-expand-region')
  " vnoremap j <Plug>(expand_region_expand)
  " vnoremap k <Plug>(expand_region_shrink)
  let g:expand_region_text_objects = {
        \ 'iw'  :0,
        \ 'iW'  :0,
        \ 'i"'  :1,
        \ 'i''' :1,
        \ 'i]'  :1,
        \ 'ib'  :1,
        \ 'iB'  :1,
        \ 'il'  :1,
        \ 'ii'  :1,
        \ 'ip'  :1,
        \ 'if'  :1,
        \ 'ie'  :0,
        \ }
endif

"------------
"lightline
"------------
if dein#tap('lightline.vim')
      "\ 'colorscheme': 'wombat',
  let g:lightline = {
        \ 'colorscheme': 'materia',
        \ 'enable': {
        \   'statusline': 1,
        \   'tabline': 0
        \ },
        \ 'active': {
        \   'left': [ [ 'mode', 'paste', 'table', 'jpmode'],
        \             [ 'file' ],
        \             [ 'coccurrent' ] ],
        \   'right': [ [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component_function': {
        \   'table': 'CurrentTableMode',
        \   'readonly': 'MyReadonly',
        \   'modified': 'MyModified',
        \   'file': 'MyFile',
        \   'coccurrent': 'CocCurrentFunction'
        \ }
        \ }

  if dein#tap('coc.nvim')
    function! CocCurrentFunction()
      let info = get(b:, 'coc_diagnostic_info', {})
      if empty(info) | return '' | endif
      let msgs = []
      if get(info, 'error', 0)
        call add(msgs, 'E:' . info['error'])
      endif
      if get(info, 'warning', 0)
        call add(msgs, 'W:' . info['warning'])
      endif
      if get(info, 'hint', 0)
        call add(msgs, 'H:' . info['hint'])
      endif
      return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
    endfunction
  else 
    function! CocCurrentFunction()
      return ""
    endfunction
  endif

  if dein#tap('vim-table-mode')
    function! CurrentTableMode()
      " 重い?
      " if tablemode#IsActive()
      "   return "TABLE"
      " else
      "   return ""
      " endif
      return ""
    endfunction
  else
    function! CurrentTableMode()
      return ""
    endfunction
  endif



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

  " function! MyJpMode()
  "   return IMStatus("JPMODE")
  " endfunction
  "
  " function! MyFile()
  "   return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
  "        \ ('' != expand('%') ? ShortenPath() : '[No Name]') .
  "        \ ('' != MyModified() ? ' ' . MyModified() : '')
  " endfunction
  function! MyFile()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
         \ ('' != expand('%') ? fnamemodify(expand("%"), ":~:.") : '[No Name]') .
         \ ('' != MyModified() ? ' ' . MyModified() : '')
  endfunction

  function! ShortenPath()
    let path = substitute(expand('%:h'), $HOME, '~', "g")
    return substitute(path, '\v/([^/]{1,3})[^/]+', '/\1', "g").'/'.expand('%:t')
  endfunction

endif

"--------------------
"vim-quickrun
"--------------------
if dein#tap("vim-quickrun")
  " nnoremap <Leader>\ :w<CR>:QuickRun<CR>
  let g:quickrun_config = {}
  let g:quickrun_config.scheme = { 'scheme': { 'command': 'gosh'}}
endif

"--------------------
" qfreplace
"--------------------
if dein#tap("vim-qfreplace")
  autocmd FileType qf nnoremap <silent> <buffer> r :Qfreplace<CR>
endif

"--------------------
" indentLine
"--------------------
if dein#tap("indentLine")
  let g:indentLine_enabled = 0
  let g:indentLine_char = '¦'
  let g:indentLine_color_term = 236
  let g:indentLine_color_gui = '#708090'
  let g:indentLine_setConceal = 0
  let g:indentLine_fileTypeExclude = ['help', 'dein', 'denite', 'vaffle', 'defx']
endif

"--------------------
" javascript-libraries-syntax.vim
"--------------------

if dein#tap('javascript-libraries-syntax.vim')
  let g:used_javascript_libs = 'jquery, vue'
endif

"--------------------
" vim-vue-plugin
"--------------------
let g:vim_vue_plugin_use_typescript = 1
let g:vim_vue_plugin_use_sass = 1
let g:vim_vue_plugin_use_scss = 1
let g:vim_vue_plugin_highlight_vue_attr = 1
let g:vim_vue_plugin_highlight_vue_keyword = 1


"--------------------
" kana/vim-smartinput
"--------------------
if dein#tap('vim-smartinput')
  call smartinput#map_to_trigger('i', '<Space>', '<Space>', '<Space>')
  call smartinput#define_rule({
        \   'at'    : '(\%#)',
        \   'char'  : '<Space>',
        \   'input' : '<Space><Space><Left>',
        \   })

  call smartinput#define_rule({
        \   'at'    : '( \%# )',
        \   'char'  : '<BS>',
        \   'input' : '<Del><BS>',
        \   })

  call smartinput#define_rule({
        \   'at': '\s\+\%#',
        \   'char': '<CR>',
        \   'input': "<C-o>:call setline(line('.'), substitute(getline(line('.')), '\\s\\+$', '', ''))<CR><CR>",
        \   })

  call smartinput#map_to_trigger('i', '<bar>', '<bar>', '<bar>')
  call smartinput#define_rule({
        \  'at': '^\%#',
        \  'char': '<bar>',
        \  'input': '<c-o>:TableModeEnable<cr><bar><space>',
        \  })

  call smartinput#map_to_trigger('i', '<Bar>', '<Bar>', '<Bar>')
  call smartinput#define_rule({
        \    'at': '\%#',
        \    'char': '<Bar>',
        \    'input': '<Bar><Bar><Left>',
        \    'filetype': ['rust'],
        \ })
  call smartinput#define_rule({
        \    'at': '\%#|',
        \    'char': '<Bar>',
        \    'input': '<Right>',
        \    'filetype': ['rust'],
        \ })
  call smartinput#define_rule({
        \    'at': '|\%#|',
        \    'char': '<BS>',
        \    'input': '<BS><Del>',
        \    'filetype': ['rust'],
        \ })
  call smartinput#define_rule({
        \    'at': '||\%#',
        \    'char': '<BS>',
        \    'input': '<BS><BS>',
        \    'filetype': ['rust'],
        \ })
  call smartinput#define_rule({
        \    'at': '\\\%#',
        \    'char': '<Bar>',
        \    'input': '<Bar>',
        \    'filetype': ['rust'],
        \ })
endif

"--------------------
" vdebug
"--------------------

if dein#tap("vdebug")

  if !exists('g:vdebug_options')
    let g:vdebug_options = {}
  endif

  let g:vdebug_options['port'] = 9000
  let g:vdebug_options['timeout'] = 20
  let g:vdebug_options['server'] = ''
  let g:vdebug_options['on_close'] = 'detach'
  let g:vdebug_options['break_on_open'] = 0
  let g:vdebug_options['ide_key'] = ''
  let g:vdebug_options['debug_window_level'] = 0
  let g:vdebug_options['debug_file_level'] = 0
  let g:vdebug_options['debug_file'] = ''
  let g:vdebug_options['path_maps'] = {'/home/vagrant/projects': $HOME.'/projects'}
  let g:vdebug_options['watch_window_style'] = 'expanded'
  let g:vdebug_options['marker_default'] = '⬦'
  let g:vdebug_options['marker_closed_tree'] = '▸'
  let g:vdebug_options['marker_open_tree'] = '▾'
  let g:vdebug_options['sign_breakpoint'] = '▷'
  let g:vdebug_options['sign_current'] = '▶'
  let g:vdebug_options['sign_disabled'] = '='
  let g:vdebug_options['continuous_mode'] = 1
  let g:vdebug_options['simplified_status'] = 1
  let g:vdebug_options['layout'] = 'vertical'

  let g:vdebug_keymap = {
        \    "step_over" : "<F2>",
        \    "step_into" : "<F3>",
        \    "step_out" : "<F4>",
        \    "run" : "<F5>",
        \    "close" : "<F6>",
        \    "detach" : "<F7>",
        \    "run_to_cursor" : "<F9>",
        \    "set_breakpoint" : "<F10>",
        \    "get_context" : "<F11>",
        \    "eval_under_cursor" : "<F12>",
        \    "eval_visual" : "<Leader>e"
        \}

  augroup vdebug
    autocmd!
    " autocmd ColorScheme * hi DbgBreakptLine term=reverse ctermfg=White ctermbg=Green guifg=#ffffff guibg=#00ff00
    " autocmd ColorScheme * hi DbgBreakptSign term=reverse ctermfg=White ctermbg=Green guifg=#ffffff guibg=#0
    autocmd ColorScheme * hi clear DbgBreakptLine
    autocmd ColorScheme * hi clear DbgBreakptSign
  augroup END
endif
"--------------------
" committia
"--------------------
if dein#tap('committia.vim')
  let g:committia_hooks = {}
  function! g:committia_hooks.edit_open(info)
    " Additional settings
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
      startinsert
    endif

    " Scroll the diff window from insert mode
    " Map <C-n> and <C-p>
    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
  endfunction
endif

"--------------------
" vim-merginal
"--------------------
if dein#tap('vim-merginal')
  let g:merginal_windowWidth = 50
endif

" --------------------
" im_control.vim
" --------------------
"  なんか重い
" if dein#tap('im_control.vim')
"   if has('mac')
"     if has('gui_running')
"       let IM_CtrlMode = 4
"     else
"       let IM_CtrlMode = 1
"
"       function! IMCtrl(cmd)
"         let cmd = a:cmd
"         if cmd == 'On'
"           let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {104})" > /dev/null 2>&1')
"         elseif cmd == 'Off'
"           let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {102})" > /dev/null 2>&1')
"         elseif cmd == 'Toggle'
"           let res = system('osascript -e "tell application \"System Events\" to keystroke (key code {55, 49})" > /dev/null 2>&1')
"         endif
"         return ''
"       endfunction
"     endif
"
"     " 「日本語入力固定モード」のMacVimKaoriya対策を無効化
"     let IM_CtrlMacVimKaoriya = 0
"     " ctrl+jで日本語入力固定モードをOnOff
"     " inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
"     " nnoremap <C-j> :<C-u>call IMState('FixMode')<CR>
"     command! Jp call IMState('FixMode')
"   endif
" else
"   function! IMStatus(...)
"     return ''
"   endfunction
" endif

"--------------------
" vim-markdown
"--------------------
if dein#tap('vim-markdown')
  " plasticboy/vim-markdown
  let g:vim_markdown_folding_disabled = 1
  let g:vim_markdown_toc_autofit = 0
  let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'csharp=cs']
  let g:vim_markdown_new_list_item_indent = 0
  let g:vim_markdown_math = 0
  let g:vim_markdown_frontmatter = 1
  let g:vim_markdown_toml_frontmatter = 0
  let g:vim_markdown_json_frontmatter = 0
  let g:vim_markdown_conceal_code_blocks = 0

  " set nofoldenable

  " gabrielelana/vim-markdown
  " let g:markdown_include_jekyll_support = 1 "disable support for Jekyll files (enabled by default with: 1)
  " let g:markdown_enable_folding = 0 " enable the fold expression markdown#FoldLevelOfLine to fold markdown files. This is disabled by default because it's a huge performance hit even when folding is disabled with the nofoldenable option (disabled by default with: 0)
  " let g:markdown_enable_mappings = 1 " disable default mappings (enabled by default with: 1)
  " let g:markdown_enable_insert_mode_mappings = 0 " disable insert mode mappings (enabled by default with: 1)
  " let g:markdown_enable_insert_mode_leader_mappings = 0 " enable insert mode leader mappings (disabled by default with: 0)
  " let g:markdown_enable_spell_checking = 0 " disable spell checking (enabled by default with: 1)
  " let g:markdown_enable_input_abbreviations = 1 " disable abbreviations for punctuation and emoticons (enabled by default with: 1)
  " let g:markdown_enable_conceal = 0 " enable conceal for italic, bold, inline-code and link text (disabled by default with: 0)
endif

"--------------------
" reireias/vim-cheatsheet
"--------------------
if dein#tap('vim-cheatsheet')
  augroup cheatsheet
    autocmd!
    autocmd BufEnter,BufRead * call s:set_cheatsheet_path()
  augroup END

  function! s:set_cheatsheet_path()
    let filetype = &filetype
    let g:cheatsheet#cheat_file = $HOME.'/.config/nvim/cheatsheet/'.filetype.'.txt'
  endfunction
endif

"--------------------
" memolist
"--------------------
if dein#tap('memolist.vim')
  let g:memolist_memo_suffix = "md"
  let g:memolist_path = $HOME."/posts/"

  " let g:memolist_memo_date = "%Y-%m-%dT%H:%M:%S%z"
  let g:memolist_template_dir_path = $HOME."/.config/nvim/template"

  let g:memolist_prompt_tags = 1
  let g:memolist_prompt_categories = 0
  let g:memolist_fzf = 1
endif

"--------------------
" markdown-preview.nvim
"--------------------
if dein#tap('markdown-preview.nvim')
  let g:mkdp_auto_close = 1

  let g:mkdp_refresh_slow = 1

  " preview page title
  " ${name} will be replace with the file name
  let g:mkdp_page_title = '「${name}」'
endif

"--------------------
" vim-gitgutter
"--------------------
if dein#tap('vim-gitgutter')
  let g:gitgutter_enabled = 1
  let g:gitgutter_map_keys = 0
  let g:gitgutter_max_signs = 2000
  let g:gitgutter_signs = 0
endif

"--------------------
" vim-json
"--------------------
if dein#tap('vim-json')
  let g:vim_json_syntax_conceal = 0
endif

"--------------------
" vim-php-cs-fixer
"--------------------
if dein#tap('vim-php-cs-fixer')
  " If you use php-cs-fixer version 2.x
  " options: --rules (default:@PSR2)
  " let g:php_cs_fixer_rules = '{ '
  "     \ . '"@PSR1": true, '
  "     \ . '"@PSR2": true,'
  "     \ . '"@Symfony": true,' 
  "     \ . '"braces": { "position_after_control_structures":  "next", "position_after_anonymous_constructs": "next" }'
  "     \ . ' }'
  let g:php_cs_fixer_cache = ".php_cs.cache" " options: --cache-file
  let g:php_cs_fixer_config_file = '.php_cs' " options: --config

  let g:php_cs_fixer_php_path = "php"               " Path to PHP
  let g:php_cs_fixer_enable_default_mapping = 0     " Enable the mapping by default (<leader>pcd)
  let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
  let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
endif

" "--------------------
" " yoink
" "--------------------
" if dein#tap('vim-yoink')
"   let g:yoinkMaxItems = 30
"   let g:yoinkSyncNumberedRegisters = 0
"   let g:yoinkIncludeDeleteOperations = 1
"   " let g:yoinkSavePersistently = 1
"   let g:yoinkAutoFormatPaste = 0
"   let g:yoinkMoveCursorToEndOfPaste = 0
"   let g:yoinkSwapClampAtEnds = 1
"   let g:yoinkIncludeNamedRegisters = 1
"
"   set shada=!,'100,<50,s10,h
" endif

"--------------------
" vim-chrome-devtools
"--------------------
if dein#tap('vim-chrome-devtools')
  let g:ChromeDevTools_host = 'localhost'
  let g:ChromeDevTools_port = 9222
endif
"--------------------
" vim-sandwich
"--------------------
if dein#tap('vim-sandwich')
  let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
  let g:sandwich#recipes += [
        \    {'buns': ['<', '>']}
        \  ]
endif


"--------------------
" setting ここまで
"--------------------


let g:python3_host_prog = substitute(system('which python3'),"\n","","")

"-----------------------
" 表示系
"-----------------------
" let g:loaded_matchparen = 1

augroup vimrchighlight
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

function! s:get_syn_id(transparent)
  let synid = synID(line('.'), col('.'), 1)
  return a:transparent ? synIDtrans(synid) : synid
endfunction
function! s:get_syn_name(synid)
  return synIDattr(a:synid, 'name')
endfunction
function! s:get_highlight_info()
  execute "highlight " . s:get_syn_name(s:get_syn_id(0))
  execute "highlight " . s:get_syn_name(s:get_syn_id(1))
endfunction
command! HighlightInfo call s:get_highlight_info()

augroup ZenkakuSpace
  au!
  au VimEnter,WinEnter,BufRead * let w:m1 = matchadd("ZenkakuSpace", '　')
augroup END

set t_Co=256

if ($ITERM_PROFILE == 'light')
  set background=light
else
  set background=dark
endif


if (has("termguicolors"))
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  augroup mycolorscheme
    autocmd!
    "" タブラインの色
    autocmd ColorScheme * hi TabLineSel  term=bold cterm=bold gui=bold            guibg=none
    autocmd ColorScheme * hi TabLine     term=none cterm=none gui=none guifg=gray guibg=none
    autocmd ColorScheme * hi TabLineFill term=none cterm=none gui=none guifg=gray guibg=none

    autocmd ColorScheme * hi ZenkakuSpace cterm=underline
  augroup END

  if &background == "dark"
    let ayucolor="mirage" " for mirage version of theme
    " let ayucolor="dark"   " for dark version of theme
    augroup mycolorscheme

      "quickfixの色
      autocmd ColorScheme * hi link QuickFixLine Normal "現在選択中のファイル
      autocmd ColorScheme * hi link qfFileName Normal "通常のファイル

      autocmd ColorScheme * hi SpecialKey ctermfg=14 guifg=#5C6773
      autocmd ColorScheme * hi NonText ctermfg=NONE guifg=NONE

      autocmd ColorScheme * hi Normal ctermbg=NONE guibg=NONE
      autocmd ColorScheme * hi NonText ctermbg=NONE guibg=NONE
      autocmd ColorScheme * hi SpecialKey ctermbg=NONE guibg=NONE
      autocmd ColorScheme * hi EndOfBuffer ctermbg=NONE guibg=NONE
      " autocmd ColorScheme * hi CursorLine ctermbg=NONE guibg=NONE
      " autocmd ColorScheme * hi CursorLineNr ctermbg=NONE guibg=NONE
      autocmd ColorScheme * hi SignColumn ctermbg=NONE guibg=NONE

      autocmd ColorScheme * hi link Folded Comment

    augroup END
    colorscheme ayu
    " colorscheme one
  endif

  if &background == "light"
    let ayucolor="light"  " for light version of theme

    augroup mycolorscheme
    augroup END
    colorscheme one
    " colorscheme PaperColor
  endif
else
  augroup mycolorscheme
    autocmd!
    "補完メニューの色
    autocmd ColorScheme * hi Pmenu ctermfg=73 ctermbg=16 guifg=#66D9EF guibg=#000000
    autocmd ColorScheme * hi PmenuSel ctermfg=252 ctermbg=23 guibg=#808080
    autocmd ColorScheme * hi PmenuSbar ctermbg=232 guibg=#080808
    autocmd ColorScheme * hi PmenuThumb ctermfg=103 ctermbg=15 guifg=#66D9EF guibg=White

    " 選択
    autocmd ColorScheme * hi Visual ctermbg=238

    "行番号
    autocmd ColorScheme * hi LineNr ctermfg=239
    autocmd ColorScheme * hi CursorLineNr ctermfg=250

    " その他
    " autocmd ColorScheme * hi clear CursorLine
    " autocmd ColorScheme * hi CursorLine ctermbg=236

    autocmd ColorScheme * hi Delimiter ctermfg=247
    autocmd ColorScheme * hi Comment ctermfg=73
  augroup END

  colorscheme mopkai
endif

if dein#tap('vim-better-whitespace')
  let g:better_whitespace_enabled=1
  let g:better_whitespace_ctermcolor='14'
  let g:better_whitespace_guicolor='#5C6773'
  " let g:strip_whitespace_on_save=1
  " let g:strip_whitespace_on_save = 1
  " let g:strip_max_file_size = 1000

  let g:better_whitespace_filetypes_blacklist=['markdown', 'diff', 'gitcommit', 'qf', 'help', 'dein', 'denite', 'vaffle', 'defx']
endif

let g:is_bash = 1
" colorscheme pencil
" let g:pencil_higher_contrast_ui = 0
" let g:pencil_neutral_headings = 1
" let g:pencil_neutral_code_bg = 1

" let g:python3_host_prog = 1

"set nonumber
set signcolumn=yes
set number
set nomore
set showmode          " モード表示
set title             " 編集中のファイル名を表示
set ruler             " ルーラーの表示
set showcmd           " 入力中のコマンドをステータスに表示する
set laststatus=2      " ステータスラインを常に表示
set cursorline        " 下線
set wrap              " 画面幅で折り返す
set list              " 不可視文字表示
set listchars=tab:>-
set display=uhex      " 印字不可能文字を16進数で表示
set nf=hex            " 数値インクリメントは10進数か16進数
set splitbelow        " 水平分割時は新しいwindowを下に
set splitright        " 垂直分割時は新しいwindowを右に
set ambiwidth=double  " 絵文字>
set spelllang+=cjk
set pumblend=15
set fillchars=eob:\ 
set iskeyword=@,48-57,_,192-255,#,$


"------------------------------
" 移動系
"------------------------------
" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction


"------------------------------
" 行文字
"------------------------------
:command! Nonum :set nonumber
:command! Num :set number

"------------------------------
"検索系
"------------------------------
set wrapscan        " 最後まで検索したら先頭へ戻る
set ignorecase      " 大文字小文字無視
set smartcase       " 大文字ではじめたら大文字小文字無視しない
set incsearch       " インクリメンタルサーチ

augroup vimrcincsearchhighlight
  autocmd!
  autocmd CmdlineEnter [/\?] :set hlsearch
augroup END

"--------------------------------
"ファイル操作
"--------------------------------
set autowrite
set nofixeol

" autocmd CursorHold * wall
" autocmd CursorHoldI * wall

set autoread                        " 更新時自動再読込み
set hidden                          " 編集中でも他のファイルを開けるようにする
set noswapfile                      " スワップファイルを作らない
set nobackup                        " バックアップを取らない
" autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去する

" 保存時にディレクトリがなければ作成
function! s:auto_mkdir(dir, force) abort " {{{
  if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &enc, &tenc), 'p')
  endif
endfunction " }}}
autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

" shebang持ちのファイルの保存時に実行権限を付与
if executable('chmod')
  autocmd BufWritePost * :call AddExecmod()
  function AddExecmod()
    let line = getline(1)
    if strpart(line, 0, 2) == "#!"
      call system("chmod +x ". expand("%"))
    endif
  endfunction
endif

" ファイルを開いた際に、前回終了時の行で起動
augroup open_last_row
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

"backspaceの挙動
set backspace=start,eol,indent

set scrolloff=0
set history=1000

command! -nargs=? -bang PWD echo expand('%') 

command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd ' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction

set tabline=%!MyTabLine()

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
      let issel = "v:true"
    else
      let s .= '%#TabLine#'
      let issel = "v:false"
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ',' . issel . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

set cmdwinheight=5

function! MyTabLabel(n, issel)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let bufname =  bufname(buflist[winnr - 1])
  let filename = fnamemodify(bufname, ":t:r")
  let extension = fnamemodify(bufname, ":e")

  let strlength = 8
  if strlen(substitute(filename, ".", "x", "g")) > strlength && !a:issel
    let splitted = split(filename, '\zs')
    let filename = join(splitted[0:strlength], "") . '..'
  endif

  "タブ番号を付加
  if extension != ""
    let label = a:n . ':' . filename . "." . extension
  else
    let label = a:n . ':' . filename
  endif

  return label
endfunction

" https://qiita.com/tmsanrinsha/items/6a2e844768568cd937e1
function! ProfileCursorMove() abort
  let profile_file = expand('~/log/vim-profile.log')
  if filereadable(profile_file)
    call delete(profile_file)
  endif

  normal! gg
  normal! zR

  execute 'profile start ' . profile_file
  profile func *
  profile file *

  augroup ProfileCursorMove
    autocmd!
    autocmd CursorHold <buffer> profile pause | q
  augroup END

  for i in range(100)
    call feedkeys('j')
  endfor
endfunction

" paste
if &term =~ "xterm-256color"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function! XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

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
set autoindent
set smartindent
set smarttab


augroup vimrcchecktime
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

augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype vue inoremap <buffer> </ </<C-x><C-o>
augroup END

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


" set helplang=en
set helplang=ja,en
filetype plugin indent on
