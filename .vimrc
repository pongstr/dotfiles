" .vimrc

" Disable Vi compatibility
set nocompatible

if has("syntax")
    " Enable syntax highlighting
    syntax enable
    " Set colorscheme
    silent! colorscheme base-16
endif

" Backspace through everything in INSERT mode
set backspace=indent,eol,start

" Optimize for fast terminal connections
set ttyfast

" Disable word wrapping
set nowrap
set textwidth=0 wrapmargin=0

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Use 4 spaces for indentation
set shiftwidth=2

" Use 4 spaces for soft tab
set softtabstop=2

" Use 4 spaces for tab
set tabstop=2

" Expand tab to spaces
set expandtab

" Enable line numbers
set number
:highlight LineNr guibg=green guifg=black

" Highlight current line
:highlight CursorLine cterm=none ctermbg=green ctermfg=black guibg=darkred guifg=white
set cursorline

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Centralize backups, swapfiles and undo history
set backupdir=$HOME/.vim/backups
set directory=$HOME/.vim/swaps
if exists("&undodir")
    set undodir=$HOME/.vim/undo
endif

set viminfo+=n$HOME/.vim/.viminfo

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

