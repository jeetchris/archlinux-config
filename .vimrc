""""""""""""
" NeoBundle
""""""""""""
" Installation initiale via git:
"   git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
""
" Gestion des bundles:
"   :NeoBundleList - list configured bundles
"   :NeoBundleInstall(!) - install (update) bundles
"   :NeoBundleClean(!) - confirm (or auto-approve) removal of unused bundles
"   Refer to :help neobundle for more examples and for a full list of commands.
""

" Skip initialization for vim-tiny or vim-small
if 0 | endif

" Installe NeoBundle automatiquement
if !isdirectory(expand('~/.vim/bundle/neobundle.vim'))
    if executable ('git')
        echo "> Installing NeoBundle...\n"
        silent exe '!git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim'
    else
        echo 'You must install git before using this vimrc file'
        finish
    endif
endif

" Initialisation
if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

" Laisse NeoBundle se gérer tout seul
NeoBundleFetch 'Shougo/neobundle.vim'

" Mes bundles
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

"NeoBundle 'Shougo/neosnippet.vim'
"NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'kien/ctrlp.vim'
"NeoBundle 'flazz/vim-colorschemes'

" You can specify revision/branch/tag.
"NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Fin
call neobundle#end()

filetype plugin indent on

" Vérifie au démarrage de vim si des bundles ne sont pas installés
" et demande le cas échéant si on souhaite les installer
NeoBundleCheck


"""""""""""""
" Coloration
"""""""""""""

"" Active la coloration syntaxique (syntax highlighting)
syntax on

"" Fond sombre
set background=dark

"" Jeu de couleurs
" t_Co devrait être bien détecté si le terminal est bien configuré
" Ce n'est pas à vim de le mettre à 256 soi-même
" tty ne supporte pas 256, d'où la condition pour s'en tenir au jeu par défaut
if neobundle#is_installed("unite-colorscheme")
    if &t_Co==256
        color mustang
    endif
endif

" Configuration pour gViM
" + suppression des italiques (mustang pour gViM)
" + police de caractère par défaut
if has('gui_running')
    color mustang
    hi String gui=none
    hi Comment gui=none
    set guifont=Liberation\ Mono\ 11
endif

""""""""""""
" Apparence
""""""""""""

"" Statusline
set laststatus=2
set statusline=%F\ %m%r%w\ (%{&fenc},\ %{&ff})\ %=\ %l/%L,%v\ \ %P


"""""""""""""""""""
" Options diverses
"""""""""""""""""""
filetype on
filetype plugin on

"" Détection de l'encodage
set fileencodings=ucs-bom,utf-8,sjis,default,latin1
set fileencodings=ucs-bom,utf-8,default,latin1

"" Pas de fichiers de sauvegarde
" Pas de fichiers de sauvegarde automatique (problématique
" en cas de crash). Sinon changer le dossier des swapfiles.
set nobackup
set noswapfile

"" Différentes options
set title
set number
set showmatch
set backspace=indent,eol,start
set mouse=a
set nopaste

"" Tabulation et indentation
filetype indent on
set smartindent
set autoindent
set copyindent
set shiftround
set smarttab
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
au FileType ruby setlocal softtabstop=2 tabstop=2 shiftwidth=2

"" Recherche
set ignorecase
set smartcase
set hlsearch
set incsearch

"" Mise en évidence des tabulations et espaces invisibles
" :help listchars pour les détails
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

"" Non mise en subrillance de la ligne courante
" Vim risque de laguer
highlight CursorLine cterm=NONE

"" Auto-complétion
set wildmenu
set wildchar=<Tab>
set wildmode=longest:full,full

"" Folding
set foldmethod=indent
set foldlevel=1
set foldnestmax=1
set nofoldenable

"""""""""""""""""""""
" Raccourcis clavier
"""""""""""""""""""""

"" Change la touche mapleader de \ à ,
let mapleader=","

"" Source le .vimrc
nmap <F11> :source ~/.vimrc<CR>

"" Mappage correct des touches flèches dans tmux quand xterm-keys=on
if &term =~ '^screen'
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

"" Enregistre d'un fichier ouvert en lecture seule
" Permet d'enregistrer un fichier ouvert en lecture seule
" (sans les droits root) sans avoir besoin de fermer Vim.
" Utiliser la commande :w!!
cmap w!! w !sudo tee % >/dev/null

"" Mode collage
" Passe en mode collage (set paste). Désactive l'indentation
" automatique en mode insertion via F2 afin de pouvoir coller
" un texte avec la souris ou Ctrl+r + (+ = Shift+=).
" Besoin de +xterm_clipboard dans les options de compilation.
set pastetoggle=<F2>

"" Colle le contenu du presse-papier système via <leader>p
nmap <silent> <leader>p :set paste<CR>a<C-R><S-+><Esc>:set nopaste<CR>

"" Supprime la subrillance des résultats de recherche
" Permet de faire disparaitre le surlignage des résultats de
" recherche via la commande <leader>/
nmap <silent> <leader>/ :nohlsearch<CR>

"" Déplacement lorsqu'un texte est wrappé
" Permet de se déplacer de ligne en ligne naturellement quand
" un texte est wrappé (trop long, donc passe à la ligne automatiquement).
nnoremap <down> gj
nnoremap <up> gk

"" Navigation rapide entre les splits (Ctrl+flèche)
map <C-left> <C-w>h
map <C-down> <C-w>j
map <C-up> <C-w>k
map <C-right> <C-w>l

"" Raccourcis pour la programmation
noremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

"" Change le format de fichier à unix et l'encodage à utf-8
nmap <F12> :set ff=unix fenc=utf-8<CR>:w<CR>


"""""""""""
" NERDTree
"""""""""""

"" Ouvre/ferme NERDTree via F3
nmap <silent> <F3> :NERDTreeToggle<CR>

"" Voir les fichiers cachés par défaut
let NERDTreeShowHidden=1

"" Changer l'appparence des flèches de l'arborescence
let NERDTreeDirArrows=0


"""""""""
" TagBar
"""""""""

" Ouvre/ferme TagBar via F4
nmap <silent> <F4> :TagbarToggle<CR>


""""""""
" Unite
""""""""

"" Enregistre l'historique du presse-papier
let g:unite_source_history_yank_enable = 1
nnoremap <leader>y :<C-u>Unite history/yank<CR>

""""""""""""""""""""
" Unite-colorscheme
""""""""""""""""""""

nnoremap <leader>c :<C-u>Unite colorscheme -auto-preview<CR>

""""""""""""""
" Neocomplete
""""""""""""""
if has('lua')

    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1

    "" Ferme la popup en appuyant sur entrée quand aucun choix n'est sélectionné
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        "return neocomplete#close_popup() . "\<CR>"
        " For no inserting <CR> key.
        return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction

    "" Tabulation pour sélectionner
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

    "" Langages
    set omnifunc=syntaxcomplete#Complete

    "autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    "autocmd FileType html,twig,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    "autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    "autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    "autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    "" Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif

    let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

endif

""""""""""""""""
" Neocomplcache
""""""""""""""""
if !has('lua')

    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_underbar_completion = 1

    " Ferme la popup en appuyant sur entrée quand aucun choix n'est sélectionné
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
    "return neocomplcache#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    endfunction

    " Tabulation pour sélectionner
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

    " Langages
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
