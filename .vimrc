execute pathogen#infect()
set nocompatible " be iMproved
filetype off     " required!
filetype plugin on

set t_Co=256
"set t_Co=88
execute "set colorcolumn=" . join(range(81,335), ',')

let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

" color greenvision
" color redblack
" color blacklight
" color railscasts256
" color Monokai
color Tomorrow-Night

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

let g:multi_cursor_start_key='g<C-n>'
let g:multi_cursor_start_word_key='<C-n>'

let g:move_key_modifier = 'C'

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
let mapleader = ','

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/ 

" manually set coffeescript syntax on file open
au BufRead,BufNewFile *.coffee set syn=coffee

" manually set slim syntax on file open
au BufRead,BufNewFile *.slim set syn=slim
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

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

" map www to write 
map www <ESC>:w<CR>

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

silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

autocmd BufWritePre *.py,*.js,*.coffee,*.rb,*.rake :call <SID>StripTrailingWhitespaces()
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

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
