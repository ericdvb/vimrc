set nocompatible " be iMproved, required
filetype off     " required

" set runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call plug#begin()

" vim-plug plugins
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'delimitMate.vim'
Plug 'docunext/closetag.vim'
Plug 'https://github.com/terryma/vim-multiple-cursors.git'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-surround'

call plug#end() " required

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

" normalize window widths when opening a new vertical split from netrw
augroup NetrwGroup
  autocmd! BufEnter * call NormalizeWidths()
augroup END

"allow jsx syntax highlighting in js files
let g:jsx_ext_required = 0

" netrw settings
let g:netrw_banner=0  " no banner
let g:netrw_browse_split=0
let g:netrw_altv=1    " open files on right
let g:netrw_preview=1 " open previews vertically

" NERDTree settings

" open splits to the right of current split. not NERDTree specific.
set splitright

" open nerdtree with \`
map <leader>` :NERDTreeToggle<CR>

" close vim if nerdtree is the only thing left 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" open nerdtree if no file is specified on the command line
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open nerdtree to the file that's open in your current tab
nnoremap <silent> <Leader>`f :NERDTreeFind<CR>

"close nerdtree when you open a file
let NERDTreeQuitOnOpen = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! NormalizeWidths()
  let eadir_pref = &eadirection
  set eadirection=hor
  set equalalways! equalalways!
  let &eadirection = eadir_pref
endf
