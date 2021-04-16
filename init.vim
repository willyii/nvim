"__     _____ __  __ ____   ____
"\ \   / /_ _|  \/  |  _ \ / ___|
" \ \ / / | || |\/| | |_) | |
"  \ V /  | || |  | |  _ <| |___
"   \_/  |___|_|  |_|_| \_\\____|
"
"   Author: @Xinlong

" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim


" Basic Setting
let mapleader=" "
set nocompatible
syntax on
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set mouse=a
set encoding=utf-8
let &t_ut=""
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=10
set tw=80
set indentexpr=
set backspace=indent,eol,start
set foldmethod=syntax
set foldclose=all
set foldlevel=99
set laststatus=2
set autochdir
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

set number
set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu

" Search Setting
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase
noremap <LEADER><CR> :nohlsearch<CR>

noremap J 5j
noremap K 5k
noremap L 5l
noremap H 5h
noremap n nzz
noremap N Nzz

" Save Setting
map S :w<CR>
map s <nop>
map Q :q<CR>
map R :source $MYVIMRC<CR>

"Split Screen
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sj :set splitbelow<CR>:split<CR>
"map sv <C-w>t<C-w>H
"map sh <C-w>t<C-w>K

map <LEADER>l <C-w>l
map <LEADER>j <C-w>j
map <LEADER>k <C-w>k
map <LEADER>h <C-w>h

map vimrc :e ~/.config/nvim/init.vim<CR>
map term sl :term<CR>

" Screen Size
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

" Tahb
map tb :tabe<CR>
map th :-tabnext<CR>
map tl :+tabnext<CR>

map sc :set spell!<CR>

" Searching  todo
map td :/TODO<CR> nzz :nohlsearch<CR>


" Plugs
call plug#begin('~/.config/nvim/plugged')

" Lazygit
Plug 'kdheepak/lazygit.vim', { 'branch': 'nvim-v0.4.3' }

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Nerd Commenter
Plug 'preservim/nerdcommenter'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
if !has('nvim')
  Plug 'rhysd/vim-healthcheck'
endif

" Theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Document Generator
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

" Airline
Plug 'vim-airline/vim-airline'

" Latex
Plug 'lervag/vimtex'

call plug#end()

" ===
" === Doge, document generator
" ===
map <LEADER>g :DogeGenerate<CR>
let g:doge_mapping_comment_jump_forward = '`'

" ===
" === Theme
" ===
colorscheme dracula

" ===
" === coc.vim
" ===
set hidden
set updatetime=100
set shortmess+=c
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

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <LEADER>d to show documentation in preview window.
nnoremap <silent> <LEADER>d :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

let g:coc_global_extensions = [
  \ 'coc-json', 
  \ 'coc-vimlsp',
  \ 'coc-sh',
  \ 'coc-pyright', 
  \ 'coc-sql',
  \ 'coc-clangd',
  \ 'coc-rust-analyzer', 
  \ 'coc-explorer', 
  \ 'coc-html']

" Toggle coc-explorer
:nnoremap tt :CocCommand explorer<CR>

" ===
" === lazygit.vim
" ===
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window
let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
nnoremap git :LazyGit<CR>

" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1

" ===
" === Python-syntax
" ===
let g:python_highlight_all = 1
let g:python_slow_sync = 0

" ===
" === Nerd Commenter
" ===
let g:NERDDefaultAlign = 'left'
map <LEADER>/ <plug>NERDCommenterComment
map <LEADER>// <plug>NERDCommenterInvert
map fig :r !figlet

"===
"=== Markdown cheatsheep
"===
autocmd Filetype markdown inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd Filetype markdown inoremap ,n ---<Enter><Enter>
autocmd Filetype markdown inoremap ,b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap ,i ** <++><Esc>F*i
autocmd Filetype markdown inoremap ,d `` <++><Esc>F`i
autocmd Filetype markdown inoremap ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap ,h ====<Space><++><Esc>F=hi
autocmd Filetype markdown inoremap ,p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap ,l --------<Enter>
autocmd Filetype markdown inoremap ,$ $$<Space><++><Esc>F$i

" ===
" === Latex shortcut
" ===
autocmd Filetype tex inoremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd FileType tex inoremap \bg \begin{}<Esc>i

" ===
" === Cpp shortcut
" ===
autocmd Filetype cpp inoremap todo /* TODO : */ <Esc>F:a

