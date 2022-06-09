" Some basics:
	set nocompatible
	set encoding=utf-8
	set nohlsearch
	set clipboard+=unnamedplus
	set shortmess-=S
	set termguicolors
	set guifont=Hack\ Regular\ Nerd\ Font\ Comeplete\ 12
	set number relativenumber

" Allows to select commands in command mode
	set wildmode=longest,list,full
	set completeopt=menu,menuone,noselect

" Activate auto indent depending on filetype and turn syntax on
	filetype plugin indent on
	filetype plugin on
	syntax enable

" Set commentstring for other filetypes following the structure
	autocmd FileType cfg set commentstring=#\ %s
	autocmd FileType ca set commentstring=//\ %s

" Automatically saves when losing focus
	autocmd BufLeave,FocusLost * silent! wall

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	if has('nvim')
		let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
	else
		let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
	endif

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}

" Vimtex settings
	let g:tex_flavor = 'latex'
	let g:vimtex_view_method = 'zathura'
	let g:vimtex_view_general_viewer = 'okular'
	let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
"	let g:vimtex_compiler_method = 'latexrun'

" Do stuff after reading
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e

" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost files,directories !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Hexokinase settings
	" let g:Hexokinase_highlighters = ['virtual']
	let g:Hexokinase_highlighters = ['sign_column']
