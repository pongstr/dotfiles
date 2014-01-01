" .vimrc

" Most stuff here were taken from @necolas dotfiles
" https://github.com/necolas/dotfiles/blob/master/vim/vimrc

" !silent is used to suppress error messages if the config line
" references plugins/colorschemes that might be missing

" Disable Vi compatibility
set nocompatible

if has("syntax")
    " Enable syntax highlighting
    syntax enable
    " Set dark background
    set background=dark
    " Set colorscheme
   colorscheme solarized
endif

" syntax enable
" set background=dark
" colorscheme solarized

" Enable line numbers
set number

" Use 2 spaces for indentation
set shiftwidth=2

" Use 2 spaces for soft tab
set softtabstop=2

" Use 2 spaces for tab
set tabstop=2

" Highlight current line
" set cursorline

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Backspace through everything in INSERT mode
set backspace=indent,eol,start

