"dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

" Required:
set runtimepath+=/home/dhill/.nvim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/dhill/.nvim/bundles')
  call dein#begin('/home/dhill/.nvim/bundles')

  " Let dein manage dein
  " Required:
  call dein#add('/home/dhill/.nvim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " General Packages
  call dein#add('dracula/vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('kien/ctrlp.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

inoremap jj <Esc>

set termguicolors
color dracula

autocmd vimenter * NERDTree

