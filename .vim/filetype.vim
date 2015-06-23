if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.scss setfiletype scss

  au! BufRead,BufNewFile *.WSF setfiletype javascript
  au BufRead,BufNewFile *.WSF set fileformat=dos

  au! BufRead,BufNewFile *.jsx setfiletype javascript
  au BufRead,BufNewFile *.jsx set fileformat=dos

  au! BufRead,BufNewFile *.sql setfiletype mysql
augroup END
