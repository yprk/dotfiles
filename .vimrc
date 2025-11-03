" General settings
set nocompatible
set number
set relativenumber
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set clipboard=unnamedplus

" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" UI improvements
set ruler
set showcmd
set cursorline
set wildmenu
set laststatus=2

" Split behavior
set splitbelow
set splitright

" Performance
set lazyredraw

" Plugins (with vim-plug)
" Install vim-plug first: curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

" Sensible defaults
Plug 'tpope/vim-sensible'

" File tree
Plug 'preservim/nerdtree'

" Fuzzy finder (requires fzf installation)
Plug 'junegunn/fzf.vim'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Git integration
Plug 'tpope/vim-fugitive'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

" Color scheme
set background=dark
" colorscheme gruvbox  " Uncomment after installing plugins

" Key bindings
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Rg<CR>

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Clear search highlighting
nnoremap <leader>/ :nohlsearch<CR>

" Toggle line numbers
nnoremap <leader>n :set number!<CR>

" Auto-commands
autocmd BufWritePre * :%s/\s\+$//e  " Remove trailing whitespace on save