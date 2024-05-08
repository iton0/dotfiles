" Enable syntax highlighting
syntax on

" Enable line numbers and relative line numbers
set number
set relativenumber

" Set tab size to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Enable auto-indentation
set autoindent

" Enable mouse support in all modes
set mouse=a

" Highlight search results as you type
set incsearch

" Show matching brackets
set showmatch

" Use system clipboard for copy/paste
set clipboard=unnamedplus

" Enable visual line mode to highlight entire lines
set virtualedit=all

" Enable case-insensitive search
set ignorecase
set smartcase

" Show the command being typed
set showcmd

" Enable line wrapping
set wrap

" Set the number of characters before wrapping
set textwidth=80

" Enable file type detection
filetype on
filetype plugin on
filetype indent on

" Enable syntax highlighting for long lines
" NOTE: Adjust the value (100) as needed based on your preference
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%>100v.\+/
