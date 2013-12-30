syntax enable

set nocompatible " be iMproved
filetype on      " required!

set t_Co=256
"set t_Co=88
let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }
colorscheme railscasts


let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

set rtp+=~/.vim/bundle/vundle/
set ruler
set number
set list
set listchars=tab:▸\ ,eol:¬
set ts=2 sts=2 sw=2 expandtab
call vundle#rc()

nmap + :vertical res +5^M<CR>
nmap _ :vertical res -5^M<CR>

" required! 
Bundle 'gmarik/vundle'

" original repos on GitHub
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'ivalkeen/vim-simpledb'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-unimpaired'
Bundle 'FuzzyFinder'

nmap <TAB> <C-w>w
imap jj <ESC>
imap >> <ESC>>>i
imap << <ESC><<i
" This makes it so that all indentation commands are the same in all modes.
" Causes a problem with ranges in ruby.  You would have to slow type ..
imap << <ESC>v<i
imap << <ESC>v<i
nmap << <<
nmap >> >>
vmap << <gv
vmap >> >gv

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

" Rails Helpers

imap def<TAB> def<CR><CR>end<ESC>ki  <ESC>k$a 

