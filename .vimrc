" http://github.com/echelon/dotfiles/blob/master/.vimrc

set nocompatible		" no vi bug compatibility
set modelines=0			" no modelines (for security)

set autoindent			" auto indenting
set smartindent

set tabstop=4			" tab width preference
set shiftwidth=4		" tab width preference
"set expandtab			" uses spaces rather than tabs
set backspace=eol,start,indent " allows backspacing over
set smarttab 			" smarter tab and backspace

"set showmatch

syntax on				" highlighting
set background=dark		" dark background

set ttyfast				" smoother changes

set ruler				" show line stats at bottom
set number				" show line numbering

set mouse=a				" mouse support in all modes
set mousehide			" hide mouse when typing text

set wildmode=longest:full	" bash-like autocomplete
set wildmenu				" bash-like autocomplete

set hidden				" allow editing multiple unsaved buffers

if has("gui_running")
	" .gvimrc
	set guioptions-=T			" remove toolbar
	"set guioptions-=m			" remove menu bar
	colorscheme darkspectrum	" gui colors (doesn't seem to work in vim)
else
	colorscheme ir_black		" console colors	
endif

set browsedir=buffer

" Python syntax highlighting
let python_highlight_all = 1
let python_slow_sync = 1

" Set columns to 79
set columns=79					" word wraps after 79
"set tw=79						" force margin at 79 characters

" Highlight text going beyond column 79
highlight LenErr ctermbg=darkred ctermfg=white guibg=#592929
"match LenErr /\%80v.\+/	" Matches any over 79.
match LenErr /\%>80v.*/ " Matches any over 80.

" Markdown files


"set vb t_vb=

"set virtualedit=all

" Keyboard Mappings
"map <F1> :previous<CR>	" open previous buffer
"map <F2> :next<CR>		" open next buffer

" Saving
map <C-s> :w<CR>				" save file

" Copy/paste from system clipboard
vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>

" Tab navigation
map <C-t> :tabnew<CR>			" new tab 
map <C-tab> :tabnext<CR>		" next tab
map <C-S-tab> :tabprevious<CR>	" prev tab

" NERDtree plugin
map <C-f> :NERDTree<CR>			" open 
