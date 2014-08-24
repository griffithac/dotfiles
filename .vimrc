set nocompatible " be iMproved
filetype off     " required!
filetype plugin on

set t_Co=256
"set t_Co=88
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

" color greenvision
" color redblack
" color blacklight
color railscasts256

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

set backspace=indent,eol,start
set rtp+=~/.vim/bundle/vundle/
set ruler
set number
set list
set listchars=tab:▸\ ,eol:¬
set ts=2 sts=2 sw=2 expandtab
set hlsearch
set hlsearch
" set foldmethod=syntax
call vundle#rc()
let mapleader = ','

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" manually set coffeescript syntax on file open
au BufRead,BufNewFile *.coffee set syn=coffee

" required! 
Bundle 'gmarik/vundle'

" original repos on GitHub
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'ivalkeen/vim-simpledb'
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-unimpaired'
"Bundle 'vim-scripts/L9'
"Bundle 'vim-scripts/FuzzyFinder'
Bundle 'kien/ctrlp.vim'
Bundle 'flazz/vim-colorschemes'
"Bundle 'EasyGrep'
Bundle 'xolox/vim-misc.git'
Bundle 'xolox/vim-colorscheme-switcher'
Bundle 'rgarver/Kwbd.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'mileszs/ack.vim'
Bundle 'tomtom/tcomment_vim'
" Bundle 'ervandew/supertab'
Bundle 'moll/vim-bbye'
Bundle 'kchmck/vim-coffee-script'

" tmux navication key bindigns using ctrl
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> {Left-mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previoust-Mapping} :TmuxNavigatePrevious<cr>

" resize window
nmap + :vertical res +5^M<CR>
nmap _ :vertical res -5^M<CR>

" cycle windows with leader m
map <leader>m <C-w>w


vmap <leader>' <S-s>' 
vmap <leader>" <S-s>" 
vmap <leader>{ <S-s>{ 


" explore with leader e
map <leader>e :Explore<CR>
map <leader>v :Vexplore<CR>
map <leader>s :Sexplore<CR>

" shortcut for Bdelete
nnoremap <Leader>q :Bdelete<CR>

" nmap <S-TAB> :tabn<CR>

" use up and down nav to exit insert mode
imap jj <ESC>j
imap kk <ESC>k

" This makes it so that all indentation commands are the same in all modes.
" Causes a problem with ranges in ruby.  You would have to slow type ..
imap >> <ESC>>>i
imap << <ESC><<i
imap << <ESC>v<i
imap << <ESC>v<i
nmap << <<
nmap >> >>
vmap << <gv
vmap >> >gv
nmap :vimrc :edit ~/.vimrc<CR>

map <leader>t :CtrlP<CR>
map <C-t> :CtrlP<CR>

" execute ruby code in current buffer
nmap <leader>r :!ruby %<CR>

" map shortcut to buffer delete
nmap <leader>d :Bd<CR>

" map simicolon to colon to save shifting
nmap ; :

nmap :b<CR> :buffers<CR>
nmap <leader>g :silent !touch %<CR>

if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" open vimrc on the fly
nmap <leader>\ :tabedit $MYVIMRC<CR>

nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
autocmd BufWritePre *.py,*.js,*.coffee,*.rb,*.rake :call <SID>StripTrailingWhitespaces()

function! <SID>StripTrailingWhitespaces()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

syntax enable
filetype plugin indent on
