let g:previm_open_cmd = 'open -a "Google Chrome"'
let g:gfm_syntax_enable_always = 1
let g:gfm_syntax_emoji_conceal = 1

setlocal conceallevel=1
setlocal concealcursor=""


function! s:markdown_toggle_checkbox(type, ...)
  if a:0
    let [lnum1, lnum2] = [a:type, a:1]
  else
    let [lnum1, lnum2] = [line("'["), line("']")]
  endif

  let linenr = lnum1
  while linenr <= lnum2
    let line = getline(linenr)
    if line =~ '\v^\s*[-+*]\s*\[x\]'
      let line = substitute(line, '\v^\s*[-+*]\s\zs\s*\[[^\]]*\]\s*\ze', '', '')
    elseif line =~ '\v^\s*[-+*]\s*\[\s*\]'
      let line = substitute(line, '\v^(\s*[-+*]\s*\[)\s*(\])', '\1'.'x'.'\2', '')
    elseif line =~ '\v^\s*[-+*]\s*'
      let line = substitute(line, '\v^(\s*[-+*]\s*)(.*)', '\1'.'[ ] '.'\2', '')
    endif
    call setline(linenr, line)
    let linenr += 1
  endwhile
endfunction

augroup markdown
  autocmd!
  autocmd FileType markdown syntax match mkdLineBreak /\s\s$/ conceal cchar=↵
  autocmd FileType markdown xnoremap <silent> <buffer> \
        \ :<c-u>call markdown#ex#toggle_checkbox(line("'<"), line("'>"))<cr>
  autocmd FileType markdown nnoremap <silent> <buffer> \
        \ :<c-u>set opfunc=markdown#ex#toggle_checkbox<cr>g@
  autocmd FileType markdown nnoremap <silent> <buffer> \\
        \ :<c-u>set opfunc=markdown#ex#toggle_checkbox<bar>exe 'norm! 'v:count1.'g@_'<cr>
augroup END
