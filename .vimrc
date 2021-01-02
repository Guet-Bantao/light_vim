"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This vimrc is based on the vimrc by Amix - http://amix.dk/
" You can find the latest version on:
"       http://blog.csdn.net/easwy
"
" Maintainer:Bantao
" Version: 4.0
" Last Change: 2020/12/14 09:17:57
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..
set nocompatible

" Platform
function! MySys()
   return "linux"
endfunction

" Chinese
if MySys() == "windows"
   "set encoding=utf-8
   "set langmenu=zh_CN.UTF-8
   "language message zh_CN.UTF-8
   "set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plugged
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
if v:version > 704 || v:version == 704 && has("patch330") == 1
Plug 'Yggdroot/LeaderF' "快速的模糊查找插件
nmap <C-p> : LeaderfFile <cr>
else
Plug 'kien/ctrlp.vim' "兼容性好的模糊查找插件
Plug 'FelikZ/ctrlp-py-matcher'
endif
if (has('job') || (has('nvim') && exists('*jobwait')))
Plug 'ludovicchabant/vim-gutentags' "异步自动更新tag
endif
Plug 'mhinz/vim-startify' "优化显示界面
Plug 'junegunn/vim-easy-align'
Plug 'luochen1990/rainbow' "彩虹括号
Plug 'tpope/vim-commentary' "快速注释
Plug 'vim-scripts/global-6.6.4' "gtags引用跳转
Plug 'SirVer/ultisnips' "替换引擎，需搭配补全规则
Plug 'honza/vim-snippets' "补全片段规则
Plug 'tomasiser/vim-code-dark'
call plug#end()

set clipboard=unnamed " 共享外部剪贴板
set clipboard+=exclude:.* "
set clipboard=autoselect,exclude:.* "vim剪切板会拖慢2s启动时间，不需要可关闭(放开注释即可),会导致剪切板不可用

"Set mapleader
let mapleader="\<Space>"
let g:mapleader = "\<Space>"


" Switch to buffer according to file name
function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction

"Fast edit vimrc
if MySys() == 'linux'
    "Fast reloading of the .vimrc
    map <silent> <leader>ss :source ~/.vimrc<cr>
    "Fast editing of .vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme elflord
colorscheme codedark
set t_Co=256
set cursorline
syntax enable
syntax on

" hilight function name
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
hi cFunctions guifg=#7fd02e cterm=bold ctermfg=80 "函数蓝色80

syn match cClass "\<[a-zA-Z_][a-zA-Z_0-9]*\>::"me=e-2
hi cClass guifg=#7fd02e cterm=bold ctermfg=yellow

hi Search term=standout ctermfg=0 ctermbg=3 "搜索黄色3
hi Comment ctermfg=242 ctermbg=NONE cterm=NONE guifg=#75715e guibg=NONE gui=NONE "注释
hi Conditional ctermfg=197 ctermbg=NONE cterm=NONE guifg=#f92672 guibg=NONE gui=NONE "条件
" hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE "光标行
" hi ColorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
" hi LineNr ctermfg=102 ctermbg=237 cterm=NONE guifg=#90908a guibg=#3c3d37 gui=NONE "行号
" " hi VertSplit ctermfg=241 ctermbg=241 cterm=NONE guifg=#64645e guibg=#64645e gui=NONE "分隔线
" hi VertSplit ctermfg=08 ctermbg=233 cterm=NONE guifg=##444444 guibg=##444444 gui=NONE "分隔线
" hi StatusLine ctermfg=231 ctermbg=241 cterm=bold guifg=#f8f8f2 guibg=#64645e gui=bold
" hi StatusLineNC ctermfg=231 ctermbg=241 cterm=NONE guifg=#f8f8f2 guibg=#64645e gui=NONE

if &diff
  syntax off
  " colorscheme desert
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set sessionoptions-=curdir
set sessionoptions+=sesdir

function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup	" no backup files
set nowb	" only in case you don't want a backup file while editing
"set noswapfile	" no swap files

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

au FileType html,python,vim,javascript setl shiftwidth=2
"au FileType html,python,vim,javascript setl tabstop=2
au FileType java setl shiftwidth=4
"au FileType java setl tabstop=4
au FileType txt setl lbr
au FileType txt setl tw=78

"Fast saving
nmap <silent> <leader>ww :w<cr>
nmap <silent> <leader>wf :w!<cr>

"Fast quiting
nmap <silent> <leader>wq :wq<cr>
nmap <silent> <leader>qf :q!<cr>
nmap <silent> <leader>qq :q<cr>
nmap <silent> <leader>qa :qa<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable filetype plugin自动补全
filetype plugin on
filetype indent on

"Set to auto read when a file is changed from the outside
set autoread

"save last time you write place
autocmd BufReadPost *
      \ if line("'\"")>0&&line("'\"")<=line("$") |
      \exe "normal g'\"" |
      \ endif

set noexpandtab
set shiftwidth=8
set tabstop=8
set softtabstop=8
"set listchars=tab:>-,trail:-
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

"Fast remove highlight search
nmap <silent> <leader><cr> :noh<cr>

""""""""""""""""""""""""""""""
" Delete space and ^M
""""""""""""""""""""""""""""""
"Remove indenting on empty lines
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  nohl
  exe "normal `z"
endfunc
" do not automaticlly remove trailing whitespace
" autocmd BufWrite *.[ch] :call DeleteTrailingWS()
" autocmd BufWrite *.cc :call DeleteTrailingWS()
" autocmd BufWrite *.txt :call DeleteTrailingWS()
nmap <silent> <leader>ds :call DeleteTrailingWS()<cr>:w<cr>
nmap <silent> <leader>ds! :call DeleteTrailingWS()<cr>:w!<cr>
"Remove the Windows ^M
noremap <Leader>dm mmHmn:%s/<C-V><cr>//ge<cr>'nzt'm

""""""""""""""""""""""""""""""
" Fast grep
""""""""""""""""""""""""""""""
function! s:GetVisualSelection()
   let save_a = @a
   silent normal! gv"ay
   let v = @a
   let @a = save_a
   let var = escape(v, '\\/.$*')
   return var
endfunction
nmap <silent> <leader>g :lv /<c-r>=expand("<cword>")<cr>/ %<cr>:lw<cr>
vmap <silent> <leader>g :lv /<c-r>=<sid>GetVisualSelection()<cr>/ %<cr>:lw<cr>

""""""""""""""""""""""""""""""
" Folding
""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
"set fen
"set fdl=0
nmap <silent> <leader>zo zO
vmap <silent> <leader>zo zO


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Complete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" options
set completeopt=menu
set complete-=u
set complete-=i

" Enable syntax
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
        \if &omnifunc == "" |
        \  setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
  if MySys() == "linux"
    set csprg=/usr/bin/cscope
  else
    set csprg=cscope
  endif
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  "cs add /home/bantao/kernel/linux-4.9/cscope.out /home/bantao/kernel/linux-4.9
  set csverb
endif

"查找C语言符号，即查找函数名、宏、枚举值等出现的地方
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
"查找调用本函数的函数
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
"查找指定的字符串
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
"查找egrep模式，相当于egrep功能，但查找速度快多了
nmap  <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"查找本文件，类似vim的find功能
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"查找包含本文件的文件
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"查找本函数调用的函数
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

nmap <C-LeftMouse> :tag <C-R>=expand("<cword>")<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctag setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set tags=/home/bantao/kernel/linux-4.9/tags;
set tags=tags;
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gtag setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('gtags-cscope') && executable('gtags')
    let gtags_file=findfile("GTAGS", ";")
    if !empty(gtags_file)
        set cscopetag " 使用 cscope 作为 tags 命令
	set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope
	let GtagsCscope_Auto_Load = 1
	let CtagsCscope_Auto_Map = 1
	let GtagsCscope_Quiet = 1
    endif
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bufexplorer setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=1       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=0  " Open in new window.
let g:bufExplorerMaxHeight=30        " Max height
let g:bufExplorerDisableDefaultKeyMapping =1 " Do not disable default key mappings.
autocmd BufWinEnter \[Buf\ List\] setl nonumber
nnoremap <silent> <F9> :BufExplorer<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" taglist setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if MySys() == "windows"
    let Tlist_Ctags_Cmd = 'ctags'
elseif MySys() == "linux"
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
"let Tlist_Use_Right_Window = 1
let Tlist_Process_File_Always=1
let Tlist_Auto_Open = 1
let g:Tlist_WinWidth=28
let g:Tlist_GainFocus_On_ToggleOpen = 0
nmap <silent> <F7> :Tlist<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" winmanager setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:winManagerWindowLayout='FileExplorer'
let g:winManagerWidth = 23
"let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
let g:winManagerWindowLayout = "BufExplorer|FileExplorer"
let g:defaultExplorer = 1
let g:persistentBehaviour=1  "winmanager的窗口是最后一个窗口时，退出VIM
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
let g:AutoOpenWinManager = 0
nmap <silent> <leader>wm :WMToggle<cr>
autocmd BufWinEnter \[Buf\ List\] setl nonumber
nmap <silent> <F8> :WMToggle<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" netrw setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_winsize = 45
nmap <silent> <leader>fe :Sexplore!<cr>
nmap <silent> <F2> :Sexplore!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlp setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_max_depth = 100000
let g:ctrlp_max_files = 100000
" let g:ctrlp_root_markers = {'.root'}"如果默认文件标记（.git .hg .svn .bzr
" _darcs）都不在项目里，你可以用g:ctrlp_root_markers添加进去
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*ko     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leaderf setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_ShowRelativePath = 1 " Whether to show the relative path
let g:Lf_StlColorscheme = 'powerline'
" let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
let g:Lf_ReverseOrder = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
"Always hide the statusline
set laststatus=2
let g:bufferline_show_bufnr = 1
let g:airline#extensions#tabline#fnamemod = ':p:t' " 只显示文件名，不显示路径内容


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rainbow setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
      \ 'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
      \ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
      \ 'operators': '_,_',
      \ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
      \ 'separately': {
      \         '*': {},
      \         'tex': {
      \                 'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
      \         },
      \         'lisp': {
      \                 'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
      \         },
      \         'vim': {
      \                 'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
      \         },
      \         'html': {
      \                 'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
      \         },
      \         'css': 0,
      \ }
      \}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" startify setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:startify_custom_header = [
           \ '+--------------------------------------------------------+',
	   \ '   __      ___              _  _______     _________     |',
           \ '   \ \    / (_)            | | | |____ \  | |_______|    |',
           \ '    \ \  / / _ _ __ ___    | | | |    | \ | |_______     |',
           \ '     \ \/ / | | `_ ` _ \   | | | |    | | | |_______|    |',
           \ '      \  /  | | | | | | |  | | | |____| | | |_______     |',
           \ '       \/   |_|_| |_| |_|  |_| |_|_____/  |_|_______|    |',
           \ '                                                         |',
           \ '            o                                            |',
           \ '             o    ^____^                                 |',
           \ '              o  （o o）\___________                     |',
           \ '                 （___）\           ）\/\                |',
           \ '                        ||________w |                    |',
           \ '                        ||         ||                    |',
           \ '+--------------------------------------------------------+',
           \]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ultisnips setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger = "<tab>" "用<tab>展开片段代码
let g:UltiSnipsListSnippets = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>" "用<tab>跳到下一个位置
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>" "用shift+<tab>跳到上一个位置


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LaTeX Suite things
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set grepprg=grep\ -nH\ $*
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_ViewRule_pdf='xpdf'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
"set so=7

"Have the mouse enabled all the time:
set mouse+=v
set mouse+=a

set autochdir

"Sets how many lines of history VIM har to remember
set history=400

"Turn on WiLd menu
set wildmenu

"The commandbar is 2 high
set cmdheight=2

"Show line number
set nu

"Show the colorcolumn
" set cc=80	" vim中对80字符的限制提示

"Change buffer - without saving
"set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>

"Ignore case when searching不区分大小写
"set ignorecase

"Include search
set incsearch

"Highlight search things
set hlsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
"set showmatch

set smarttab
"set lbr
"set tw=78

""""""""""""""""""""""""""""""
" Indent
""""""""""""""""""""""""""""""
"Auto indent
set ai

"Smart indet
set si

"C-style indeting
set cindent

"Wrap lines
set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast diff
cmap @vd vertical diffsplit
set diffopt+=vertical

autocmd FileType c,cpp  map <buffer> <leader><space> :make<cr>
"Super paste
inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>
"Super select all
nmap <C-a> ggVGY

"Fast Ex command
nnoremap ; :

"Smart way to move btw. windows
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l
nmap <TAB> :bn<cr>

autocmd BufEnter * :syntax sync fromstart

