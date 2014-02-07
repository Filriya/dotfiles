if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.scss setfiletype scss
  au! BufRead,BufNewFile *.WSF setfiletype javascript
  au! BufRead,BufNewFile *.sql setfiletype mysql
augroup END
