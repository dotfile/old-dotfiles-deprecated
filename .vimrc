" http://github.com/echelon/dotfiles/blob/master/.vimrc

set nocompatible		" no vi bug compatibility
set modelines=0			" no modelines (for security)
"set encoding=utf-8		" encoding should be utf-8

set backup				" keep backup (~) files
"set nobackup 			" backup files removed when vim closes cleanly

set backupdir=.,$HOME/.vim/backup	" backup file dir
set directory=$HOME/.vim/swap 		" swapfile dir

filetype plugin indent on " filetype dependent indenting and plugins
set autoindent			" auto indents line relative to line above
set smartindent

set tabstop=4			" tab width preference
set shiftwidth=4		" tab width preference
"set expandtab			" uses spaces rather than tabs
set backspace=eol,start,indent " backspace over everything in insert mode
set smarttab 			" smarter tab and backspace

"set showmatch

syntax on				" highlighting
set background=dark		" dark background

set ttyfast				" smoother changes

set ruler				" show line stats at bottom
set number				" show line numbering

set columns=85			" vim is only 85 columns wide 
"set tw=79				" *force* margin at 79 characters

set mouse=a				" mouse support in all modes
set mousehide			" hide mouse when typing text

set wildmode=longest:full	" bash-like autocomplete
set wildmenu				" bash-like autocomplete

set hidden				" allow editing multiple unsaved buffers

set browsedir=current	" use pwd

set shm=atAI			" shortmsg, ignore swapfiles, no intro


if has("gui_running")
	" .gvimrc
	set guioptions-=T			" remove toolbar
	set guioptions-=m			" remove menu bar
	colorscheme darkspectrum	" gui colors (doesn't seem to work in vim)
else
	colorscheme darkspectrum	" console colors	
	"colorscheme desert			" console colors
endif


" Python syntax highlighting
let python_highlight_all = 1
let python_slow_sync = 1


" Highlight text going beyond column 79
highlight LenErr ctermbg=darkred ctermfg=white guibg=#592929
match LenErr /\%>80v.*/ " Matches any over 80.


"set vb t_vb=
"set virtualedit=all


" No arrow keys in command mode! (BAD HABBIT!)
map <Up> :<CR>
map <Down> :<CR>
map <Left> :<CR>
map <Right> :<CR>

" Keyboard Mappings
"map <F1> :previous<CR>	" open previous buffer
"map <F2> :next<CR>		" open next buffer

" Saving
map <C-s> :w<CR>				" save file

" Copy/paste from system clipboard
vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>

:nmap <Leader>s :source $MYVIMRC<CR>	" resource vimrc
:nmap <Leader>v :e $MYVIMRC<CR>			" edit vimrc

" Tab navigation
map <C-t> :tabnew<CR>			" new tab 
"map <C-tab> :tabnext<CR>		" next tab
"map <C-S-tab> :tabprevious<CR>	" prev tab

" NERDtree plugin
map <C-f> :NERDTree<CR>			" open


" Movement between tabs OR buffers
nnoremap <C-l> :call MyNext()<CR>
nnoremap <C-h> :call MyPrev()<CR>
map <C-tab> :call MyNext()<CR>
map <C-S-tab> :call MyPrev()<CR>


" MyNext() and MyPrev(): Movement between tabs OR buffers
" Taken from: http://stackoverflow.com/questions/53664/
" how-to-effectively-work-with-multiple-files-in-vim 
function! MyNext()
	if exists( '*tabpagenr' ) && tabpagenr('$') != 1
		" Tab support && tabs open
		normal gt
	else
		" No tab support, or no tabs open
		execute ":bnext"
	endif
endfunction

function! MyPrev()
	if exists( '*tabpagenr' ) && tabpagenr('$') != '1'
		" Tab support && tabs open
		normal gT
	else
		" No tab support, or no tabs open
		execute ":bprev"
	endif
endfunction


