" Skip initialization for vim-tiny or vim-small
if 0 | endif

""""""""""""
" NeoBundle
""""""""""""
" Initial installation via git (done automatically, see below):
"   git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
""
" Bundles management:
"   :NeoBundleList - list configured bundles
"   :NeoBundleInstall(!) - install (update) bundles
"   :NeoBundleClean(!) - confirm (or auto-approve) removal of unused bundles
"   Refer to :help neobundle for more examples and for a full list of commands.
""

"" Auto-install NeoBundle
if !isdirectory(expand('~/.vim/bundle/neobundle.vim'))
    if executable ('git')
        echo "> Installing NeoBundle...\n"
        silent exe '!git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim'
    else
        echo 'You must install git before using this vimrc file'
        finish
    endif
endif

"" Initialization
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

"" Let NeoBundle manage itself
NeoBundleFetch 'Shougo/neobundle.vim'

"" My bundles
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'

NeoBundle 'beyondwords/vim-twig'
NeoBundle 'groenewege/vim-less'
NeoBundle 'slim-template/vim-slim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tpope/vim-rails'

if has('lua')
    NeoBundle 'Shougo/neocomplete'
else
    NeoBundle 'Shougo/neocomplcache'
endif

if executable('ctags')
    NeoBundle 'majutsushi/tagbar'
endif

NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

if executable('fcitx')
    NeoBundle 'lilydjwg/fcitx.vim'
endif

"NeoBundle 'Shougo/neosnippet.vim'
"NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'kien/ctrlp.vim'
"NeoBundle 'flazz/vim-colorschemes'

"" End
call neobundle#end()

"" Check and ask to install bundles if needed when Vim starts
NeoBundleCheck


"""""""""""""
" Coloration
"""""""""""""

if has("syntax") || has("gui_running")

    "" Enable syntax highlighting
    syntax on

    "" Dark theme
    set background=dark

    "" Color scheme
    " gViM settings
    "   Delete italics (gViM mustang)
    "   Default font
    " Terminal settings
    "   t_Co should be correctly detected if the terminal is correctly configured
    "   ViM should not set 256 by itself
    "   tty does not support 256, so we have to test t_Co before using mustang
    if has('gui_running')
        if neobundle#is_installed("unite-colorscheme")
            color mustang
            hi String gui=none
            hi Comment gui=none
        endif
        set guifont=Liberation\ Mono\ 11
    else
        if &term =~ "-256color" || $COLORTERM =~ "gnome-terminal"
            set t_Co=256
        endif

        if &t_Co==256 && neobundle#is_installed("unite-colorscheme")
            color mustang
        endif
    endif

    "" Disable current line highlighting (prevent ViM to slow down)
    highlight CursorLine cterm=NONE

endif


""""""""""""""""""
" Various options
""""""""""""""""""

filetype plugin indent on

"" Encoding detection
set fileencodings=ucs-bom,utf-8,sjis,default,latin1
set fileencodings=ucs-bom,utf-8,default,latin1

"" Mouse support
if has("mouse")
    set mouse=a
endif

"" Folding
if has("folding")
    set foldmethod=indent
    set foldlevel=1
    set foldnestmax=1
    set nofoldenable
endif

"" Autocompletion
if has("wildmenu")
    set wildmenu
    set wildchar=<Tab>
    set wildmode=longest:full,full
endif

"" Statusline
set laststatus=2
set statusline=%F\ %m%r%w\ (%{&fenc},\ %{&ff})\ %=\ %l/%L,%v\ \ %P

"" Highlight tabs and trailing spaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

"" No backup/swap files
set nobackup
set noswapfile

"" Various options
set title
set number
set showmatch
set showcmd
set backspace=indent,eol,start
set nopaste
set nrformats=hex
set scrolloff=6
set wrap
set showfulltag

"" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

"" Tabs and indent
set smartindent
set autoindent
set copyindent
set shiftround
set smarttab
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

"" Settings for specific filetypes
if has("autocmd")
    autocmd FileType ruby setlocal softtabstop=2 tabstop=2 shiftwidth=2
endif


""""""""""""""""""
" Bundle settings
""""""""""""""""""

"" NERDTree
if neobundle#is_installed("nerdtree")

    "" Show hidden files
    let NERDTreeShowHidden=1

    "" Change the arrows appearance in the directory tree
    let NERDTreeDirArrows=0

endif

"" Unite
if neobundle#is_installed("unite.vim")

    "" Store the yank history
    let g:unite_source_history_yank_enable = 1

endif

"" Neocomplete
if neobundle#is_installed("neocomplete")

    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1

    "" Languages
    set omnifunc=syntaxcomplete#Complete

    "autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    "autocmd FileType html,twig,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    "autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    "" Enable heavy omni completion
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif

    let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

endif

"" Neocomplcache
if neobundle#is_installed("neocomplcache")

    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1

    " Languages
    set omnifunc=syntaxcomplete#Complete

    "autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    "autocmd FileType html,twig,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    "autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    if !exists('g:neocomplcache_omni_patterns')
        let g:neocomplcache_omni_patterns = {}
    endif

    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'

endif


"""""""""""""""""""""
" Keyboard behaviour
"""""""""""""""""""""

"" Fix arrow keys mapping in tmux when xterm-keys=on
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

"" Cursor behaviour when text wrapping is enabled (natural motion)
nnoremap <down> gj
nnoremap <up> gk

"" Quick navigation between splits (Ctrl+arrows)
map <C-left> <C-w>h
map <C-down> <C-w>j
map <C-up> <C-w>k
map <C-right> <C-w>l

"" Braces helpers for programming
noremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

"" Autocompletion popup
if neobundle#is_installed("neocomplete")

    "" Close the popup by pressing Enter when no choice has been selected
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        "return neocomplete#close_popup() . "\<CR>"
        " For no inserting <CR> key
        return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction

    "" Tab key for selection
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

endif

if neobundle#is_installed("neocomplete")

    "" Close the popup by pressing Enter when no choice has been selected
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        "return neocomplete#close_popup() . "\<CR>"
        " For no inserting <CR> key.
        return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction

    "" Tab key for selection
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

endif


"""""""""""""""""""""
" Keyboard shortcuts
"""""""""""""""""""""

"" :w!! = Save a file opened in read-only mode (and no root rights)
cmap w!! w !sudo tee % >/dev/null

"" Mapleader shortcuts
" , = <leader> (changed from \ to ,)
" <leader>p = Paste the system clipboard
" <leader>/ = Disable search highlight
" <leader>c = Autopreview the color schemes
" <leader>y = Display the yank history
let mapleader=","

nmap <silent> <leader>p :set paste<CR>a<C-R><S-+><Esc>:set nopaste<CR>
nmap <silent> <leader>/ :nohlsearch<CR>

if neobundle#is_installed("unite-colorscheme")
    nnoremap <leader>c :<C-u>Unite colorscheme -auto-preview<CR>
endif

if neobundle#is_installed("unite.vim")
    nnoremap <leader>y :<C-u>Unite history/yank<CR>
endif

"" FN shortcuts
" <F2> = Disable the auto-indent while pasting with the mouse or Ctrl+R (require +xterm_clipboard)
" <F3> = Open/Close NERDTree
" <F4> = Open/Close TagBar
" <F11> = Reload the .vimrc
" <F12> = Change and save the current file CRLF to Unix ones and encoding to utf-8
set pastetoggle=<F2>
if neobundle#is_installed("nerdtree")
    nmap <silent> <F3> :NERDTreeToggle<CR>
endif
if neobundle#is_installed("tagbar")
    nmap <silent> <F4> :TagbarToggle<CR>
endif
nmap <F11> :source ~/.vimrc<CR>
nmap <F12> :set ff=unix fenc=utf-8<CR>:w<CR>
