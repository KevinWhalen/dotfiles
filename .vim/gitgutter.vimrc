" https://github.com/airblade/vim-gitgutter/

" Color stuff because I like the light text colors on the dark background.

highlight SignColumn guibg=black ctermbg=black

highlight GitGutterAdd guifg=green guibg=black ctermfg=green ctermbg=black
highlight GitGutterChange guifg=yellow guibg=black ctermfg=yellow ctermbg=black cterm=bold
highlight GitGutterDelete guifg=red guibg=black ctermfg=red ctermbg=black

" Override default maximum lines for gutter edit signs (500).
let g:gitgutter_max_signs = 2000

" Call on file write because it does not trigger correctly after a commit.
autocmd BufWritePost * GitGutter

