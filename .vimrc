" Vundle===============================================================
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
" Initialize Vundle.

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

if has('nvim')
  Plugin 'Shougo/deoplete.nvim'
else
  Plugin 'Shougo/deoplete.nvim'
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif

Plugin 'xolox/vim-misc'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" install rvm https://usabilityetc.com/articles/ruby-on-mac-os-x-with-rvm/
"   cd ~/.vim/bundle/command-t/ruby/command-t/ext/command-t
" choose correct version
" rvm use 2.3.7
" ruby extconf.rb
" make clean
" make

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" syntastic
Plugin 'https://github.com/scrooloose/syntastic.git'

Plugin 'pangloss/vim-javascript'

Plugin 'scrooloose/nerdtree'

Plugin 'MultipleSearch'

Plugin 'scrooloose/nerdcommenter'

Plugin 'tpope/vim-surround'

Plugin 'godlygeek/tabular'

Plugin 'majutsushi/tagbar'

Plugin 'honza/vim-snippets'

" Default mappings are: <Leader>ds, <Leader>dS respectively.
Plugin 'bergercookie/vim-debugstring'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"======================================================

" General {
    set background=dark         " Assume a dark background
    if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " syntax highlighting
    set mouse=a                 " automatically enable mouse usage
    scriptencoding utf-8

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add
    " let g:spf13_no_autochdir = 1 to your .vimrc.bundles.local file
    if !exists('g:spf13_no_autochdir')
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        " always switch to the current file directory.
    endif

    " set autowrite                  " automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
    set virtualedit=onemore         " allow for cursor beyond last character
    set history=1000                " Store a ton of history (default is 20)
    set nospell                       " spell checking on
    set hidden                      " allow buffer switching without saving

    " Setting up the directories {
        set backup                      " backups are nice ...
        if has('persistent_undo')
            set undofile                "so is persistent undo ...
            set undolevels=1000         "maximum number of changes that can be undone
            set undoreload=10000        "maximum number lines to save for undo on a buffer reload
        endif

    " To disable views set
    " g:spf13_no_views = 1
    " in your .vimrc.bundles.local file"
    if !exists('g:spf13_no_views')
        " Could use * rather than *.*, but I prefer to leave .files unsaved
        au BufWinLeave *.* silent! mkview  "make vim save view (state) (folds, cursor, etc)
        au BufWinEnter *.* silent! loadview "make vim load view (state) (folds, cursor, etc)
    endif
    " }
" }

" Vim UI {
    let g:solarized_termcolors=256
    colorscheme atom " load a colorscheme
    let g:solarized_termtrans=1
    let g:solarized_contrast="high"
    let g:solarized_visibility="high"
    set tabpagemax=15               " only show 15 tabs
    set showmode                    " display the current mode

    " NOTE lazy redraw to speed up
    set lazyredraw                  " speed up
    set cursorline!                  " disable highlight current line
    " Cursor color
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"

    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and
                                    " selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\    " Filename
        set statusline+=%w%h%m%r " Options
        " set statusline+=%{fugitive#statusline()} "  Git Hotness
        " set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " backspace for dummies
    set linespace=2                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " show matching brackets/parenthesis
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set winminheight=0              " windows can be 0 line high
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
    set scrolljump=5                " lines to scroll when cursor leaves screen
    set scrolloff=3                 " minimum lines to keep above and below cursor
    set foldenable                  " auto fold code
    set list
    set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace


" }

" Formatting {

    " Enable the specific ESLint checker for files in mozilla-central/ only.
    " Enable the HTML plugin, and enable JavaScript linting for HTML files.
    autocmd FileType javascript,html
        \ if stridx(expand("%:p"), "/debug/") != -1 |
        \    let b:syntastic_checkers = ['eslint'] |
        \    let b:syntastic_eslint_exec = '/Users/tnguyen/Projects/firefox/debug/node_modules/.bin/eslint' |
        \    let b:syntastic_html_eslint_args = ['--plugin', 'html'] |
        \ endif

    set nowrap                      " wrap long lines
    set autoindent                  " indent at the same level of the previous line
    "set matchpairs+=<:>                " match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    set cindent
    set smartindent
    set ts=2 sts=2 et sw=2 tw=80
    set expandtab                   " tabs are spaces, not tabs

    au BufNewFile *.py,*.pyw,*.c,*.h,*.js,*.jsm,*.cpp,*.hpp set fileformat=unix
    au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.js,*.jsm,*.cpp,*.hpp,*.idl,*.json set expandtab

    " Remove trailing whitespaces and ^M chars
    "autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
    "autocmd FileType c,cpp,java,phc,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :%s/\s\+$//e
    "autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
" }

" Key (re)Mappings {

    "The default leader is '\', but many people prefer ',' as it's in a standard
    "location. To override this behavior and set it back to '\' (or any other
    "character) add let g:spf13_leader='\' in your .vimrc.bundles.local file
    "if !exists('g:spf13_leader')
    "    let mapleader = ','
    "else
    "    let mapleader=g:spf13_leader
    "endif

    " remap moving around key
    noremap <Up> <Nop>
    noremap <Down> <Nop>
    noremap <Left> <Nop>
    noremap <Right> <Nop>
    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap q i
    noremap o <Nop>
    noremap - <Nop>
    " noremap 8 <Nop>
    noremap i gk
    noremap j h
    noremap k gj
    "copy paste
    noremap yow yiw
    noremap vow viw
    " Paste the second time
    xnoremap p "_dP
    "vnoremap p "0p
    " yank to clipboard
    if has("clipboard")
      set clipboard=unnamed " copy to the system clipboard

      if has("unnamedplus") " X11 support
        set clipboard+=unnamedplus
      endif
    endif
    noremap 8 0
    noremap 0 $
    noremap . <Nop>
    noremap <S-L> w
    noremap <S-J> b
    noremap <S-I> <C-B>zz
    noremap <S-K> <C-F>zz
    " Tabs
    noremap <C-S-I> gT
    noremap <C-S-K> gt
    noremap <C-PageUp> gT
    noremap <C-PageDown> gt
    " The following two lines conflict with moving to top and bottom of the
    " screen
    " If you prefer that functionality, add let g:spf13_no_fastTabs = 1 in
    " your .vimrc.bundles.local file

    if !exists('g:spf13_no_fastTabs')
        map <S-H> gT
        "map <S-L> gt
    endif

    " Stupid shift key fixes
    if !exists('g:spf13_no_keyfixes')
        if has("user_commands")
            command! -bang -nargs=* -complete=file E e<bang> <args>
            command! -bang -nargs=* -complete=file W w<bang> <args>
            command! -bang -nargs=* -complete=file Wq wq<bang> <args>
            command! -bang -nargs=* -complete=file WQ wq<bang> <args>
            command! -bang Wa wa<bang>
            command! -bang WA wa<bang>
            command! -bang Q q<bang>
            command! -bang QA qa<bang>
            command! -bang Qa qa<bang>
        endif

        cmap Tabe tabe
    endif

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    """ Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    "clearing highlighted search
    nmap <silent> <leader>/ :nohlsearch<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Fix home and end keybindings for screen, particularly on mac
    " - for some reason this fixes the arrow keys too. huh.
    map [F $
    imap [F $
    map [H g0
    imap [H g0

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=expand('%:h').'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
    map <space> /
    map <c-space> ?
" }

" Plugins {
    " deoplete {
    set pyxversion=3
    set encoding=utf-8
    let g:deoplete#enable_at_startup = 1
    inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    " }
    " Misc {
        let g:NERDShutUp=1
        let b:match_ignorecase = 1
    " }

    " NerdTree {
        map <C-e> :NERDTreeToggle<CR>
        map <C-a> :NERDTreeFind<CR>
        "map <leader>e :NERDTreeFind<CR>
        "nmap <leader>nt :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeMouseMode=2
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
        let g:NERDTreeWinSize=60
        let g:NERDTreeMapOpenSplit = '9'
    " }

    " Tabularize {
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
     " }

     " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
     "}

     " UndoTree {
        nnoremap <Leader>u :UndotreeToggle<CR>
     " }

     " indent_guides {
        if !exists('g:spf13_no_indent_guides_autocolor')
            let g:indent_guides_auto_colors = 1
        else
            " for some colorscheme ,autocolor will not work,like 'desert','ir_black'.
            autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121   ctermbg=3
            autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4
        endif
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
     " }

     " Move Tab
        inoremap <silent> <C-S-Left>  <C-r>=ShiftTab(0)<CR>
        inoremap <silent> <C-S-Right>  <C-r>=ShiftTab(1)<CR>

        noremap <silent> <C-S-Left>  :call ShiftTab(0)<CR>
        noremap <silent> <C-S-Right> :call ShiftTab(1)<CR>

        " Add dictionary for Mac
        if has('gui_macvim')
          " Use ctr d on top of a word to look it up in Dictionary.app
          nmap <silent> <C-t> :!open dict://<cword><CR><CR>
        endif

      " tagbar {
        let g:tagbar_type_objc = {
          \ 'ctagstype': 'objc',
          \ 'ctagsargs': [
            \ '-f',
            \ '-',
            \ '--excmd=pattern',
            \ '--extra=',
            \ '--format=2',
            \ '--fields=nksaSmt',
            \ '--options=' . expand('~/.vim/objctags'),
            \ '--objc-kinds=-N',
          \ ],
          \ 'sro': ' ',
          \ 'kinds': [
            \ 'c:constant',
            \ 'e:enum',
            \ 't:typedef',
            \ 'i:interface',
            \ 'P:protocol',
            \ 'p:property',
            \ 'I:implementation',
            \ 'M:method',
            \ 'g:pragma',
          \ ],
        \ }
        nmap <c-G> :TagbarToggle<CR>
     " }

     " Command-t {
        let g:CommandTMaxFiles=1000000
        let g:CommandTMaxDepth=30
        let g:CommandTFileScanner='find'
     " }

" }

" GUI Settings {
    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " remove the toolbar
        set lines=40                " 40 lines of text instead of 24,
        if has("gui_gtk2")
            set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
        else
            set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
        endif
        if has('gui_macvim')
            set transparency=5          " Make the window slightly transparent
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256                 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

" }

" Use fork vimrc if available {
    if filereadable(expand("~/.vimrc.fork"))
        source ~/.vimrc.fork
    endif
" }
" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
" }

"" END copied from http://www.daskrachen.com/2011/12/how-to-make-tagbar-work-with-objective.html

""************************************ HELPER ****************************************

 " Functions {
function! ShiftTab(direction)
     let tab_number = tabpagenr() 
     if a:direction == 0
         if tab_number == 1
             exe 'tabm' . tabpagenr('$')
         else
             exe 'tabm' . (tab_number - 2)
         endif
     else
         if tab_number == tabpagenr('$')
             exe 'tabm ' . 0
         else
             exe 'tabm ' . tab_number
         endif
     endif
     return ''
endfunction

function! InitializeDirectories()
    let separator = "."
    let parent = $HOME
    let prefix = '.vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = parent . '/' . prefix . dirname . "/"
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()

function! NERDTreeInitAsNeeded()
    redir => bufoutput
    buffers!
    redir END
    let idx = stridx(bufoutput, "NERD_tree")
    if idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
    endif
endfunction

""************************************************************************************
