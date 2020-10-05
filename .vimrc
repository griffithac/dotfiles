set rtp+=~/.fzf
" call plug#begin('~/.vim/plugged')
"   Plug '/usr/local/opt/fzf'
"   Plug 'junegunn/fzf.vim'
" call plug#end()

execute pathogen#infect()
set nocompatible " be iMproved
set noic
filetype off     " required!
filetype plugin on

set nobackup
set noswapfile

set t_Co=256
"set t_Co=88
execute "set colorcolumn=" . join(range(81,81), ',')

let g:CSApprox_attr_map = { 'bold' : 'bold', 'italic' : '', 'sp' : '' }

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Ack Settings
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" color greenvision
" color redblack
" color blacklight
" color railscasts256
" color sexy-railscasts
" color Monokai
color Tomorrow-Night-Bright
" color Tomorrow-Night-Eighties
" color Tomorrow
" color adam

" Markdown Preview
let vim_markdown_preview_github=1

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1

let g:multi_cursor_start_key='g<C-n>'
let g:multi_cursor_start_word_key='<C-n>'

let g:move_key_modifier = 'C'

" vim-notes
:let g:notes_directories = ['~/Dropbox/Notes']

" Add syntax rule
let g:ruby_heredoc_syntax_filetypes = { "sh" : { "start" : "SH" } }

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

nnoremap <silent> {Left-mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

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

nmap <leader>r :!ruby %<cr>

" nmap <S-TAB> :tabn<CR>

" map www to write 
map www <ESC>:w<CR>

nmap :vimrc :edit ~/.vimrc<CR>

map <leader>t :Files<CR>
map <C-t> :Files<CR>

let g:vimrubocop_config = '~/dotfiles/rubocop.yml'
let g:vimrubocop_keymap = 0
nmap <Leader>c :RuboCop<CR>


" map shortcut to buffer delete
nmap <leader>d :Bd<CR>

" shortcut to Ack
nmap <Leader>a :Ack 

" open vimrc on the fly
nmap <leader>\ :tabedit $MYVIMRC<CR>

" format file
map <leader>f gg=G<C-o><C-o>

nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" map simicolon to colon to save shifting
nmap ; :

nnoremap <Leader>b :ls<CR>:b<Space>

if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
autocmd BufWritePre *.py,*.js,*.coffee,*.rb,*.rake :call <SID>StripTrailingWhitespaces()
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufRead *.crb set syntax=ruby
autocmd BufNewFile,BufRead *.axlsx set syntax=ruby

function! <SID>StripTrailingWhitespaces()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

" CtrlP auto cache clearing.
function! SetupCtrlP()
  if exists("g:loaded_ctrlp") && g:loaded_ctrlp
    augroup CtrlPExtension
      autocmd!
      autocmd FocusGained  * CtrlPClearCache
      autocmd BufWritePost * CtrlPClearCache
    augroup END
  endif
endfunction
if has("autocmd")
  autocmd VimEnter * :call SetupCtrlP()
endif

syntax enable
filetype plugin indent on
