" vim: nowrap fdm=marker
"  ---------------------------------------------------------------------------
"  Plugins
"  ---------------------------------------------------------------------------

silent! runtime bundles.vim
runtime plugins/bclose.vim
runtime plugins/mru.vim

"  ---------------------------------------------------------------------------
"  General
"  ---------------------------------------------------------------------------

filetype plugin indent on
let mapleader = ","
let g:mapleader = ","
set modelines=0
set history=10000
set nobackup
set nowritebackup
set noswapfile
syntax enable
set autoread
set showtabline=2

"  ---------------------------------------------------------------------------
"  UI
"  ---------------------------------------------------------------------------

set title
set encoding=utf-8
set scrolloff=3
set autoindent
set smartindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
set relativenumber
set undofile

" Auto adjust window sizes when they become current
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

set splitbelow splitright

if has('mouse')
  set mouse=a
endif

"  ---------------------------------------------------------------------------
"  Text Formatting
"  ---------------------------------------------------------------------------

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set nowrap
set textwidth=100
set formatoptions=n

" check to make sure vim has been compiled with colorcolumn support
" before enabling it
if exists("+colorcolumn")
  set colorcolumn=100
endif

"  ---------------------------------------------------------------------------
"  Mappings
"  ---------------------------------------------------------------------------

" Turn off arrow keys (this might not be a good idea for beginners, but it is
" the best way to ween yourself of arrow keys on to hjkl)
" http://yehudakatz.com/2010/07/29/everyone-who-tried-to-convince-me-to-use-vim-was-wrong/

" nnoremap <Left> :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up> :echoe "Use k"<CR>
" nnoremap <Down> :echoe "Use j"<CR>"
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>

" Searching / moving
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" Center screen when scrolling search results
nmap n nzz
nmap N Nzz

" ACK
" set grepprg=ack
" nnoremap <leader>a :Ack

" AG
nnoremap <leader>a :Ag
"
" Easy commenting
" nnoremap // :TComment<CR>
" vnoremap // :TComment<CR>

" Switch between buffers
noremap <tab> :bn<CR>
noremap <S-tab> :bp<CR>
" close buffer
nmap <leader>d :Bclose<CR>
" close all buffers
nmap <leader>D :bufdo bd<CR>

" Ignore some binary, versioning and backup files when auto-completing
set wildignore=.svn,CVS,.git,*.swp,*.jpg,*.png,*.gif,*.pdf,*.bak
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"
" Set a lower priority for .old files
set suffixes+=.old

" rvm-vim automatically as you switch from buffer to buffer
:autocmd BufEnter * Rvm

"  ---------------------------------------------------------------------------
"  Function Keys
"  ---------------------------------------------------------------------------

" Press F5 to toggle GUndo tree
nnoremap <F5> :GundoToggle<CR>

" indent file and return cursor and center cursor
map   <silent> <F6> mmgg=G`m^zz
imap  <silent> <F6> <Esc> mmgg=G`m^zz

"  ---------------------------------------------------------------------------
"  Plugins
"  ---------------------------------------------------------------------------

" eradicate all trailing whitespace all the time
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'

" AutoClose
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}'}
let g:AutoCloseProtectedRegions = ["Character"]

" CtrlP
nmap <leader>f :CtrlP<cr>
let g:ctrlp_show_hidden = 1

" Add settings for tabular
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Tabularize
if exists(":Tab")
  nmap <leader>a\| :Tab /\|<CR>
  vmap <leader>a\| :Tab /\|<CR>
  nmap <leader>a= :Tab /=<CR>
  vmap <leader>a= :Tab /=<CR>
  nmap <leader>a: :Tab /:\zs<CR>
  vmap <leader>a: :Tab /:\zs<CR>
endif

" Powerline
" set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'

"  ---------------------------------------------------------------------------
"  Language Mappings
"  ---------------------------------------------------------------------------

" Other files to consider Ruby
au BufRead,BufNewFile Gemfile,Rakefile,Thorfile,config.ru,Vagrantfile,Guardfile,Capfile set ft=

" Python
autocmd FileType python set sw=4 sts=4 et

" CoffeeScript
let coffee_compile_vert = 1
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent

" SASS / SCSS
au BufNewFile,BufReadPost *.scss setl foldmethod=indent
au BufNewFile,BufReadPost *.sass setl foldmethod=indent
au BufRead,BufNewFile *.scss set filetype=scss

"  ---------------------------------------------------------------------------
"  Directories
"  ---------------------------------------------------------------------------

set backupdir=~/tmp,/tmp
set undodir=~/.vim/.tmp,~/tmp,~/.tmp,/tmp

" Ctags path (brew install ctags)
let Tlist_Ctags_Cmd = 'ctags'

" Make Vim use RVM correctly when using Zsh
" https://rvm.beginrescueend.com/integration/vim/
set shell=/bin/bash\ -l

" Finally, load custom configs
if filereadable($HOME . '.vimrc.local')
  source ~/.vimrc.local
endif

"  ---------------------------------------------------------------------------
"  MacVIM
"  ---------------------------------------------------------------------------

if has("gui_running")
  set guioptions-=T " no toolbar set guioptions-=m " no menus
  set guioptions-=r " no scrollbar on the right
  set guioptions-=R " no scrollbar on the right
  set guioptions-=l " no scrollbar on the left
  set guioptions-=b " no scrollbar on the bottom
  set guioptions=aiA
endif

"  ---------------------------------------------------------------------------
"  GnomeTerminal
"  ---------------------------------------------------------------------------
"
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

"  ---------------------------------------------------------------------------
"  Colors
"  ---------------------------------------------------------------------------
" let g:solarized_termcolors=256
set background=dark
color blackboard
colorscheme ir_black

"  ---------------------------------------------------------------------------
"  Misc
"  ---------------------------------------------------------------------------



" When vimrc, either directly or via symlink, is edited, automatically reload it
autocmd! bufwritepost .vimrc source %
autocmd! bufwritepost vimrc source %

map ,t <Esc>:tabnew<CR>
map ,tf <Esc>:tabf<Space>

execute pathogen#infect()
execute pathogen#infect()
" autocmd vimenter * NERDTree
" map ,nt <Esc>:NERDTree<CR>:NERDTreeMirror<CR>
" let g:NERDTreeWinSize = 40

set guifont=Monaco:h15

map ,al <Esc>:Tabularize /=<CR>
map ,css <Esc>:Tabularize /:\zs/<CR>
" map ,tabu <Esc>:Tabularize<Space>/
map ,ex <Esc>:Explore<CR>
map <M-s> :w<CR>
imap <M-s> <Esc>:w<CR>i
" set autochdir

set foldlevel=20
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:100'

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

map <leader>h <Esc>:noh<CR>

map <leader>l <Esc>:MRU<CR>
map <leader>sf <Esc>:FufCoverageFile<CR>
map <leader>sl <Esc>:FufLine<CR>

let g:syntastic_ruby_exec = 'ruby19'

au BufRead,BufNewFile *.tpl set filetype=smarty
map <leader>utf8 muggO<Esc>O# -*- encoding : utf-8 -*-<Esc>`u<CR>
map <leader>rspec :!bundle exec rspec spec<CR>
map <leader>spec :!rspec spec<CR>

:au FocusLost * :set norelativenumber
:au FocusGained * :set relativenumber
" :autocmd InsertEnter * :set norelativenumber
" :autocmd InsertLeave * :set relativenumber

set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set nofoldenable " Say no to code folding...

command! Q q " Bind :Q to :q
command! Qall qall

" Disable Ex mode
map Q <Nop>

" Disable K looking stuff up
map K <Nop>

" When loading text files, wrap them and don't split up words.
au BufNewFile,BufRead *.txt setlocal wrap
au BufNewFile,BufRead *.txt setlocal lbr
au BufNewFile,BufRead *.txt setlocal nolist " Don't display whitespace

" Merge a tab into a split in the previous window
function! MergeTabs()
  if tabpagenr() == 1
    return
  endif
  let bufferName = bufname("%")
  if tabpagenr("$") == tabpagenr()
    close!
  else
    close!
    tabprev
  endif
  split
  execute "buffer " . bufferName
endfunction

nmap <C-W>u :call MergeTabs()<CR>

" Don't add the comment prefix when I hit enter or o/O on a comment line.
set formatoptions-=or

let g:CommandTMatchWindowAtTop=1

au BufWritePre *.rb :%s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <Leader>ren :call RenameFile()<cr>

