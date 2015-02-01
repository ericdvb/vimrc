" Django Template files
au BufNewFile,BufRead *.tpl   set filetype=tpl|set syntax=html

"autocomplete for various filetypes
au FileType php setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby setl ofu=rubycomplete#CompleteRuby
au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
au FileType css setl ofu=csscomplete#CompleteCSS
