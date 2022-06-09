" Set the map leader
	let mapleader =","

" map j gg maps j to gg
" map Q j also maps Q to gg because is mapped recursively
" noremap W j will not map to gg because is no recursive
" n map : normal mode map; vmap : visual mode, etc

" Set simple remaps
	nnoremap c "_c
	nnoremap g<Space> <Esc>/<-><Enter>ca<

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_us<CR>
	map <leader>e :NERDTreeToggle<CR>

" Shortcutting split navigation, saving a keypress:
	nnoremap <C-h> <C-w>h
	nnoremap <C-j> <C-w>j
	nnoremap <C-k> <C-w>k
	nnoremap <C-l> <C-w>l

" Replace ex mode with gq
	map Q gq

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !com <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Set mapping for VCoolor plugin
	nnoremap <leader>vc :VCoolor<enter>

" Set mapping for signcolumn plugin
	nnoremap <leader>sg :set signcolumn=yes:5<enter>


if &diff
    highlight! link DiffText MatchParen
endif
