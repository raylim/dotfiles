
" Modeline and Notes {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker :
"
"	This is the personal .vimrc file of Steve Francia.
"	While much of it is beneficial for general use, I would
"	recommend picking out the parts you want and understand.
"
"	You can find me at http://spf13.com
" }


set encoding=utf-8
set t_Co=256

function MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

nnoremap <C-W>. :call MoveToNextTab()<CR>
nnoremap <C-W>, :call MoveToPrevTab()<CR>


set nocompatible 		" must be first line
set background=light     " Assume a dark background

set noea

"if has("terminfo")
"    set t_Co=16
"    set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
"    set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
"else
"    set t_Co=16
"    set t_Sf=[3%dm
"    set t_Sb=[4%dm
"endif
"set t_AB=[48;5;%dm
"set t_AF=[38;5;%dm

set mouse=nvc
if &term == "xterm"
    set t_kb=
    fixdel
endif

"map ,# :s/^/#/<CR>
"map ,/ :s/^/\/\//<CR>
"map ,> :s/^/> /<CR>
"map ," :s/^/\"/<CR>
"map ,% :s/^/%/<CR>
"map ,! :s/^/!/<CR>
"map ,; :s/^/;/<CR>
"map ,- :s/^/--/<CR>
"map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>

" wrapping comments
" map ,* :s/^\(.*\)$/\/\* \1 \*\//<CR>
" map ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>
" map ,< :s/^\(.*\)$/<!-- \1 -->/<CR>
" map ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR> 

"if v:version >= 700
"    set completeopt=longest,menuone
"    inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>" 
"    inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
"    inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>" 
"endif
"
nmap    _Y      :!echo ""> ~/.vi_tmp<CR><CR>:w! ~/.vi_tmp<CR>
vmap    _Y      :w! ~/.vi_tmp<CR>  
nmap    _P      :r ~/.vi_tmp<CR> 

set virtualedit=block



" Environment {
" Basics {
" }

" Windows Compatible {
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier. 
"		if has('win32') || has('win64')
"		  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
"		endif
"	" }
"    " 
"	" Setup Bundle Support {
"	" The next two lines ensure that the ~/.vim/bundle/ system works
"		runtime! autoload/pathogen.vim
"		silent! call pathogen#helptags()
"		silent! call pathogen#runtime_append_all_bundles()
" }

" }

" General {
set background=light         " Assume a dark background
"    if !has('win32') && !has('win64')
"        set term=$TERM       " Make arrow and other keys work
"    endif
filetype plugin indent on  	" Automatically detect file types.
syntax enable 					" syntax highlighting
"	set mouse=a					" automatically enable mouse usage
set autochdir 				" always switch to the current file directory.. Messes with some plugins, best left commented out
" not every vim is compiled with this, use the following line instead
" If you use command-t plugin, it conflicts with this, comment it out.
"autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
"	scriptencoding utf-8

" set autowrite                  " automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT     	" abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore 	   	" allow for cursor beyond last character
set history=1000  				" Store a ton of history (default is 20)

" Setting up the directories {
set backup 						" backups are nice ...
set undofile					" so is persistent undo ...
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
" Moved to function at bottom of the file
"set backupdir=$HOME/.vimbackup//  " but not when they clog .
"set directory=$HOME/.vimswap// 	" Same for swap files
"set viewdir=$HOME/.vimviews// 	" same for view files

"" Creating directories if they don't exist
"silent execute '!mkdir -p $HVOME/.vimbackup'
"silent execute '!mkdir -p $HOME/.vimswap'
"silent execute '!mkdir -p $HOME/.vimviews'
au BufWinLeave * silent! mkview  "make vim save view (state) (folds, cursor, etc)
au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)
" }
" }

" Vim UI {
"	color solarized   	       		" load a colorscheme
set tabpagemax=15 				" only show 15 tabs
set showmode                   	" display the current mode

set cursorline  				" highlight current line
hi cursorline guibg=#333333 	" highlight bg color of current line
hi CursorColumn guibg=#333333   " highlight cursor

if has('cmdline_info')
    set ruler                  	" show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
    set showcmd                	" show partial commands in status line and
    " selected characters/lines in visual mode
endif

if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\    " Filename
    set statusline+=%w%h%m%r " Options
    "		set statusline+=%{fugitive#statusline()} "  Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " filetype
    set statusline+=\ [%{getcwd()}]          " current dir
    "set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set backspace=indent,eol,start	" backspace for dummys
set linespace=0					" No extra spaces between rows
set nonu							" Line numbers on
set showmatch					" show matching brackets/parenthesis
set incsearch					" find as you type search
set hlsearch					" highlight search terms
set winminheight=0				" windows can be 0 line high 
set ignorecase					" case insensitive search
set smartcase					" case sensitive when uc present
set wildmenu					" show list instead of just completing
set wildmode=list:longest,full	" command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]	" backspace and cursor keys wrap to
set scrolljump=5 				" lines to scroll when cursor leaves screen
set scrolloff=3 				" minimum lines to keep above and below cursor
set foldenable  				" auto fold code
set gdefault					" the /g flag on :s substitutions by default
set nolist
"set listchars=tab:>.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace


" }

" Formatting {
set wrap                     	" wrap long lines
"set linebreak
set autoindent                 	" indent at the same level of the previous line
set shiftwidth=4               	" use indents of 4 spaces
set expandtab 	  	     		" tabs are spaces, not tabs
set tabstop=4 					" an indentation every four columns
set softtabstop=4 				" let backspace delete indent
"set matchpairs+=<:>            	" match, to be used with % 
set pastetoggle=<F12>          	" pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" }


" Key (re)Mappings {

"The default leader is '\', but many people prefer ',' as it's in a standard
"location
let mapleader = ','

" Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
nnoremap ; :


" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" The following two lines conflict with moving to top and bottom of the
" screen
" If you prefer that functionality, comment them out.
"	map <S-H> gT          
"	map <S-L> gt

" Stupid shift key fixes
"cmap W w 						
"cmap WQ wq
"cmap wQ wq
"cmap Q q
"cmap Tabe tabe

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
map [F $
imap [F $
map [H g0
imap [H g0

cmap w!! w !sudo tee % >/dev/null
" }

" Plugins {

" VCSCommand {
"		let b:VCSCommandMapPrefix=',v'
"		let b:VCSCommandVCSType='git'
" } 

" PIV {
"		let g:DisableAutoPHPFolding = 0
"let cfu=phpcomplete#CompletePHP
" }

" Supertab {
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
" }

" Misc { 
"		:map <C-F10> <Esc>:vsp<CR>:VTree<CR>
" map Control + F10 to Vtree

noremap <leader><F5> :CheckSyntax<cr>
let g:checksyntax_auto = 1

"comment out line(s) in visual mode -RB: If you do this, you can't
"switch sides of the comment block in visual mode.
"vmap  o  :call NERDComment(1, 'toggle')<CR>
let g:NERDShutUp=1

let b:match_ignorecase = 1
" }
"	
"	" ShowMarks {
"		let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
"		" Don't leave on by default, use :ShowMarksOn to enable
"		let g:showmarks_enable = 0
"		" For marks a-z
"		highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Blue
"		" For marks A-Z
"		highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
"		" For all other marks
"		highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
"		" For multiple marks on the same line.
"		highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen
"	" }
"	
"	" Command-t {
""        let g:CommandTSearchPath = $HOME . '/Code'
"	" }
"
" OmniComplete {
"if has("autocmd") && exists("+omnifunc")
"autocmd Filetype *
"\if &omnifunc == "" |
"\setlocal omnifunc=syntaxcomplete#Complete |
"\endif
"endif

" Popup menu hightLight Group
"highlight Pmenu	ctermbg=13	guibg=DarkBlue
"highlight PmenuSel	ctermbg=7	guibg=DarkBlue		guifg=LightBlue
"highlight PmenuSbar ctermbg=7	guibg=DarkGray
"highlight PmenuThumb			guibg=Black

hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

" some convenient mappings 
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d>	   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" and make sure that it doesn't break supertab
let g:SuperTabCrMapping = 0

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview,longest
" }

" Ctags {
" This will look in the current directory for 'tags', and work up the tree towards root until one is found. 
set tags=./tags;/,$HOME/vimtags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR> " C-\ - Open the definition in a new tab
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>      " A-] - Open the definition in a vertical split
" }

" EasyTags {
" Disabling for now. It doesn't work well on large tag files 
let g:loaded_easytags = 1  " Disable until it's working better
let g:easytags_cmd = 'ctags'
let g:easytags_dynamic_files = 1
if !has('win32') && !has('win64')
    let g:easytags_resolve_links = 1
endif
" }

" Delimitmate {
au FileType * let b:delimitMate_autoclose = 1

" If using html auto complete (complete closing tag)
au FileType xml,html,xhtml let b:delimitMate_matchpairs = "(:),[:],{:}"
" }

" AutoCloseTag {
" Make it so AutoCloseTag works for xml and xhtml files as well
au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
" }

" SnipMate {
" Setting the author var
" If forking, please overwrite in your .vimrc.local file
let g:snips_author = 'Raymond Lim <raylim@mm.st>'
" Shortcut for reloading snippets, useful when developing
nnoremap ,smr <esc>:exec ReloadAllSnippets()<cr>
" }

" NerdTree {
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
" }

" Tabularize {
if exists(":Tabularize")
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
endif
" }


" Richard's plugins {
" Fuzzy Finder {
""" Fuzzy Find file, tree, buffer, line
nmap <leader>ff :FufFile **/<CR>
nmap <leader>ft :FufFile<CR>
nmap <leader>fb :FufBuffer<CR>
nmap <leader>fl :FufLine<CR>
nmap <leader>fr :FufRenewCache<CR>
" }

" Session List {
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
nmap <leader>sl :SessionList<CR>
nmap <leader>ss :SessionSave<CR>
" }

" Buffer explorer {
nmap <leader>b :BufExplorer<CR>
" }

" VCS commands {
"nmap <leader>vs :VCSStatus<CR>
"nmap <leader>vc :VCSCommit<CR>
"nmap <leader>vb :VCSBlame<CR>
"nmap <leader>va :VCSAdd<CR>
"nmap <leader>vd :VCSVimDiff<CR>
"nmap <leader>vl :VCSLog<CR>
"nmap <leader>vu :VCSUpdate<CR>
" }
" php-doc commands {
nmap <leader>pd :call PhpDocSingle()<CR>
vmap <leader>pd :call PhpDocRange()<CR>
" }

" Debugging with VimDebugger {
map <F11> :DbgStepInto<CR>
map <F10> :DbgStepOver<CR>
map <S-F11> :DbgStepOut<CR>
map <F5> :DbgRun<CR>
map <F6> :DbgDetach<CR>
map <F8> :DbgToggleBreakpoint<CR>
map <S-F8> :DbgFlushBreakpoints<CR>
map <F9> :DbgRefreshWatch<CR>
map <S-F9> :DbgAddWatch<CR>
" }

" Taglist Variables {
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Update = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Highlight_Tag_On_BufEnter = 1
let Tlist_Use_Right_Window = 1
let Tlist_Use_SingleClick = 1

let g:ctags_statusline=1
" Override how taglist does javascript
let g:tlist_javascript_settings = 'javascript;f:function;c:class;m:method;p:property;v:global'
" }

" JSON {
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
" }
" }
" }

" GUI Settings {
" GVIM- (here instead of .gvimrc)
if has('gui_running')
    set guioptions-=T          	" remove the toolbar
    set lines=40               	" 40 lines of text instead of 24,
    colorscheme desert
"else
    "set term=builtin_ansi       " Make arrow and other keys work
endif
" }

function! InitializeDirectories()
    let separator = "."
    let parent = $HOME 
    let prefix = '.vim'
    let dir_list = { 
                \ 'backup': 'backupdir', 
                \ 'views': 'viewdir', 
                \ 'swap': 'directory', 
                \ 'undo': 'undodir' }

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
            let directory = substitute(directory, " ", "\\\\ ", "")
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

" Use local vimrc if available {
"    if filereadable(expand("~/.vimrc.local"))
"        source ~/.vimrc.local
"    endif
" }$(call $(eval variant-recal))
"
set nospell  " spell checking off
set nolist
"set title
set t_ts=]1;
set t_fs=

"let g:vimrplugin_term = "xterm"
"let g:vimrplugin_tmux = 0
let g:vimrplugin_screenplugin = 0
"let &titlestring = expand("%:p") . " @ " . hostname()


"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'jcfaria/Vim-R-plugin'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'bling/vim-airline' " status bar
NeoBundle 'edkolev/tmuxline.vim' "tmux status bar
NeoBundle 'scrooloose/syntastic' " syntax check
NeoBundle 'kshenoy/vim-signature' " place toggle and display marks
NeoBundle 'tpope/vim-surround' " quoting
NeoBundle 'tpope/vim-repeat'
NeoBundle 'klen/python-mode'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'ivanov/vim-ipython'

"NeoBundle 'vim-pandoc/vim-pandoc'
"NeoBundle 'vim-pandoc/vim-pandoc-syntax'
"NeoBundle 'vim-pandoc/vim-rmarkdown'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell' ", { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------


nmap <leader>gb :Gblame<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gw :Gw<CR>

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
colorscheme chela_light

" Gif config
"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
"
" " These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)

"map <Leader>l <Plug>(easymotion-lineforward)
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)
"map <Leader>h <Plug>(easymotion-linebackward)

"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
"let g:EasyMotion_smartcase = 1
" Require tpope/vim-repeat to enable dot repeat support
" Jump to anywhere with only `s{char}{target}`
" `s<CR>` repeat last find motion.
"nmap <Leader>s <Plug>(easymotion-s)
"nmap <Leader>t <Plug>(easymotion-t)
" Bidirectional & within line 't' motion
"omap t <Plug>(easymotion-bd-tl)
" Use uppercase target labels and type as a lower case
"let g:EasyMotion_use_upper = 1
" type `l` and match `l`&`L`
"let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
"let g:EasyMotion_use_smartsign_us = 1
 

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
    autocmd FileType python set colorcolumn=120
    augroup END

let g:syntastic_python_pylint_post_args="--max-line-length=120"
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_checker_args='--ignore=E501,E225'
let g:pymode_options_max_line_length=120

let vimrplugin_tmux_title = "automatic"

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_r_lintr_checker = 0
let g:syntastic_r_checkers = 0

let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0
