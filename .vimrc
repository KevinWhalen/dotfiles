syntax enable
" line numbers
set number
set ruler
set hlsearch
"set background=dark
"colorscheme solarized
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1

set nocompatible
set nobk
"set listchars=tab:»\ ,trail:_
"set list

" character encoding
set enc=utf8
set encoding=utf-8
set fileencoding=utf-8
" tab sizing
set tabstop=4
set shiftwidth=4
set softtabstop=4
" auto indent
set ai
" smart indent
"set si
" cursor buffer at the top and bottom
set scrolloff=0
" unmodified pasting
set pastetoggle=<F2>
" create command to clear a search pattern
command C let @/=""

" soft wrap
set wrap linebreak textwidth=0
"set nowrap

" vertical ruler
"set colorcolumn=80

" disable clipboard
set clipboard=exclude:.*

" Soloraized in MinTTY
set bg=light

" Highlight line and column
"set cursorcolumn
"set cursorline

" vimdiff
if &diff
    " bold orange text color and grey background
    highlight DiffText cterm=bold ctermfg=1 ctermbg=12 gui=none guifg=maroon guibg=blue
    " squashes down the before and after context (but not yet to a true 0;
    " might only be before or after)
    "set diffopt=filler,context:0
endif


" Status Line {
    set laststatus=2                             " always show statusbar
    set statusline=
    set statusline+=%-10.3n\                     " buffer number
    set statusline+=%f\                          " filename
    set statusline+=%h%m%r%w                     " status flags
    set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
    set statusline+=%=                           " right align remainder
    set statusline+=0x%-8B                       " character value
    set statusline+=%-14(%l,%c%V%)               " line, character
    set statusline+=%<%P                         " file position
"}


""" ===
" Pathogen plugin bundler
execute pathogen#infect()

" https://github.com/kchmck/vim-coffee-script#coffeewatch-live-preview-compiling
" create alias command to trigger coffee watching window
command W CoffeeWatch
":setl scrollbind
" https://github.com/kchmck/vim-coffee-script#coffee_watch_vert
"let coffee_watch_vert = 1
""" ---

""" ===
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" https://microsoft.github.io/language-server-protocol/implementors/tools/
" https://github.com/neoclide/coc.nvim/wiki/Language-servers
" Conquer of Completion
" Configuration file: ~/.vim/coc-settings.json
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" pip3 install --user python-language-server

" Initialize plugin system
call plug#end()
""" ---


" Use <tab> for completion trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif


" folding `:help fold-commands`
" http://vim.wikia.com/wiki/Folding
" `zf` create fold
" `zo` open fold (expand)
" `zc` close fold up
" `za` toggle visibility
" `zd` delete fold
" `zM` fold all
" `zR` unfold all
"set foldmethod=manual
"set foldmethod=marker
"set foldmethod=syntax
" http://vim.wikia.com/wiki/VimTip991


" split buffers (windows)
" :sp filename            Open filename in horizontal split
" :vsp filename           Open filename in vertical split
" :sb#                    Put a buffer in a split window (# is its number)
" :vert sb#               Put buffer # in a vertical split window
" Ctrl+w [h|l|j|k|←|→|↑]  Shift focus to different split
" Ctrl+w n+               Increase size of current split by n lines
" Ctrl+w n-               Decrease size of current split by n lines
" Ctrl+w _                Maximize height of the current split
" Ctrl+w |                Maximize width of the current split
" Ctrl+w =                Equalized splits
" Ctrl+W R                Swap split positions
" Ctrl+W T                Pull current window into a new buffer tabview
" Ctrl+W o                Close all but current window
" Top to bottom, left to right splitting:
set splitbelow
set splitright


" clearspeed filetype syntax highlighting
autocmd! BufRead,BufNewFile *.cn setfiletype c
" text files
autocmd! BufRead,BufNewFile *.txt set nonumber
" LESS CSS
"autocmd! BufRead,BufNewFile *.less setfiletype css
" SCSS (Sass CSS)
"autocmd! BufRead,BufNewFile *.scss setfiletype css
" jsonc (JSON with comments)
autocmd FileType json syntax match Comment +\/\/.\+$+
" JSON, automatically fold large files
function FoldLarge()
    if line('$') > 2000
        set foldmethod=syntax
    endif
endfunction
augroup vimrc_autocmds_json
    autocmd!
    autocmd BufRead *.json call FoldLarge()
augroup END
" markdown text files
augroup vimrc_autocmds_md
    autocmd!
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.md set nonumber
augroup END
" YAML
augroup vimrc_autocmds_yml
    autocmd!
    autocmd BufRead,BufNewFile *.yml set tabstop=4
    autocmd BufRead,BufNewFile *.yml set shiftwidth=4
    autocmd BufRead,BufNewFile *.yml set softtabstop=4
    autocmd BufRead,BufNewFile *.yml set expandtab
augroup END
" python
augroup vimrc_autocmds_py
    autocmd!
    autocmd BufRead,BufNewFile *.py set tabstop=4
    autocmd BufRead,BufNewFile *.py set shiftwidth=4
    autocmd BufRead,BufNewFile *.py set softtabstop=4
    autocmd BufRead,BufNewFile *.py set expandtab
    let g:pyindent_continue=4
    let g:pyindent_open_paren=4
augroup END
" coffeescript
augroup vimrc_autocmds_coffee
    autocmd!
    autocmd BufRead,BufNewFile *.coffee set tabstop=4
    autocmd BufRead,BufNewFile *.coffee set shiftwidth=4
    autocmd BufRead,BufNewFile *.coffee set softtabstop=4
    autocmd BufRead,BufNewFile *.coffee set expandtab
augroup END
" OpenCL
augroup vimrc_autocmds_cl
    autocmd!
    autocmd BufRead,BufNewFile *.cl set filetype=cpp
augroup END
" Docker
augroup vimrc_autocmds_docker
    autocmd!
    autocmd BufRead,BufNewFile Dockerfile set filetype=dockerfile
    autocmd BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
augroup END
" Jenkins
augroup vimrc_autocmds_jenkins
    autocmd!
    autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy
    autocmd BufRead,BufNewFile Jenkinsfile.* set filetype=groovy
augroup END
" Mermaid (markdown) Diagram
augroup vimrc_autocmds_mmd
    autocmd!
    autocmd BufRead,BufNewFile *.mmd set tabstop=2
    autocmd BufRead,BufNewFile *.mmd set shiftwidth=2
    autocmd BufRead,BufNewFile *.mmd set softtabstop=2
    autocmd BufRead,BufNewFile *.mmd set expandtab
augroup END

"autocmd BufEnter * :syntax sync fromstart

" Format XML
":%!xmllint --format -

" Format JSON
":%!python3 -m json.tool
":%!jq

" Function example
" https://vi.stackexchange.com/a/21969/5647
"function! FormatJson()
"python3 << EOF
"import vim
"import json
"try:
"    buf = vim.current.buffer
"    json_content = '\n'.join(buf[:])
"    content = json.loads(json_content)
"    sorted_formatted = json.dumps(content, indent=4, sort_keys=True)
"    buf[:] = sorted_formatted.split('\n')
"except Exception as e:
"    print(e)
"EOF
"endfunction




source ~/.vim/coc.vimrc
source ~/.vim/gitgutter.vimrc


" Current vimfile stuff.
"   ~/.vim:
"     coc-settings.json
"   ~/.vim/autoload:
"     pathogen.vim  plug.vim  plug.vim.old
"   ~/.vim/bundle:
"     git-time-lapse  vim-gitgutter
"   ~/.vim/language:
"     coffeescript-lsp-core
"   ~/.vim/plugged:
"     coc.nvim
"   ~/.vim/syntax:
"     pyopencl.vim

