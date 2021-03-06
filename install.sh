#!/bin/sh

cd
ln -sv dotfiles/.ackrc
ln -sv dotfiles/.gitignore_global
ln -sv dotfiles/.oh-my-zsh
ln -sv dotfiles/.pryrc
ln -sv dotfiles/.irbrc
ln -sv dotfiles/.tmux.conf
ln -sv dotfiles/.vimrc
ln -sv dotfiles/.vmailrc
ln -sv dotfiles/.xvimrc
ln -sv dotfiles/.zshrc
ln -sv dotfiles/.zshrc-update
ln -sv dotfiles/.gemrc

rm -fR ~/.vim
mkdir -p ~/.vim
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd .vim/bundle
git clone https://github.com/vim-scripts/FuzzyFinder.git
git clone https://github.com/rgarver/Kwbd.vim.git
git clone https://github.com/vim-scripts/L9.git
git clone https://github.com/mileszs/ack.vim.git
git clone https://github.com/kien/ctrlp.vim.git
git clone https://github.com/tristen/vim-sparkup.git
git clone https://github.com/tomtom/tcomment_vim.git
git clone https://github.com/tomtom/tlib_vim.git
git clone https://github.com/vim-scripts/vim-addon-mw-utils.git
git clone https://github.com/bling/vim-airline.git
git clone https://github.com/tpope/vim-bundler.git
git clone https://github.com/kchmck/vim-coffee-script.git
git clone https://github.com/xolox/vim-colorscheme-switcher.git
git clone https://github.com/flazz/vim-colorschemes.git
git clone https://github.com/Lokaltog/vim-easymotion.git
git clone https://github.com/tpope/vim-endwise.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/tpope/vim-git.git
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/tpope/vim-markdown.git
git clone https://github.com/xolox/vim-misc.git
git clone https://github.com/xolox/vim-notes.git
git clone https://github.com/matze/vim-move.git
git clone https://github.com/terryma/vim-multiple-cursors.git
git clone https://github.com/tpope/vim-rails.git
git clone https://github.com/tpope/vim-rake.git
git clone https://github.com/ngmy/vim-rubocop.git
git clone https://$1:$2@github.com/tpope/vim-ruby.git
git clone https://github.com/tpope/vim-sensible.git
git clone https://github.com/ivalkeen/vim-simpledb.git
git clone https://github.com/slim-template/vim-slim.git
git clone https://github.com/garbas/vim-snipmate.git
git clone https://github.com/honza/vim-snippets.git
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/christoomey/vim-tmux-navigator.git
git clone https://github.com/tpope/vim-unimpaired.git
git clone https://github.com/Shougo/vimproc.vim.git
git clone https://github.com/christoomey/vim-tmux-navigator.git
git clone https://github.com/moll/vim-bbye.git
git clone https://github.com/joker1007/vim-markdown-quote-syntax
git clone https://github.com/godlygeek/tabular.git
git clone https://github.com/voi/unite-ctags.git
git clone https://github.com/szw/vim-tags.git
git clone https://github.com/pangloss/vim-javascript.git
git clone https://github.com/jelera/vim-javascript-syntax.git
git clone https://github.com/othree/yajs.git
git clone https://github.com/greyblake/vim-preview.git
git clone https://github.com/vim-syntastic/syntastic.git
git clone https://github.com/othree/eregex.vim
git clone https://github.com/junegunn/fzf.vim
# git clone https://github.com/craigemery/vim-autotag

echo 'Install Complete'
