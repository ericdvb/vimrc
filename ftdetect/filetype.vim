" Django Template files
au BufNewFile,BufRead *.tpl   set filetype=tpl|set syntax=html

" autocomplete for various filetypes
au FileType php setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby setl ofu=rubycomplete#CompleteRuby
au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
au FileType css setl ofu=csscomplete#CompleteCSS

" autocomplete xml tags
au FileType html,xml,xsl let b:closetag_html_style=1
au FileType html,xml,xsl source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
