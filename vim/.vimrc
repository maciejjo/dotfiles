" Vim configuration
"
" =============================================================================
" Vim-plug setup
" =============================================================================
call plug#begin()
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/cscope.vim'
Plug 'bling/vim-airline'
Plug 'chriskempson/base16-vim'
Plug 'nanotech/jellybeans.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'rking/ag.vim'
Plug 'tpope/vim-fugitive'
Plug 'rust-lang/rust.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ciaranm/detectindent'
Plug 'kergoth/vim-bitbake'
call plug#end()

runtime ftplugin/man.vim

set nocompatible
set ttyfast

" =============================================================================
" External configuration
" =============================================================================

" enable modeline in files
set modeline
" allow local .vimrc files but use only safe options
set exrc
set secure

" =============================================================================
" Colorscheme
" =============================================================================
set background=dark
colorscheme jellybeans

syntax on
" highlight matching brackets
set showmatch

" =============================================================================
" Interface
" =============================================================================

set cursorline
set number
set wildmenu
set relativenumber
set shortmess=atI
set laststatus=2

" leader r to toggle relative line numbers
nmap <leader>r :set rnu!<CR>

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" =============================================================================
" Indentation
" =============================================================================

set tabstop=8
set softtabstop=8
set shiftwidth=8
set noexpandtab

filetype plugin indent on

" =============================================================================
" Invisible characters
" =============================================================================

nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬

function! Preserve(command)

	" Save last search and cursor position
	let _s=@/
	let l = line(".")
	let c = col(".")

	execute a:command

	" Restore search history and cursor position
	let @/=_s
	call cursor(l, c)

endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" =============================================================================
" Buffers
" =============================================================================

" Auto hide buffers without raising error
set hidden

" =============================================================================
" Navigation mappings
" =============================================================================

" better window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" better scrolling within wrapped lines
nnoremap j gj
nnoremap k gk

" leader r to toggle relative line numbers
nmap <leader>r ;set rnu!<CR>

set pastetoggle=<F11>

" =============================================================================
" Search
" =============================================================================

set hlsearch
nnoremap <leader><space> :noh<cr>

set incsearch
set smartcase

" use g flag by default
set gdefault
" very magic regular expressions
nnoremap / /\v
vnoremap / /\v

" =============================================================================
" Temporary/backup/undo files
" =============================================================================

" save backups to .vim-backup directory in pwd (if exists), if not, then at
" ~/.vim/backup
if isdirectory($HOME . '/.vim/backup') == 0
	:silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup
set backupdir^=./.vim-backup
set backup

" do simmilar thing for swap files
if isdirectory($HOME . '/.vim/swap') == 0
	:silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//

" and for undo files
if exists("+undofile")
	if isdirectory($HOME . '/vim/undo') == 0
		:silent !mkdir -p ~/.vim/undo >/dev/null 2>&1
	endif
	set undodir=./.vim-undo//
	set undodir+=~/.vim/undo//
	set undofile
endif

set viminfo+=n~/.vim/viminfo

" =============================================================================
" Scrolling
" =============================================================================

set scrolloff=10


" =============================================================================
" Cscope
" =============================================================================

nnoremap <leader>fa :call cscope#findInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call cscope#find('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call cscope#find('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call cscope#find('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call cscope#find('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call cscope#find('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call cscope#find('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call cscope#find('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call cscope#find('i', expand('<cword>'))<CR>


" =============================================================================
" Plugins configuration
" =============================================================================

" Airline - use powerline fonts
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 2

"" YouCompleteMe
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_always_populate_location_list = 1

" YCM - don't ask to load config
let g:ycm_confirm_extra_conf = 0

" YCM - autoclouse scratch window
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1


"" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<c-h>"

