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
let s:dein_dir = expand('~/.vim.bundle')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim' " dein.vim 本体
let g:dein#install_process_timeout =  600

" deinが入っていなければinstall
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" 設定開始
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let s:toml = '~/.vim/dein.toml'

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


"-------------------
" keymap
"-------------------
noremap <Leader> <Nop>
let mapleader = "\<Space>"

"esc2回でハイライトを消す
nnoremap <silent> <ESC><ESC> :noh<cr>
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
noremap ; :

" 検索時語句を中心にする
nnoremap * *zz
nnoremap n nzz
nnoremap N Nzz

" exモードを無効に
nnoremap Q <Nop>


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

nnoremap <silent> <C-t>t :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> <C-t><C-t> :<C-u>tabnew<CR>:tabmove<CR>
nnoremap <silent> <C-t>d :<C-u>tabclose<CR>
nnoremap <silent> <C-t><C-d> :<C-u>tabclose<CR>

nnoremap <silent> <C-w>v :<C-u>vsp<CR>
nnoremap <silent> <C-w>s :<C-u>sp<CR>

nnoremap <C-z> `.zz

if dein#tap('defx.nvim')
  nnoremap <silent> <C-e> :Defx -split=vertical -winwidth=40 -direction=topleft `expand('%:p:h')` -search=`expand('%:p')`<CR>
endif


".edit config
nnoremap <silent> <Leader>es :<C-u>source $MYVIMRC<CR>
nnoremap <silent> <Leader>ev :<C-u>tabnew $MYVIMRC<CR>

" reload file
nnoremap <silent> <Leader>R :<C-u>e<CR>

" help
nnoremap          <Leader>H :tab help<space>

" save and quit
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Leader>Q :qa!<CR>

if dein#tap('unite.vim')
  nnoremap <Leader>o :Unite outline -vertical<CR>
endif

" if dein#tap('denite.nvim')
"   nnoremap <silent> <Leader>b :<C-u>Denite buffer<CR>
"   nnoremap <silent> <Leader>u :<C-u>Denite file_mru<CR>
"   nnoremap <silent> <Leader>f :<C-u>Denite file/rec<CR>
"   nnoremap <silent> <Leader>g :<C-u>Denite grep<CR>
"   nnoremap <silent> <Leader>y :<C-u>Denite neoyank<CR>
"   nnoremap <silent> <Leader>o :<C-u>Denite -split=vertical unite:outline<CR>
" endif

if dein#tap('fzf.vim')
  nnoremap <silent> <Leader>f :<C-u>GFiles<CR>
  nnoremap <silent> <Leader>F :<C-u>Files<CR>
  nnoremap <silent> <Leader>E :<C-u>SrcFiles<CR>
  " nnoremap <silent> <Leader>g :<C-u>GFiles?<CR>
  nnoremap <silent> <Leader>b :<C-u>Buffers<CR>
  nnoremap          <Leader>a :<C-u>Ag 
  nnoremap <silent> <Leader>/ :<C-u>Lines<CR>
  nnoremap <silent> <Leader>? :<C-u>BLines<CR>
  nnoremap <silent> <Leader>t :<C-u>Tags<CR>
  nnoremap <silent> <Leader>h :<C-u>History<CR>
  nnoremap <silent> <C-]> :call fzf#vim#tags(expand('<cword>'))<CR>
endif

if dein#tap('coc.nvim')
  inoremap <silent><expr> <TAB>
       \ pumvisible() ? "\<C-n>" :
       \ <SID>check_back_space() ? "\<TAB>" :
       \ coc#refresh()

  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" deoplete
"   " <CR>: close popup and save indent.
"   inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"   function! s:my_cr_function() abort
"     return deoplete#cancel_popup() . "\<CR>"
"   endfunction

" neosnippet supertab
"   " SuperTab like snippets behavior.
"   imap <expr><TAB>
"        \ pumvisible()
"        \ ? (neosnippet#expandable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<C-y>")
"        \ : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"
"   smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> gl coc#refresh()


  " Use `[c` and `]c` to navigate diagnostics
  nmap <silent> g[ <Plug>(coc-diagnostic-prev)
  nmap <silent> g] <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nnoremap <silent> gD :call <SID>show_documentation()<CR>

  " Remap for rename current word
  nmap gR <Plug>(coc-rename)

  " Remap for format selected region
  xmap gf <Plug>(coc-format-selected)
  nmap gf <Plug>(coc-format-selected)

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  xmap ga <Plug>(coc-codeaction-selected)
  nmap ga <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  nmap gac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap gqf  <Plug>(coc-fix-current)

  " Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
  " nmap <silent> <TAB> <Plug>(coc-range-select)
  " xmap <silent> <TAB> <Plug>(coc-range-select)
  " xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

  "よくわかんない
  " Using CocList
  " Show all diagnostics
  " nnoremap <silent> gla  :<C-u>CocList diagnostics<cr>
  " " Manage extensions
  " nnoremap <silent> gle  :<C-u>CocList extensions<cr>
  " " Show commands
  " nnoremap <silent> glc  :<C-u>CocList commands<cr>
  " " Find symbol of current document
  " nnoremap <silent> glo  :<C-u>CocList outline<cr>
  " " Search workspace symbols
  " nnoremap <silent> gls  :<C-u>CocList -I symbols<cr>
  " " Do default action for next item.
  " nnoremap <silent> gj  :<C-u>CocNext<CR>
  " " Do default action for previous item.
  " nnoremap <silent> gk  :<C-u>CocPrev<CR>
  " " Resume latest coc list
  " nnoremap <silent> gp  :<C-u>CocListResume<CR>

  " coc snip
  " imap <C-l> <Plug>(coc-snippets-expand)
  " vmap <C-j> <Plug>(coc-snippets-select)
  " " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  " let g:coc_snippet_next = '<c-j>'
  " " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  " let g:coc_snippet_prev = '<c-k>'
  " " Use <C-j> for both expand and jump (make expand higher priority.)
  " imap <C-j> <Plug>(coc-snippets-expand-jump)
  " inoremap <silent><expr> <TAB>
  "      \ pumvisible() ? coc#_select_confirm() :
  "      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  "      \ <SID>check_back_space() ? "\<TAB>" :
  "      \ coc#refresh()

  "  " coc#expandable() coc#jumpable() and coc#expandableOrJumpable().
  " function! s:check_back_space() abort
  "   let col = col('.') - 1
  "   return !col || getline('.')[col - 1]  =~# '\s'
  " endfunction
  " let g:coc_snippet_next = '<tab>'
endif

" --------------------
" php documentor
" --------------------
if dein#tap('PDV--phpDocumentor-for-Vim')
  augroup php-dev
    autocmd!
    autocmd FileType php nnoremap <Leader>P :call PhpDocSingle()<CR>
    autocmd FileType php vnoremap <Leader>P :call PhpDocRange()<CR>
  augroup End
endif

"--------------------
" EasyAlign
" ------------------
if dein#tap('vim-easy-align')
  " Start interactive EasyAlign in visual mode (e.g. vipga)
  xmap <Leader>A <Plug>(EasyAlign)
  " Start interactive EasyAlign for a motion/text object (e.g. gaip)
  nmap <Leader>A <Plug>(EasyAlign)
endif

"----------------------
" caw.vim
"----------------------
if dein#tap('caw.vim')
  "" 行の最初の文字の前にコメント文字をトグル
  nmap <Leader>c <Plug>(caw:hatpos:toggle)
  nmap <Leader>C <Plug>(caw:wrap:toggle)
  vmap <Leader>c <Plug>(caw:hatpos:toggle)
  vmap <Leader>C <Plug>(caw:wrap:toggle)
endif

"----------------------
" incsearch-migemo.vim
"----------------------
if dein#tap('incsearch-migemo.vim')
  nmap g/ <Plug>(incsearch-migemo-/)
  nmap g? <Plug>(incsearch-migemo-?)
endif

"----------------------
" vim-easymotion
"----------------------
if dein#tap('vim-easymotion')
  " <Leader>f{char} to move to {char}
  map  f <Plug>(easymotion-fl)
  map  F <Plug>(easymotion-Fl)
  map  t <Plug>(easymotion-tl)
  map  T <Plug>(easymotion-Tl)

  " s{char}{char} to move to {char}{char}
  nmap <Leader>s <Plug>(easymotion-overwin-f2)
  vmap <Leader>s <Plug>(easymotion-bd-f2)

  " Move to line
  map <Leader>l <Plug>(easymotion-bd-jk)
  nmap <Leader>l <Plug>(easymotion-overwin-line)

  " Move to line
  map <Leader>l <Plug>(easymotion-bd-jk)
  nmap <Leader>l <Plug>(easymotion-overwin-line)
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)
endif

" --------------------
" sandwich
" --------------------
if dein#tap('vim-sandwich')
  runtime macros/sandwich/keymap/surround.vim
  xmap S <Nop>
  xmap s <Plug>(operator-sandwich-add)
endif

nnoremap S :%s/\v
vnoremap S :s/\v

"--------------------
"vim-fugitive
"--------------------
map <Leader>g [git]
if dein#tap("vim-fugitive")
  nnoremap [git]s :Gstatus<CR>
  nnoremap [git]r :Gread<CR>
  nnoremap [git]w :Gwrite<CR>
  nnoremap [git]c :Gcommit<CR>
  nnoremap [git]b :Gblame<CR>
  nnoremap [git]d :Gdiff<CR>
  " nnoremap [git]m :Gmove
  " nnoremap [git]R :Gremove<CR>
  vnoremap [git]b :Gbrowse<CR>
  " nnoremap [git]l :Glog --oneline<CR>
endif

if dein#tap("agit.vim")
  nnoremap [git]l :Agit<CR>
endif

if dein#tap("vim-merginal")
  nnoremap [git]B :Merginal<CR>
endif

"--------------------
" im_control.vim
"--------------------
if dein#tap('im_control.vim')
  inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
  nnoremap <silent> <C-j> :<C-u>call IMState('FixMode')<CR>
endif


" --------------------
" Keymap ここまで
" --------------------








"-----------
" defx
"----------
if dein#tap('defx.nvim')
  autocmd FileType defx call s:defx_my_settings()

  function! s:defx_my_settings() abort

    function! Defx_git_root_dir(context) abort
      if (system('git rev-parse --is-inside-work-tree') == "true\n")
        let l:path = system('git rev-parse --show-toplevel')[0]
        call defx#call_action('cd', [path])
        echomsg string(path)
      else
      endif
    endfunction
    nnoremap <silent><buffer><expr> &
         \ defx#do_action('call', 'Defx_git_root_dir')

    " Define mappings
    nnoremap <silent><buffer><expr> <CR>
         \ defx#is_directory() ?
         \ defx#do_action('open_or_close_tree'):
         \ defx#do_action('drop')
    nnoremap <silent><buffer><expr> s
         \ defx#do_action('multi', [['drop', 'split'], 'quit'])
    nnoremap <silent><buffer><expr> v
         \ defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
    nnoremap <silent><buffer><expr> t
         \ defx#do_action('multi', ['quit', ['drop', 'tabnew']])
    nnoremap <silent><buffer><expr> P defx#do_action('open', 'pedit')
    nnoremap <silent><buffer><expr> c defx#do_action('copy')
    nnoremap <silent><buffer><expr> m defx#do_action('move')
    nnoremap <silent><buffer><expr> p defx#do_action('paste')
    nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N defx#do_action('new_file')
    nnoremap <silent><buffer><expr> d defx#do_action('remove')
    nnoremap <silent><buffer><expr> r defx#do_action('rename')
    nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> l
         \ defx#is_directory() ?
         \ defx#do_action('open'):
         \ defx#do_action('drop')
    nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
    nnoremap <silent><buffer><expr> \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw')
    nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
  endfunction
endif

"-----------
"unite
"----------
if dein#tap('unite.vim')
  let g:unite_enable_start_insert=1
  let g:unite_enable_ignore_case=1
  let g:unite_enable_smart_case=1
  let g:unite_update_time = 100
  let g:unite_enable_split_vertically=1
  let g:unite_winwidth = 60
  let g:unite_winheight = 10
  let g:unite_split_rule = 'topleft'
  let g:unite_source_history_yank_enable = 1
  let g:unite_source_rec_max_cache_files = 0
  call unite#custom#source('file_rec,file_rec/async', 'max_candidates', 0)

  autocmd FileType unite call <SID>unite_settings()
  autocmd FileType vimfiler call s:my_vimfiler_settings()

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
endif

let s:unite_hooks = {}

" ----------
" denite.vim
" ----------
if dein#tap('denite.nvim')
  " Define mappings
  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q denite#do_map('quit')
    nnoremap <silent><buffer><expr> <ESC> denite#do_map('quit')
    nnoremap <silent><buffer><expr> <C-[> denite#do_map('quit')
    nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
    nnoremap <silent><buffer> <C-N> j
    nnoremap <silent><buffer> <C-P> k
  endfunction

  " Change file/rec command.
  call denite#custom#var('file/rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

  " Add custom menus
  let s:menus = {}

  let s:menus.zsh = {
        \ 'description': 'Edit your import zsh configuration'
        \ }
  let s:menus.zsh.file_candidates = [
        \ ['zshrc', '~/.config/zsh/.zshrc'],
        \ ['zshenv', '~/.zshenv'],
        \ ]

  let s:menus.my_commands = {
        \ 'description': 'Example commands'
        \ }
  let s:menus.my_commands.command_candidates = [
        \ ['Split the window', 'vnew'],
        \ ['Open zsh menu', 'Denite menu:zsh'],
        \ ['Format code', 'FormatCode', 'go,python'],
        \ ]

  call denite#custom#var('menu', 'menus', s:menus)


  " Ag command on grep source
  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])

  call denite#custom#option('_', 'mode', 'insert')

  call denite#custom#option('_', {
        \ 'statusline': v:false,
        \ 'prompt': '>',
        \ 'highlight_filter_background': 'CursorLine',
        \ 'source_names': 'short',
        \ 'split': 'horizontal',
        \ 'smartcase': v:true,
        \ 'direction': "belowright",
        \ 'winwidth': 60,
        \ 'winheight': 10,
        \ })

  call denite#custom#source('file/rec', 'matchers', ['matcher/cpsm'])

  " Define alias
  call denite#custom#alias('source', 'file/rec/git', 'file/rec')
  call denite#custom#var('file/rec/git', 'command',
        \ ['git', 'ls-files', '-co', '--exclude-standard'])

  call denite#custom#alias('source', 'file/rec/py', 'file/rec')
  call denite#custom#var('file/rec/py', 'command',['scantree.py'])

  " Change ignore_globs
  call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
        \ [ '.git/', '.ropeproject/', '__pycache__/',
        \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

endif

"--------------------
" fzf.vim
"--------------------

if dein#tap('fzf.vim')
  set rtp+=/usr/local/opt/fzf,/home/linuxbrew/.linuxbrew/opt/fzf
  " let g:fzf_command_prefix = 'Fzf'

  function! s:build_quickfix_list(lines)
    if len(a:lines) == 1
      execute 'edit '.a:lines[0]
    else
      call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
      copen
      " cc
    endif
  endfunction

  function! s:fzf_src_file() abort
    " let dirname = system("cd ".fnamemodify(resolve($MYVIMRC), ":h")."&& git rev-parse --show-toplevel")
    let l:dirname = system("dirname $(dirname $(readlink ".$MYVIMRC."))")
    call fzf#run({
        \ 'source': 'fd --type f --hidden --follow --no-ignore . '.l:dirname,
        \ 'sink': 'tab split',
        \ 'down': '40%'
        \ })
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

  " Customize fzf colors to match your color scheme
  let g:fzf_colors =
        \ { 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'border':  ['fg', 'Ignore'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'] }


  let g:fzf_buffers_jump = 1
  " let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
  let g:fzf_tags_command = 'ctags --exclude=node_modules --exclude=vendor'

  command! SrcFiles call s:fzf_src_file()
  command! -bang -nargs=+ -complete=dir Ag call fzf#vim#ag_raw(<q-args>, <bang>0)
endif

" --------------------
" coc.nvim
" --------------------
if dein#tap('coc.nvim')
  set hidden
  set nobackup
  set nowritebackup
  set cmdheight=2
  set updatetime=300
  set shortmess+=c
  set signcolumn=yes

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

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

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR  :call CocAction('runCommand', 'editor.action.organizeImport')

  " Add status line support, for integration with other plugin, checkout `:h coc-status`
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
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
  let g:EasyMotion_keys = ";asdfghkl"
endif


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
        \ 'colorscheme': 'ayu',
        \ 'enable': {
        \   'statusline': 1,
        \   'tabline': 0
        \ },
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'fugitive', 'file' ],
        \             [ 'coccurrent' ] ],
        \   'right': [ [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'jpmode', 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component_function': {
        \   'fugitive': 'MyFugitive',
        \   'readonly': 'MyReadonly',
        \   'modified': 'MyModified',
        \   'file': 'MyFile',
        \   'jpmode': 'MyJpMode',
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

  function! MyJpMode()
    return IMStatus("[jpmode]")
  endfunction

  function! MyFugitive()
    return exists('*fugitive#head') && strlen(fugitive#head()) ? ''.fugitive#head() : ''
  endfunction

  function! MyFile()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
          \ ('' != expand('%') ? ShortenPath() : '[No Name]') .
          \ ('' != MyModified() ? ' ' . MyModified() : '')
  endfunction

  function! ShortenPath()
    let path = substitute(expand('%:h'), $HOME, '~', "g")
    return substitute(path, '\v/([^/])[^/]+', '/\1', "g").'/'.expand('%:t')
  endfunction

endif

"--------------------
"vim-quickrun
"--------------------
if dein#tap("vim-quickrun")
  nnoremap <Leader>r :QuickRun<CR>
  let g:quickrun_config ={}
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
  let g:used_javascript_libs = 'jquery, react, flux, vue'
endif

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
  let g:vdebug_options['path_maps'] = {'/home/vagrant/projects': $HOME.'/Dropbox/projects'}
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

  augroup vdbug
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

"--------------------
" im_control.vim
"--------------------
if dein#tap('im_control.vim')
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

    " 「日本語入力固定モード」のMacVimKaoriya対策を無効化
    let IM_CtrlMacVimKaoriya = 0
    " ctrl+jで日本語入力固定モードをOnOff
    inoremap <silent> <C-j> <C-^><C-r>=IMState('FixMode')<CR>
    nnoremap <C-j> :<C-u>call IMState('FixMode')<CR>
  endif
else
  function! IMStatus(...)
    return ''
  endfunction
endif

"--------------------
" plugin ここまで
"--------------------


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

augroup ZenkakuSpace
  au!
  au VimEnter,WinEnter,BufRead * let w:m1 = matchadd("ZenkakuSpace", '　')
augroup END

set t_Co=256
set background=dark

if (has("termguicolors"))
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  " let ayucolor="light"  " for light version of theme
  " let ayucolor="mirage" " for mirage version of theme
  let ayucolor="dark"   " for dark version of theme

  augroup ayucolorscheme
    autocmd!
    "" タブラインの色
    autocmd ColorScheme * hi TabLineSel term=bold cterm=bold gui=bold
    autocmd ColorScheme * hi TabLine term=none cterm=none gui=none guifg=#5C6773 guibg=NONE
    autocmd ColorScheme * hi TabLineFill term=none cterm=none gui=none guifg=#5C6773

    "quickfixの色
    autocmd ColorScheme * hi link QuickFixLine Normal "現在選択中のファイル
    autocmd ColorScheme * hi link qfFileName Normal "通常のファイル

    autocmd ColorScheme * hi CursorLine guibg=#181e22

    autocmd ColorScheme * hi SpecialKey ctermfg=14 guifg=#5C6773

    autocmd ColorScheme * hi ZenkakuSpace cterm=underline

    ""補完メニューの色
    " autocmd ColorScheme * hi Pmenu ctermfg=73 ctermbg=16 guifg=#66D9EF guibg=#000000
    " autocmd ColorScheme * hi PmenuSel ctermfg=252 ctermbg=23 guibg=#808080
    " autocmd ColorScheme * hi PmenuSbar ctermbg=232 guibg=#080808
    " autocmd ColorScheme * hi PmenuThumb ctermfg=103 ctermbg=15 guifg=#66D9EF guibg=White
  augroup END

  colorscheme ayu
endif

augroup mopkaicolorscheme
  autocmd!
  "" タブラインの色
  " autocmd ColorScheme * hi TabLineSel  term=bold cterm=underline,bold ctermfg=White ctermbg=Black gui=bold,underline guifg=LightGray guibg=DarkBlue
  " autocmd ColorScheme * hi TabLine     term=reverse cterm=underline ctermfg=Gray ctermbg=black guifg=Black guibg=black
  " autocmd ColorScheme * hi TabLineFill term=bold cterm=underline,bold ctermfg=Gray ctermbg=black gui=reverse,bold guifg=black guibg=black

  ""補完メニューの色
  " autocmd ColorScheme * hi Pmenu ctermfg=73 ctermbg=16 guifg=#66D9EF guibg=#000000
  " autocmd ColorScheme * hi PmenuSel ctermfg=252 ctermbg=23 guibg=#808080
  " autocmd ColorScheme * hi PmenuSbar ctermbg=232 guibg=#080808
  " autocmd ColorScheme * hi PmenuThumb ctermfg=103 ctermbg=15 guifg=#66D9EF guibg=White
  "
  " " 選択
  " autocmd ColorScheme * hi Visual ctermbg=238
  "
  " "行番号
  " autocmd ColorScheme * hi LineNr ctermfg=239
  " autocmd ColorScheme * hi CursorLineNr ctermfg=250
  "
  "
  "" その他
  " autocmd ColorScheme * hi clear CursorLine

  " autocmd ColorScheme * hi CursorLine ctermbg=236
  " autocmd ColorScheme * hi Delimiter ctermfg=247
  " autocmd ColorScheme * hi Comment ctermfg=73
augroup END

" colorscheme mopkai

if dein#tap('vim-better-whitespace')
  let g:better_whitespace_enabled=1
  let g:better_whitespace_ctermcolor='14'
  let g:better_whitespace_guicolor='#5C6773'
  " let g:strip_whitespace_on_save=1
  " let g:strip_whitespace_on_save = 1
  " let g:strip_max_file_size = 1000

  let g:better_whitespace_filetypes_blacklist=['diff', 'gitcommit', 'unite', 'qf', 'help', 'dein', 'denite', 'vaffle', 'defx']
endif

let g:is_bash = 1
" colorscheme pencil
" let g:pencil_higher_contrast_ui = 0
" let g:pencil_neutral_headings = 1
" let g:pencil_neutral_code_bg = 1

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

augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter [/\?] :set hlsearch
augroup END

"---------------------------------
"ファイル操作
"--------------------------------
set autoread                        " 更新時自動再読込み
set hidden                          " 編集中でも他のファイルを開けるようにする
set noswapfile                      " スワップファイルを作らない
set nobackup                        " バックアップを取らない
" autocmd BufWritePre * :%s/\s\+$//ge " 保存時に行末の空白を除去する

" ファイルを開いた際に、前回終了時の行で起動
augroup open_last_row
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
augroup END

"backspaceの挙動
set backspace=start,eol,indent

set scrolloff=0
set history=1000

" augroup CmdWin
"   autocmd!
"   autocmd CmdwinEnter * call s:init_cmdwin()
" augroup END
"
" function! s:init_cmdwin()
"   nnoremap <buffer> <silent> <Esc><Esc> :<C-u>quit<CR>
"   inoremap <buffer> <silent> <Esc><Esc> <Esc>:<C-u>quit<CR>
"   startinsert!
"   resize 3
" endfunction


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
  let label = a:n . ':' . filename . "." . extension

  return label
endfunction

" paste
if &term =~ "xterm-256color"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
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


" set helplang=ja,en
filetype plugin indent on
