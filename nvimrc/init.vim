set nocompatible

let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" let g:python_host_prog = '/usr/bin/python'

call plug#begin('~/.config/nvim/plugged')

Plug 'benekastah/neomake'
let g:neomake_python_enabled_makers = ['pylint']
" run neomake on the current file on every write
autocmd! BufWritePost * Neomake

Plug 'davidhalter/jedi-vim'
" Use YCM 
" Disable jedi completions
let g:jedi#completions_enabled = 0 
let g:jedi#show_call_signatures_delay = 200

" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/etc/ycm_extra_conf.py'
let g:ycm_collect_identifiers_from_tag_files = 1
let g:ycm_confirm_extra_conf = 1
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <silent> <Leader>d :YcmCompleter GoToDefinition<cr>
nnoremap <silent> <Leader>g :YcmCompleter GoToDeclaration<cr>
noremap <leader>Y :call YcmAutoTriggerToggle()<cr>
function! YcmAutoTriggerToggle()
  let cur = g:ycm_auto_trigger
  if cur == 0
    let g:ycm_auto_trigger = 1
  else
    let g:ycm_auto_trigger = 0
  endif
endfunction

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-l>"
" 不用YouCompleteMe, 使用SuperTAB
" let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<leader><enter>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
nnoremap <F2> :UltiSnipsEdit<CR>

Plug 'scrooloose/nerdtree'
let NERDTreeWinPos = 1
" nnoremap <silent> <leader><tab> :NERDTreeToggle<CR>
nnoremap <silent> <leader>1 :NERDTreeToggle<CR>

Plug 'majutsushi/tagbar'
nnoremap <silent> <leader>2 :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 33
let g:tagbar_autoshowtag = 1
let tags = "./tags"

Plug 'altercation/vim-colors-solarized'

" vim-airline
Plug 'bling/vim-airline'
set laststatus=2 " show statusline all time
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#fnamemod = ':t' " only show buffer name
let g:airline_theme = "dark"

"easy motion
Plug 'Lokaltog/vim-easymotion'

" neomake
Plug 'benekastah/neomake'

" ag.vim for searching codes
" replaced by fzf.vim Ag command
" Plug 'rking/ag.vim'

Plug 'terryma/vim-multiple-cursors'

Plug 'maksimr/vim-jsbeautify'

Plug 'einars/js-beautify'

Plug 'Chiel92/vim-autoformat'

" for markdown preview
Plug 'shime/vim-livedown'
" sudo npm install -g livedown
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 0
" should the browser window pop-up upon previewing
let g:livedown_open = 1
" the port on which Livedown server will run
let g:livedown_port = 1337
nmap <leader>md :LivedownPreview<CR>

" Enter - Open corresponding file of current line in the window which CtrlSF
" is launched from.
" t - Like Enter but open file in a new tab.
" p - Like Enter but open file in a preview window.
" O - Like Enter but always leave CtrlSF window opening.
" T - Lkie t but focus CtrlSF window instead of new opened tab.
" q - Quit CtrlSF window.
" <C-J> - Move cursor to next match.
" <C-K> - Move cursor to previous match.
Plug 'dyng/ctrlsf.vim'
" ctrlsf mapping
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" gcc gcip
Plug 'vim-scripts/tComment'                          

" :S/note{,s}/entr{y,ies}/g
Plug 'tpope/vim-abolish'                             

" <F5> :GundoToggle
Plug 'sjl/gundo.vim'                                 
" Gundo mapping and settings
nnoremap <F5> :GundoToggle<CR>
let g:gundo_width = 60
let g:gundo_preview_height = 25
let g:gundo_right = 1

" vim-surround
Plug 'tpope/vim-surround'

" for'cpp code format
Plug 'rhysd/vim-clang-format'
" clang-format
let g:clang_format = 'GOOGLE'

" cscope
Plug 'vim-scripts/cscope.vim'
" cscope mappings and settings
let g:cscope_silent = 1
" s: Find this C symbol
nnoremap  <leader>fs :call cscope#find('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call cscope#find('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call cscope#find('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call cscope#find('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call cscope#find('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call cscope#find('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call cscope#find('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call cscope#find('i', expand('<cword>'))<CR>
" cscope mappings and settings end

Plug 'plasticboy/vim-markdown'
nnoremap <leader>tf :TableFormat<CR>

Plug 'benmills/vimux'
" 'benmills/vimux' mappings
" Run the current file with rspec
" map <Leader>rb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>
" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

Plug 'tpope/vim-repeat'

Plug 'vim-scripts/DrawIt'

Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite-outline'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
" - window (nvim only)
let g:fzf_layout = { 'down': '85%' }

" For Commits and BCommits to customize the options used by 'git log':
let g:fzf_commits_log_options = '--decorate --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" Advanced customization using autoload functions
autocmd VimEnter * command! Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'})
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '85%'})

function! s:line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%'
\})

function! s:tags_sink(line)
  let parts = split(a:line, '\t\zs')
  let excmd = matchstr(parts[2:], '^.*\ze;"\t')
  execute 'silent e' parts[1][:-2]
  let [magic, &magic] = [&magic, 0]
  execute excmd
  let &magic = magic
endfunction

function! s:tags()
  if empty(tagfiles())
    echohl WarningMsg
    echom 'Preparing tags'
    echohl None
    call system('ctags -R')
  endif

  call fzf#run({
  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
  \            '| grep -v ^!',
  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
  \ 'down':    '40%',
  \ 'sink':    function('s:tags_sink')})
endfunction

command! Tags call s:tags()

function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
      let maxes[i] = max([get(maxes, i, 0), len(list[i])])
      let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction

function! s:btags_source()
  let lines = map(split(system(printf(
    \ 'ctags -f - --sort=no --excmd=number --language-force=%s %s',
    \ &filetype, expand('%:S'))), "\n"), 'split(v:val, "\t")')
  if v:shell_error
    throw 'failed to extract tags'
  endif
  return map(s:align_lists(lines), 'join(v:val, "\t")')
endfunction

function! s:btags_sink(line)
  execute split(a:line, "\t")[2]
endfunction

function! s:btags()
  try
    call fzf#run({
    \ 'source':  s:btags_source(),
    \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
    \ 'down':    '40%',
    \ 'sink':    function('s:btags_sink')})
  catch
    echohl WarningMsg
    echom v:exception
    echohl None
  endtry
endfunction

" select buffer
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

command! BTags call s:btags()

" 对齐
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

call plug#end()

" fzf的性能比unite.vim要好
nnoremap <silent> <expr> <Leader>f (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>b :Buffers<cr>
nnoremap <silent> <Leader>a :Ag<cr>
nnoremap <silent> <Leader>` :Marks<cr>
nnoremap <leader>m :<c-u>FZFMru<cr>
nnoremap <leader>l :<c-u>FZFLines<cr>
nnoremap <leader>t :<c-u>Tags<cr>
nnoremap <leader>T :<c-u>BTags<cr>
" Open files in horizontal split
nnoremap <silent> <Leader>s :call fzf#run({
\   'down': '40%',
\   'sink': 'botright split' })<CR>

" Open files in vertical horizontal split
nnoremap <silent> <Leader>v :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>

" unite start
let g:unite_source_history_yank_enable = 1
" 虽然file_rec/async性能没有fzf.vim好，但功能多一些，比如mru, outline
" nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
" nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
" nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
" nnoremap <leader>s :<C-u>Unite -buffer-name=grep grep<cr>
" nnoremap <leader>m :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
" Ignore
call unite#custom#source('file_rec/async,file', 'ignore_pattern', 'bower_components\|dist\|fonts\|node_modules\|maps\|\.png$\|\.jpg$\|\.svg$\|\.gif$')
" Configure Ag and use it instead of grep
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
\ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
\  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction
" unite end

" Q: Closes the window
nnoremap Q :q<cr>
" close all windows
nnoremap <leader>Q :qa!<cr>

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set hidden
set wildmenu
set wildmode=longest:full,full
set clipboard+=unnamed

set nofoldenable
set relativenumber
nmap <leader>nn :set relativenumber!<CR>
nmap <leader>N :set number!<CR>

set hlsearch
" Clear the last hlsearch results
nnoremap <F4> :let @/ = ""<CR>
" Combine multi blank lines into one with no highlight
nmap <leader>ll :g/^$/,/./-j<CR><F4><CR>
" Ctrl-r: Easier search and replace
vnoremap <c-r> "hy:%s/<c-r>h//gc<left><left><left>

set incsearch
set ignorecase
set smartcase
set autoindent
set pastetoggle=<F6>
set grepprg=ag
set t_Co=256

let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized

" easy move around windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

" terminal
tnoremap <Esc> <C-\><C-n>
" tnoremap <A-h> <C-\><C-n><C-w>h
" tnoremap <A-j> <C-\><C-n><C-w>j
" tnoremap <A-k> <C-\><C-n><C-w>k
" tnoremap <A-l> <C-\><C-n><C-w>l

" fix neovim <c-h> 产生<BS> 而vim <c-h>产生^H
" 解决方法: https://github.com/neovim/neovim/issues/2048
" 即在iTerm2中，运行
" $ infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
" $ tic $TERM.ti
" if has('nvim')
"   map <BS> <C-W>h
" endif
set timeoutlen=500

" sort
vnoremap <leader>s :sort<cr>

" easy move code blocks
vnoremap < <gv 
vnoremap > >gv 

" ctrl+k ctrl+l dictionary completion
set dictionary+=/usr/share/dict/words

nnoremap <c-e> 3<c-e>
nnoremap <c-y> 3<c-y>
vnoremap <c-e> 3<c-e>
vnoremap <c-y> 3<c-y>

" 单个word加双引号
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
" visually selected加双引号
vnoremap <leader>" :normal! `<i"<esc>`>la"<esc>"

set list listchars=tab:› ,eol:¬
set cursorline
set backspace=indent,eol,start

" Special case: When the cursor is in a word, "cw" and "cW" do not include the
" white space after a word, they only change up to the end of the word.  This is
" because Vim interprets "cw" as change-word, and a word does not include the
" following white space.
" {Vi: "cw" when on a blank followed by other blanks changes only the first
" blank; this is probably a bug, because "dw" deletes all the blanks; use the
" 'w' flag in 'cpoptions' to make it work like Vi anyway}
map cw dwi

"inoremap maps a key combination for insert mode
"<C-e> is the keybinding I am creating.
"<C-o> is a command that switches vim to normal mode for one command.
"$ jumps to the end of the line and we are switched back to insert mode.
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>0

" Navigating in Command Mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>

" Don't update the display while executing macros! speed up! Oh~Oh~
set lazyredraw

" Show the current command in the lower right corner
set showcmd

" When you forgot to open vim with sudo, use w!!
cmap w!! w !sudo tee > /dev/null %

" gui font
set gfn=Monaco:h18

"Insert Mode move word forward and backward
inoremap <c-b> <c-\><c-O>b
inoremap <c-f> <c-\><c-O>w

" Calculate from current line
nnoremap <leader>ca yypkA<Esc>jOscale=2<Esc>:.,+1!bc<CR>kdd

" from hello.vim
" delete current line
map <c-d> dd
" delete current line in Insert Mode
imap <c-d> <esc>ddi

map <c-u> viwU
" convert the current work to uppercase in Insert Mode
imap <c-u> <esc>viwUea

" exit insert mode
inoremap jk <esc>
" disable ESC instead of jk
" inoremap <esc> <nop>

" 更新括号里的内容，非常有用
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>

" disable F1
noremap <F1> <nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

augroup MyAutoCmd
  au!
  filetype on
  autocmd FileType python setlocal ts=4 sts=4 sw=4 et
  " if use YCM comment out one line below
  " autocmd FileType python setlocal completefunc=jedi#completions omnifunc=jedi#completions
  autocmd FileType python noremap <buffer><Leader>cf :Autoformat<CR><CR>

  autocmd FileType c setlocal ts=4 sts=4 sw=4 et
  autocmd FileType cc setlocal ts=2 sts=2 sw=2 et
  autocmd FileType cpp setlocal ts=2 sts=2 sw=2 et
  autocmd FileType shell setlocal ts=4 sts=4 sw=4 et
  autocmd FileType java setlocal ts=4 sts=4 sw=4 et
  autocmd FileType php setlocal ts=4 sts=4 sw=4 et

  autocmd FileType c,cc,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
  autocmd FileType c,cc,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
  autocmd FileType c,cc,cpp,objc setlocal path+=/usr/local/include

  " for html/js/css
  autocmd FileType javascript noremap <buffer>  <Leader>cf :call JsBeautify()<CR>
  " for html
  autocmd FileType html noremap <buffer> <Leader>cf :call HtmlBeautify()<CR>
  " for css or scss
  autocmd FileType css noremap <buffer> <Leader>cf :call CSSBeautify()<CR>

  autocmd FileType vim setlocal ts=2 sts=2 sw=2 et
augroup END

" language runner
function! LangRunner()
  if (&ft == "python")
    nnoremap <leader>R :!python %<cr>
  endif
endfunction

au BufEnter * call LangRunner()

" Mark sure vim returns to the same line when you reopen a file
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"zvzz' |
    \ endif
augroup END
