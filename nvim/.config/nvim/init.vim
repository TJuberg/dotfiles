set nocompatible               " be iMproved
filetype off                   " required!

if !has('nvim')
    let s:editor_root=expand("~/.vim")
else
    let s:editor_root=expand("~/.nvim")
endif

"set rtp+=~/.vundle/plugins/Vundle.vim/
"call vundle#begin('~/.vundle/plugins')

set runtimepath^=~/.dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.dein')) " plugins' root path

" Let dein manage dein
call dein#add('Shougo/dein.vim')


" let Vundle manage Vundle
" required!
"Plugin 'VundleVim/Vundle.vim'

" My Bundles here:
"
" original repos on github

" Sensible defaults as a base
"Plugin 'tpope/vim-sensible'
if !has('nvim')
    call dein#add('tpope/vim-sensible')
endif

" Git wrapper
"Plugin 'tpope/vim-fugitive'
call dein#add('tpope/vim-fugitive')

" Motion on steroids
"Plugin 'Lokaltog/vim-easymotion'
call dein#add('Lokaltog/vim-easymotion')

" HTML helper
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Python awesomeness
"Plugin 'nvie/vim-flake8'
"Plugin 'python.vim'
"Plugin 'python_match.vim'
"Plugin 'pythoncomplete'
call dein#add('andviro/flake8-vim',
            \{'on_ft': ['py']})
call dein#add('vim-scripts/python.vim',
            \{'on_ft': ['py']})
call dein#add('vim-scripts/python_match.vim',
            \{'on_ft': ['py']})
call dein#add('vim-scripts/pythoncomplete',
            \{'on_ft': ['py']})

" Javascript awesomeness
"Plugin 'elzr/vim-json'
"Plugin 'groenewege/vim-less'
"Plugin 'pangloss/vim-javascript'
"Plugin 'briancollins/vim-jst'
"Plugin 'kchmck/vim-coffee-script'

call dein#add('elzr/vim-json',
            \{'on_ft': ['js']})
call dein#add('groenewege/vim-less',
            \{'on_ft': ['js']})
call dein#add('pangloss/vim-javascript',
            \{'on_ft': ['js']})
call dein#add('briancollins/vim-jst',
            \{'on_ft': ['js']})
call dein#add('kchmck/vim-coffee-script',
            \{'on_ft': ['js']})

" php awesomeness
"Plugin 'spf13/PIV'
"Plugin 'arnaud-lb/vim-php-namespace'

call dein#add('spf13/PIV',
            \{'on_ft': ['php', 'php5']})
call dein#add('arnaud-lb/vim-php-namespace',
            \{'on_ft': ['php', 'php5']})

"Plugin 'tpope/vim-markdown'
"Plugin 'Puppet-Syntax-Highlighting'
call dein#add('tpope/vim-markdown')


" Solarized, make life easier on your eyes
"Plugin 'altercation/vim-colors-solarized'
"call dein#add('altercation/vim-colors-solarized')

call dein#add('morhetz/gruvbox')



" Nerdtree / Neo Tree
if !has('nvim')
    call dein#add('scrooloose/nerdtree',
                \{'on_cmd': 'NERDTreeToggle'})
else
    call dein#add('nvim-lua/plenary.nvim')
    call dein#add('kyazdani42/nvim-web-devicons')
    call dein#add('MunifTanjim/nui.nvim')
    call dein#add('nvim-neo-tree/neo-tree.nvim')
endif

" vim-syntax-extra
"Plugin 'justinmk/vim-syntax-extra'

"Plugin 'scrooloose/syntastic'
"Plugin 'mattn/gist-vim'
"Plugin 'scrooloose/nerdcommenter'
"Plugin 'godlygeek/tabular'
"Plugin 'Shougo/neocomplete.vim'

call dein#add('mattn/gist-vim')
call dein#add('scrooloose/nerdcommenter')
call dein#add('godlygeek/tabular')

" i3
call dein#add('PotatoesMaster/i3-vim-syntax',
            \{'on_ft': ['i3']})

" Ansible
call dein#add('pearofducks/ansible-vim')

" Surround
call dein#add('tpope/vim-surround')

" Commentary
call dein#add('tpope/vim-commentary')

" Move
call dein#add('matze/vim-move')

" Goyo https://github.com/junegunn/goyo.vim
call dein#add('junegunn/goyo.vim')

" Limelight https://github.com/junegunn/limelight.vim
call dein#add('junegunn/limelight.vim')

" *complete
call dein#add('Shougo/deoplete.nvim')
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif
let g:deoplete#enable_at_startup = 1


autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Linting
call dein#add('w0rp/ale')
call deoplete#custom#option('sources', {
\ '_': ['ale'],
\})

augroup omnifuncs
    autocmd!
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete<Paste>
augroup end

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" puppet
call dein#add('rodjek/vim-puppet')

" vim-scripts repos
call dein#add('vim-scripts/L9')
call dein#add('vim-scripts/FuzzyFinder')

" Saltstack and jinja
call dein#add('saltstack/salt-vim')
call dein#add('glench/vim-jinja2-syntax')

" vim taskwarrior
if executable('task')
  call dein#add('blindFS/vim-taskwarrior')
endif

" Misc
call dein#add('bling/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('zplug/vim-zplug',
                \{'on_ft': ['zplug']})
call dein#add('ntpeters/vim-better-whitespace')
" All of your Plugins must be added before the following line
call dein#end()

" file type detection and smart indent
filetype plugin indent on


" If you want to install not installed plugins on startup."
if dein#check_install()"
    call dein#install()"
endif"


" SensibleVIM
if !has('nvim')
    runtime! plugin/sensible.vim
endif

" Flake8
let g:PyFlakeOnWrite = 1

" Nerdtree / NeoTree
" ctrl + n
if !has('nvim')
    map <C-n> :NERDTreeToggle<CR>
else
    map <C-n> :NeoTreeShowToggle<CR>
endif

" gruvbox
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark    " Setting dark mode

" if has('nvim')
"    set termguicolors
" endif


if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


if !has('nvim')
    " Neocomplete
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif

    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return neocomplete#close_popup() . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

    " For cursor moving in insert mode(Not recommended)
    "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
    "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
    "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
    "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
    " Or set this.
    "let g:neocomplete#enable_cursor_hold_i = 1
    " Or set this.
    "let g:neocomplete#enable_insert_char_pre = 1

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif

" UTF8 or die.
set encoding=utf8

" numbered lines
set number

" Keep cursor away from edges of screen.
set so=14

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" strip whitespace {
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }

" Mouse usage enabled in normal mode.
set mouse=n

" Set xterm2 mouse mode to allow resizing of splits with mouse inside Tmux.
if !has('nvim')
    set ttymouse=xterm2
endif

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

" always show the status line as the second last line
set laststatus=2

" status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]



" Formatting {
set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
"set matchpairs+=<:>             " Match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" Remove trailing whitespaces and ^M chars
" To disable the stripping of whitespace, add the following to your
autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
"autocmd FileType go autocmd BufWritePre <buffer> Fmt
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
" preceding line best in a plugin but here for now.

autocmd BufNewFile,BufRead *.coffee set filetype=coffee

" Workaround vim-commentary for Haskell
autocmd FileType haskell setlocal commentstring=--\ %s
" Workaround broken colour highlighting in Haskell
autocmd FileType haskell setlocal nospell

" }


" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
if !has('nvim')
    set viminfo='10,\"100,:20,%,n~/.viminfo
else
    set viminfo='10,\"100,:20,%,n~/.nviminfo
endif

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

if &term =~ 'screen-256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'


" Taskwarrior
let g:task_rc_override = 'rc.defaultwidth=0'
let g:task_rc_override = 'rc.defaultheight=0'
" default task report type
let g:task_report_name     = 'next'
" custom reports have to be listed explicitly to make them available
"let g:task_report_command  = []
" whether the field under the cursor is highlighted
let g:task_highlight_field = 1
" can not make change to task data when set to 1
let g:task_readonly        = 0
" vim built-in term for task undo in gvim
let g:task_gui_term        = 1
" allows user to override task configurations. Seperated by space. Defaults to ''
let g:task_rc_override     = 'rc.defaultwidth=999'
" default fields to ask when adding a new task
let g:task_default_prompt  = ['due', 'description']
" whether the info window is splited vertically
let g:task_info_vsplit     = 1
" info window size
let g:task_info_size       = 15
" info window position
let g:task_info_position   = 'belowright'
" directory to store log files defaults to taskwarrior data.location
let g:task_log_directory   = '~/.task'
" max number of historical entries
let g:task_log_max         = '20'
" forward arrow shown on statusline
let g:task_left_arrow      = ' <<'
" backward arrow ...
let g:task_left_arrow      = '>> '
