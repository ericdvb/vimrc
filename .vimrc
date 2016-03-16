set nocompatible " be iMproved, required
filetype off     " required

" set runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'docunext/closetag.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'Vimball'
Plugin 'bling/vim-airline'

call vundle#end() " required

" alternative nerdcommenter delimiters
let g:NERDCustomDelimiters = {
  \ 'tpl': { 'left': '<!--', 'right': '-->', 'leftAlt': '{#', 'rightAlt': '#}' }
\}

" enable filetype plugins
filetype plugin on
filetype plugin indent on

" enable matchit
runtime macros/matchit.vim

" set tab size and expand option
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set smarttab

" auto indentation
set ai

" smart indentation
set si

" line wrap
set wrap

" show line numbers
set nu

" change backspace behavior
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" case insensitive search by default
set ignorecase

" when searching be smart about case
set smartcase

" jump to next search results automatically while entering search
set incsearch

" drawing performance optimization
set lazyredraw

" no error sound
set noerrorbells

" enable syntax highlighting
syntax on 

" turn off the swapfile
set noswapfile

" treat long lines as break lines
map j gj
map k gk

" mappings for tab shortcut keys
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>
map <leader>te :Tex<cr>

" always show status line
 set laststatus=2

" format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" shortcut to copy to system clipboard
vmap '' :w !pbcopy<CR><CR>

" when you press gv, vimgrep after selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" superRetab converts selected leading tabs to spaces and vice versa
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

" colorscheme solarized
let g:solarized_termcolors=16
set t_Co=16
set background=dark
colorscheme solarized

" mappings for netrw shorcut keys
noremap <Leader><Tab> :call VexToggle(getcwd())<CR>
noremap <Leader>` :call VexToggle("")<CR>

" normalize window widths when opening a new vertical split from netrw
augroup NetrwGroup
  autocmd! BufEnter * call NormalizeWidths()
augroup END

" netrw settings
let g:netrw_banner=0  " no banner
let g:netrw_browse_split=0
let g:netrw_altv=1    " open files on right
let g:netrw_preview=1 " open previews vertically

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

fun! VexToggle(dir)
  if exists("t:vex_buf_nr")
    call VexClose()
  else
    call VexOpen(a:dir)
  endif 
endf

fun! VexOpen(dir)
  let g:netrw_browse_split=4
  let vex_width = 25

  execute "Vexplore" . a:dir 
  let t:vex_buf_nr = bufnr("%")
  wincmd H

  call VexSize(vex_width)
endf

fun! VexClose()
  let cur_win_nr = winnr()
  let target_nr = ( cur_win_nr == 1 ? winnr("#") : cur_win_nr )

  1wincmd w
  close
  unlet t:vex_buf_nr
  let g:netrw_browse_split=0

  execut (target_nr - 1) . "wincmd w"
  call NormalizeWidths()
endf

fun! VexSize(vex_width)
  execute "vertical resize" . a:vex_width
  set winfixwidth
  call NormalizeWidths()
endf

fun! NormalizeWidths()
  let eadir_pref = &eadirection
  set eadirection=hor
  set equalalways! equalalways!
  let &eadirection = eadir_pref
endf
