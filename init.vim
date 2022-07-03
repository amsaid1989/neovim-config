if !exists('g:vscode')
	" Install vim-plug if not found
	let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
	if empty(glob(data_dir . '/autoload/plug.vim'))
		silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

	" Run PlugInstall if there are missing plugins
	autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
		\| PlugInstall --sync | source $MYVIMRC
	\| endif

	" VIM PLUGGED
	call plug#begin('~/.vim/plugged')
		" USE 'gc' TO COMMENT PARTS OF CODE WITH MOTION OR 'gcc' TO COMMENT
		" THE ENTIRE LINE
		Plug 'https://github.com/tpope/vim-commentary'

		" SENSIBLE VIM
		Plug 'tpope/vim-sensible'

		" JavaScript Syntax Highlightin
		Plug 'pangloss/vim-javascript'
		
		" THEMES
		Plug 'dracula/vim'
		
		" NERD TREE FILE MANAGER
		Plug 'scrooloose/nerdtree'
		Plug 'ryanoasis/vim-devicons'
		
		" FUZZY FINDER
		Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
		Plug 'junegunn/fzf.vim'

		" SLIVERSEARCHER FOR FUZZY FINDER TO IGNORE NODE MODULES AND
		" FILES IN .gitignore
		Plug 'https://github.com/ggreer/the_silver_searcher'

		" COC for code completion
		Plug 'neoclide/coc.nvim', {'branch': 'release'}
		Plug 'leafgarland/typescript-vim'
		Plug 'peitalin/vim-jsx-typescript'

		" AUTO CLOSE PAIRS
		Plug 'https://github.com/jiangmiao/auto-pairs'

		" AUTO CLOSE HTML TAGS	
		Plug 'alvan/vim-closetag'

		" C++ SYNTAX HIGHLIGHTING 
		Plug 'https://github.com/bfrg/vim-cpp-modern'

		" PYTHON AUTO FORMAT WITH BLACK
		Plug 'psf/black'
		
		" VIM STATUSLINE
		Plug 'vim-airline/vim-airline'
		Plug 'vim-airline/vim-airline-themes'

		" SYNTAX HIGHLIGHTING
		Plug 'sheerun/vim-polyglot'	
		
		" MARKDOWN PLUGINS
		" tabular plugin is used to format tables
		Plug 'godlygeek/tabular'
		" JSON front matter highlight plugin
		Plug 'elzr/vim-json'
		Plug 'plasticboy/vim-markdown'

		" MARKDOWN PREVIEW
		" If you don't have nodejs and yarn
		" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
		" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
		Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

	set number relativenumber

	" THEME AND SYNTAX HIGHLIGHTING CONFIG
	if (has("termguicolors"))
	 set termguicolors
	endif
	syntax enable

	colorscheme dracula

	" NERD TREE CONFIG
	let g:NERDTreeShowHidden = 1
	let g:NERDTreeMinimalUI = 1
	let g:NERDTreeIgnore = []
	let g:NERDTreeStatusline = ''
	" Automaticaly close nvim if NERDTree is only thing left open
	" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	" Toggle
	nnoremap <silent> <C-b> :NERDTreeToggle<CR>
	" END NERD TREE CONFIG

	" TERMINAL CONFIG
	" open new split panes to right and below
	set splitright
	set splitbelow
	" turn terminal to normal mode with escape
	tnoremap <Esc> <C-\><C-n>
	" start terminal in insert mode
	au BufEnter * if &buftype == 'terminal' | :startinsert | endif
	" open terminal on ctrl+n
	function! OpenTerminal()
		split term://fish
		resize 10
	endfunction
	nnoremap <c-n> :call OpenTerminal()<CR>
	" END TERMINAL CONFIG 

	" PANE NAVIGATION CONFIG
	" use alt+hjkl to move between split/vsplit panels
	tnoremap <A-h> <C-\><C-n><C-w>h
	tnoremap <A-j> <C-\><C-n><C-w>j
	tnoremap <A-k> <C-\><C-n><C-w>k
	tnoremap <A-l> <C-\><C-n><C-w>l
	nnoremap <A-h> <C-w>h
	nnoremap <A-j> <C-w>j
	nnoremap <A-k> <C-w>k
	nnoremap <A-l> <C-w>l
	" END PANE NAVIGATION CONFIG

	" FUZZY FINDER CONFIG
	" Open the finder with CTRL+P. Open the selected file in new tab with CTRL+T.
	" Open the file to the right with CTRL+S. Open the file in a pane below with
	" CTRL+V
	nnoremap <C-p> :FZF<CR>
	let g:fzf_action = {
		\ 'ctrl-t': 'tab split',
		\ 'ctrl-s': 'split',
		\ 'ctrl-v': 'vsplit'
		\}
	" Tell FZF to use sliversearcher
	let $FZF_DEFAULT_COMMAND = 'ag -g ""'


	" COC CONFIG
	let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-jedi']

	" if hidden is not set, TextEdit might fail.
	set hidden

	" Some servers have issues with backup files, see #649
	set nobackup
	set nowritebackup

	" Better display for messages
	set cmdheight=2

	" You will have bad experience for diagnostic messages when it's default 4000.
	set updatetime=300

	" don't give |ins-completion-menu| messages.
	set shortmess+=c

	" always show signcolumns
	set signcolumn=yes

	" Use tab for trigger completion with characters ahead and navigate.
	" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
	inoremap <silent><expr> <TAB>
				\ pumvisible() ? "\<C-n>" :
				\ <SID>check_back_space() ? "\<TAB>" :
				\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()

	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
	" Coc only does snippet and additional edit on confirm.
	inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

	" Use `[c` and `]c` to navigate diagnostics
	nmap <silent> [c <Plug>(coc-diagnostic-prev)
	nmap <silent> ]c <Plug>(coc-diagnostic-next)

	" Remap keys for gotos
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction

	" Highlight symbol under cursor on CursorHold
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Remap for rename current word
	nmap <leader>rn <Plug>(coc-rename)

	" Remap for format selected region
	xmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)

	augroup mygroup
		autocmd!
		" Setup formatexpr specified filetype(s).
		autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
		" Update signature help on jump placeholder
		autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end

	" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)

	" Remap for do codeAction of current line
	nmap <leader>ac  <Plug>(coc-codeaction)
	" Fix autofix problem of current line
	nmap <leader>qf  <Plug>(coc-fix-current)

	" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
	nmap <silent> <TAB> <Plug>(coc-range-select)
	xmap <silent> <TAB> <Plug>(coc-range-select)
	xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

	" Use `:Format` to format current buffer
	command! -nargs=0 Format :call CocAction('format')

	" Use `:Fold` to fold current buffer
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)

	" use `:OR` for organize import of current buffer
	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

	" Add status line support, for integration with other plugin, checkout `:h coc-status`
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

	" Using CocList
	" Show all diagnostics
	nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
	" Manage extensions
	nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
	" Show commands
	nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document
	nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols
	nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	nnoremap <silent> <space>j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
	" Resume latest coc list
	nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

	" END COC CONFIG

	" CLOSE HTML TAGS CONFIG\
	" filenames like *.xml, *.html, *.xhtml, ...
	" These are the file extensions where this plugin is enabled.
	"
	let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

	" filenames like *.xml, *.xhtml, ...
	" This will make the list of non-closing tags self-closing in the specified files.
	"
	let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

	" filetypes like xml, html, xhtml, ...
	" These are the file types where this plugin is enabled.
	"
	let g:closetag_filetypes = 'html,xhtml,phtml'

	" filetypes like xml, xhtml, ...
	" This will make the list of non-closing tags self-closing in the specified files.
	"
	let g:closetag_xhtml_filetypes = 'xhtml,jsx'

	" integer value [0|1]
	" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
	"
	let g:closetag_emptyTags_caseSensitive = 1

	" dict
	" Disables auto-close if not in a "valid" region (based on filetype)
	"
	let g:closetag_regions = {
			\ 'typescript.tsx': 'jsxRegion,tsxRegion',
			\ 'javascript.jsx': 'jsxRegion',
			\ 'typescriptreact': 'jsxRegion,tsxRegion',
			\ 'javascriptreact': 'jsxRegion',
			\ }

	" Shortcut for closing tags, default is '>'
	"
	let g:closetag_shortcut = '>'

	" Add > at current position without closing the current tag, default is ''
	"
	let g:closetag_close_shortcut = '<leader>>'
	" END CLOSE HTML TAGS CONFIG

	" BLACK PYTHON AUTO FORMATTER CONFIG
	" Format python code on save
	autocmd BufWritePre *.py execute ':Black'
	" END BLACK PYTHON AUTO FORMATTER CONFIG

	" MARKDOWN CONFIGURATION
	" disable header folding
	let g:vim_markdown_folding_disabled = 1

	" do not use conceal feature, the implementation is not so good
	let g:vim_markdown_conceal = 0

	" disable math tex conceal feature
	let g:tex_conceal = ""
	let g:vim_markdown_math = 1

	" support front matter of various format
	let g:vim_markdown_frontmatter = 1  " for YAML format
	let g:vim_markdown_toml_frontmatter = 1  " for TOML format
	let g:vim_markdown_json_frontmatter = 1  " for JSON format

	" MARKDOWN PREVIEW CONFIG
	" do not close the preview tab when switching to other buffers
	let g:mkdp_auto_close = 0
	nnoremap <M-m> :MarkdownPreview<CR>
endif	
