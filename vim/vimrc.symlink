set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github

" Sensible defaults as a base
Bundle 'tpope/vim-sensible'

" Git wrapper
Bundle 'tpope/vim-fugitive'

" Motion on steroids
Bundle 'Lokaltog/vim-easymotion'

" HTML helper
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

" Python awesomeness
Bundle 'nvie/vim-flake8'

" Solarized, make life easier on your eyes
Bundle 'altercation/vim-colors-solarized'

" Nerdtree
Bundle 'scrooloose/nerdtree'

" vim-syntax-extra
Bundle 'justinmk/vim-syntax-extra'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'saltstack/salt-vim'

Bundle 'Rykka/localbundle.vim'
if isdirectory(expand('~/.vim/bundle/localbundle.vim'))
        call localbundle#init()
endif


" SensibleVIM
runtime! plugin/sensible.vim

" Flake8
autocmd BufWritePost *.py call Flake8()

" Nerdtree
" ctrl + n
map <C-n> :NERDTreeToggle<CR>

" Solarize
let solarized_termtrans=1
syntax enable
set t_Co=256
set background=dark
colorscheme solarized

" UTF8 or die.
set encoding=utf8

" numbered lines
set number

" Keep cursor away from edges of screen.
set so=14

" Highlight cursor line.
" augroup CursorLine
"    au!
"    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"    au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
"    au WinLeave * setlocal nocursorline
"    au WinLeave * setlocal nocursorcolumn
"augroup END

" Mouse usage enabled in normal mode.
set mouse=n

" Set xterm2 mouse mode to allow resizing of splits with mouse inside Tmux.
set ttymouse=xterm2

" Control character highlighting.
" set list listchars=tab:⇥⇥,eol:↵

" Tab settings.
set expandtab
set shiftwidth=4
set ts=4
set smarttab
set cindent
let indent_guides_enable_on_vim_startup = 1

" Make trailing whitespace annoyingly highlighted.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Automatically leave insert mode after 'updatetime' (4s by default).
" au CursorHoldI * stopinsert

" file type detection and smart indent
filetype plugin indent on

" always show the status line as the second last line
set laststatus=2

" status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" toggle paste mode
set pastetoggle=<F10>

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" ~/.vimrc
" Make Vim recognize xterm escape sequences for Page and Arrow
" keys combined with modifiers such as Shift, Control, and Alt.
" See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
if &term =~ '^screen'
  " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
  execute "set t_kP=\e[5;*~"
  execute "set t_kN=\e[6;*~"
     
  " Arrow keys http://unix.stackexchange.com/a/34723
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
