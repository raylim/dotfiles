call plug#begin('~/.local/share/nvim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree'

Plug 'tpope/vim-surround'
 
Plug 'altercation/vim-colors-solarized'

Plug 'bling/vim-airline'

Plug 'majutsushi/tagbar'

Plug 'scrooloose/nerdcommenter'

Plug 'airblade/vim-gitgutter'

" Plug 'valloric/youcompleteme'

Plug 'easymotion/vim-easymotion'

Plug 'godlygeek/tabular'

Plug 'ervandew/supertab'

Plug 'roxma/nvim-completion-manager'
Plug 'othree/csscomplete.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
"Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install' }
"Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}
Plug 'phpactor/phpactor' ,  {'do': 'composer install'}
Plug 'roxma/ncm-phpactor'
Plug 'roxma/ncm-rct-complete'
Plug 'SirVer/ultisnips'
Plug 'adoy/vim-php-refactoring-toolbox'
"Plug 'vim-php/tagbar-phpctags.vim'
"Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }

"Plug 'dkprice/vim-easygrep"'

Plug 'ctrlpvim/ctrlp.vim'

" php lint
Plug 'nrocco/vim-phplint'

" test suite
Plug 'janko-m/vim-test'

" debugging
Plug 'joonty/vdebug'

" json
Plug 'elzr/vim-json'

Plug 'shougo/vimshell.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

call plug#end()

let mapleader = ","

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

filetype plugin on

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

syntax enable
set background=dark
colorscheme solarized

nnoremap ; :

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
set foldmethod=indent
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

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" completion stuff
set shortmess+=c
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci
let g:deoplete#enable_at_startup = 1
"let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
"let g:deoplete#ignore_sources.php = ['omni']
set mouse=a

nmap <leader>gb :Gblame<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gl :Glog<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gp :Git push<CR>
nmap <leader>gw :Gw<CR>
nmap <leader>gg :Ggrep <cword><CR>

nmap <leader>tt :TagbarToggle<CR>

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" json tool
nmap <silent> <leader>j :%!python -m json.tool<CR>

" ctrl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

let g:vdebug_keymap = {
\    "run" : "<Leader>v",
\    "run_to_cursor" : "<Down>",
\    "step_over" : "<Up>",
\    "step_into" : "<Left>",
\    "step_out" : "<Right>",
\    "close" : "q",
\    "detach" : "<F7>",
\    "set_breakpoint" : "<Leader>s",
\    "eval_visual" : "<Leader>e"
\}

if !exists('g:vdebug_options')
    let g:vdebug_options = {}
endif
let g:vdebug_options['path_maps'] = {
\    '/var/www/dashboard' : '/Users/raymondlim/mgtl/dashboard/git/mssmdashboard'
\}

noremap <leader>p :Phplint<CR>

" vimshell
map <leader>sS <Plug>(vimshell_split_switch)
map <leader>sC <Plug>(vimshell_split_create)
map <leader>ss <Plug>(vimshell_switch)
map <leader>sc <Plug>(vimshell_create)
map <leader>se <Plug>(vimshell_enter)
map <leader>sp <Plug>(vimshell_paste_prompt)



"command -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | cw | redraw!
