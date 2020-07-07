" .vimrc

set nocompatible                    " Disable Vi compatibility
set backspace=indent,eol,start      " Backspace through everything in INSERT mode
set ttyfast                         " Optimize for fast terminal connections
set nowrap                          " Disable word wrapping
set textwidth=0 wrapmargin=0        " Set textwidth + wrapmargin
set encoding=utf-8 nobomb           " Use UTF-8 without BOM
set shiftwidth=2                    " Use 2 spaces for indentation
set softtabstop=2                   " Use 2 spaces for soft tab
set tabstop=2                       " Use 2 spaces for tab
set expandtab                       " Expand tab to spaces
set scrolloff=3                     " Start scrolling three lines before the horizontal window border
set cursorline                      " Cursor line
set nostartofline                   " Don’t reset cursor to start of line when moving around.

" Show line number, highlight current line
set number
:highlight LineNr guibg=green guifg=black
:highlight CursorLine cterm=none ctermbg=green ctermfg=black guibg=darkred guifg=white

" Centralize backups, swapfiles and undo history
set backupdir=$HOME/.vim/backups
set directory=$HOME/.vim/swaps

if exists("&undodir")
  set undodir=$HOME/.vim/undo
endif

" Set viminfo directory
set viminfo+=n$HOME/.vim/.viminfo

" Set cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and
" use tmux's 24-bit color support see:
"   - http://sunaku.github.io/tmux-24bit-color.html#usage for more information.
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 https://github.com/neovim/neovim/pull/2198
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  " For Neovim > 0.1.5 and Vim > patch 7.4.1799
  "   - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
  "
  " Based on Vim patch 7.4.1770 (`guicolors` option)
  "   - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
  "   - https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax enable                         " Enable syntax highlighting
silent! colorscheme onedark           " Set colorscheme

