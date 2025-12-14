"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This vimrc is based on the vimrc by https://blog.csdn.net/Guet_Kite/
" You can find the latest version on:
"       https://github.com/Guet-Bantao/vim_config
"
" Maintainer:Bantao
" Version: 5.0
" Last Change: 2025/11/24 09:17:57
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
" 配色主题
Plug 'tomasiser/vim-code-dark'
" Plug 'liuchengxu/space-vim-theme'
Plug 'vim-airline/vim-airline'
" gutentags 基础插件
Plug 'ludovicchabant/vim-gutentags'
" gutentags_plus 增强 gtags 支持
Plug 'skywind3000/gutentags_plus'
if system('ctags --version 2>/dev/null') =~# 'Universal Ctags'
    Plug 'liuchengxu/vista.vim', { 'on': ['Vista', 'Vista!!'] }
    let g:use_universal_ctags = 1
else
    Plug 'preservim/tagbar'
    let g:use_universal_ctags = 0
endif
" 依赖 apt install ranger
Plug 'francoiscabrol/ranger.vim'
if v:version > 704 || v:version == 704 && has("patch330") == 1
    " 快速的模糊查找插件
    Plug 'Yggdroot/LeaderF'
    nmap <C-p> : LeaderfFile <cr>
else
    " 兼容性好的模糊查找插件
    Plug 'kien/ctrlp.vim' "兼容性好的模糊查找插件
    Plug 'FelikZ/ctrlp-py-matcher'
endif
" 缓存buf窗口管理
Plug 'jlanzarotta/bufexplorer'
" 窗口管理
Plug 'vim-scripts/winmanager'
" 快速代码注释
Plug 'tpope/vim-commentary'
" 彩色括号
Plug 'luochen1990/rainbow'
" 括号匹配增强
Plug 'andymass/vim-matchup'
" 代码对齐
Plug 'godlygeek/tabular'
" git修改通知
Plug 'mhinz/vim-signify'
"替换引擎，需搭配补全规则
Plug 'SirVer/ultisnips'
"补全片段规则
Plug 'honza/vim-snippets'
" YouCompleteMe
" Plug 'ycm-core/YouCompleteMe'
" 高亮尾部空格
Plug 'bronson/vim-trailing-whitespace'
" 实时代码格式化
Plug 'skywind3000/vim-rt-format'
" 超轻量级代码补全系统
Plug 'skywind3000/vim-auto-popmenu'
" Plug 'skywind3000/vim-preview'
" git信息管理
Plug 'rhysd/git-messenger.vim'
call plug#end()



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set encoding=utf-8
set langmenu=zh_CN.UTF-8
" language message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,gb18030,cp936,big5,euc-jp,euc-kr,latin1
set fenc=utf-8      "编码文件
" Set mapleader
let mapleader="\<Space>"
let g:mapleader = "\<Space>"


"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"Set to auto read when a file is changed from the outside
set autoread

"save last time you write place
autocmd BufReadPost *
      \ if line("'\"")>0&&line("'\"")<=line("$") |
      \exe "normal g'\"" |
      \ endif

" Fast saving
nmap <silent> <leader>ww :w<cr>
nmap <silent> <leader>wf :w!<cr>

" Fast quiting
nmap <silent> <leader>wq :wq<cr>
nmap <silent> <leader>qf :q!<cr>
nmap <silent> <leader>qq :q<cr>
nmap <silent> <leader>qa :qa<cr>

" 插入模式 Backspace
set backspace=eol,start,indent

" Show line number
set nu

" 光标跨行移动
set whichwrap+=<,>,h,l

" 搜索忽略大小写，输入大写字母自动区分
set ignorecase
set smartcase
" 增量搜索
set incsearch
" Highlight search things
set hlsearch
"Fast remove highlight search
nmap <silent> <leader><cr> :noh<cr>

""""""""""""""""""""""""""""""
" Indent
""""""""""""""""""""""""""""""
" Auto indent
set autoindent
" C-style indeting
set cindent
" Wrap lines
set wrap

set expandtab          " 按 Tab 键时插入空格而不是 \t
set shiftwidth=4       " >> << 缩进时移动 4 个空格
set tabstop=4          " 文件中真实的 \t 显示宽度为 4
set softtabstop=4      " 插入模式按 Tab 插入 4 个空格
set list
set listchars=tab:▸\ ,trail:·,extends:>,precedes:<,nbsp:+ " 显示不可见字符
" autocmd BufWritePre *.c,*.cpp,*.py,*.vim :%s/\s\+$//e " 保存时自动删除尾部空格

set nobackup	" no backup files
set nowb	" only in case you don't want a backup file while editing
set noswapfile	" no swap files
"Set to auto read when a file is changed from the outside
set autoread
" 自动切换工作目录
" 如果你用项目管理插件（如 vim-projectionist 或 LeaderF），可能会干扰根目录切换
set autochdir

" 命令行补全增强
set wildmenu
" 命令行高度
set cmdheight=2

nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

set mouse+=a

set magic
set completeopt=menu,menuone,noselect

" No sound on errors.
set noerrorbells
set novisualbell

" nnoremap <F10> :set invnumber<CR>:Vista!!<CR>:set mouse=<CR>:set invlist<CR>
nnoremap <F10> :set invnumber<CR>:silent! Vista!!<CR>:if &mouse=='' \| set mouse=a \| else \| set mouse= \| endif<CR>:set invlist<CR>




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" startify setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:startify_custom_header = [
            \ '+--------------------------------------------------------+',
            \ '     _     _       _     _    __     ___                 |',
            \ '    | |   (_) __ _| |__ | |_  \ \   / (_)_ __ ___        |',
            \ '    | |   | |/ _` |  _ \| __|  \ \ / /| |  _ ` _ \       |',
            \ '    | |___| | (_| | | | | |_    \ V / | | | | | | |      |',
            \ '    |_____|_|\__, |_| |_|\__|    \_/  |_|_| |_| |_|      |',
            \ '             |___/                                       |',
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
" vim-airline setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 启用状态栏
set laststatus=2
let g:airline_extensions = ['tabline']

" airline 基础启用（默认自动启用）
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#fnamemod = ':p:.' "相对路径
let g:airline#extensions#tabline#fnamecollapse = 1 "折叠过长路径


let g:airline_section_c = '%{fnamemodify(bufname(""), ":p:~")}' "文件绝对路径
let g:airline_section_b = '' " git信息
let g:airline_section_x = '' " tagbar, filetype, virtualenv 函数名
let g:airline_section_error = '' "ycm error message
let g:airline_section_warning = '' " ycm warning message

set numberwidth=1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

colorscheme codedark
set t_Co=256
set t_ut=
set cursorline
" syntax on
" set termguicolors

" colorscheme space_vim_theme
" set background=dark
" set termguicolors
" hi LineNr ctermbg=NONE guibg=NONE

" hilight function name
autocmd BufNewFile,BufRead * syntax match cFunction "\<[a-zA-Z_][a-zA-Z_0-9]*\>\ze\s*("
" 类/结构名（C++ 的 XXX::）
autocmd BufNewFile,BufRead * syntax match cClass "\<[a-zA-Z_][a-zA-Z_0-9]*\>\ze::"
" -----------------------------
" 高亮颜色设置
" -----------------------------
" 函数名：绿色偏蓝
hi cFunction guifg=#7fd02e cterm=bold ctermfg=80
" 类名：偏绿
hi cClass guifg=#4EC9B0 ctermfg=37 cterm=bold
" 条件关键字（if, else, for, while 等）
hi Conditional guifg=#f92672 cterm=bold ctermfg=197
hi Repeat guifg=#f92672 cterm=bold ctermfg=197
" 注释：灰色
hi Comment guifg=#75715e ctermfg=242 gui=NONE cterm=NONE
" 搜索高亮：黄色背景
hi Search term=standout guibg=#ffff00 ctermbg=3 ctermfg=0

" hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE "光标行
" hi ColorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
" hi LineNr ctermfg=102 ctermbg=237 cterm=NONE guifg=#90908a guibg=#3c3d37 gui=NONE "行号
" hi VertSplit ctermfg=241 ctermbg=241 cterm=NONE guifg=#64645e guibg=#64645e gui=NONE "分隔线
" hi VertSplit ctermfg=08 ctermbg=233 cterm=NONE guifg=##444444 guibg=##444444 gui=NONE "分隔线
" hi StatusLine ctermfg=231 ctermbg=241 cterm=bold guifg=#f8f8f2 guibg=#64645e gui=bold
" hi StatusLineNC ctermfg=231 ctermbg=241 cterm=NONE guifg=#f8f8f2 guibg=#64645e gui=NONE


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gutentags 基础配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gutentags_enabled = 1
let g:gutentags_ctags_executable = 'ctags'
let g:gutentags_project_root = ['.git', '.hg', '.svn', '.root']
let g:gutentags_update_on_write = 1
" 指定一些项目根目录不生成 tags/gtags
let g:gutentags_exclude_project_root = ['.git', 'node_modules', 'build', 'temp', 'output']
" 忽略的目录和文件
let g:gutentags_ctags_exclude = [
    \ 'build', 'bin', 'obj', '.git', '.svn', 'node_modules', 'output', 'out']
" 强制 <C-]> 使用 ctags，不使用 cscope
nnoremap <C-]> g<C-]>
nnoremap <C-LeftMouse> g<C-]>

" gtags-cscope job failed 删除错误G๎TAGS重新生成
let g:gutentags_force_gtags_update_when_fail = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gutentags_plus 配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 如果你只想用 gtags，可以写成
" let g:gutentags_modules = ['gtags_cscope']

" 设置 gtags 扫描深度（可选）
let g:gutentags_plus_gtags_exclude_dir = ['.git', 'node_modules', 'build']

" 所生成的数据文件的名称
" let g:gutentags_ctags_tagfile = '.tags'

" 自动更新 gtags
let g:gutentags_plus_gtags_auto_update = 1

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

if g:use_universal_ctags
" 如果使用 universal ctags 需要增加下面，老的 Exuberant-ctags 不能加
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
let g:gutentags_ctags_extra_args += ['--extras=+q']
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tagbar显示tag函数
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !g:use_universal_ctags

" 指向 universal-ctags（保证支持 C++11/14/17）
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_left = 1
let g:tagbar_width = 25
let g:tagbar_autofocus = 0
" 自动打开 Tagbar 当打开 C/C++ 文件
autocmd BufReadPost *c,*.cpp,*.h TagbarOpen

" C++ 额外选项
let g:tagbar_type_cpp = {
    \ 'ctagsbin'  : 'ctags',
    \ 'ctagsargs' : '--c++-kinds=+p --fields=+iaS --extra=+q',
    \ 'sort'      : 0
\ }

" 打开/关闭 Tagbar 快捷键
nnoremap <F7> :TagbarToggle<CR>

set tags=./tags;

endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vista.vim 配置示例
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if g:use_universal_ctags
" 将 Vista 侧边栏放在左侧
let g:vista_sidebar_position = 'vertical topleft'
let g:vista_sidebar_width = 25

" 当打开 c/c++/h/hpp 文件时自动打开 Vista
autocmd BufReadPost,BufNewFile *.c,*.cpp,*.cc,*.h,*.hpp Vista

" 打开后不自动聚焦侧边栏
let g:vista_stay_on_open = 0

" 默认使用 ctags 或 LSP
let g:vista_default_executive = 'ctags'

" 启用悬浮窗预览
if v:version > 802
  let g:vista_echo_cursor_strategy ='floating_win'
endif

" 关闭vista底部状态栏
let g:vista_disable_statusline = 1

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

" set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

function! s:CloseVista()
" 当窗口数量 <= 1 时关闭 Vista
    if winnr('$') == 1
        if bufwinnr('__vista__') != -1
            execute 'q'
        endif
    endif
endfunction
" 每次 bufenter 触发
autocmd BufEnter * call s:CloseVista()

nnoremap <F7> :Vista!!<CR>

endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ranger文件管理
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ranger')
    let g:ranger_map_keys = 0   " 不自动抢快捷键
    nmap <silent> <F2> :Ranger<CR>
else
    let g:netrw_winsize = 45
    nmap <silent> <leader>fe :Sexplore!<cr>
    nmap <silent> <F2> :Sexplore!<cr>
endif


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
let g:Lf_Gtags = "/usr/bin/gtags"
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_ShowRelativePath = 1 " Whether to show the relative path
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_ReverseOrder = 1

" 检查 'rg' (ripgrep) 命令是否存在
if executable('rg')
    nnoremap <Leader>g :Leaderf rg <C-R><C-W>
endif

let g:Lf_PreviewInPopup = 1
" let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

" if use https://github.com/ludovicchabant/vim-gutentags to generate gtags:
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_GtagsGutentags = 1

let g:Lf_RgConfig = [
        \ '--type-add "web:*.{html,css,js}*"',
        \ "--glob=!git/*",
        \ "--glob=!tags",
        \ "--glob=!*.temp",
        \ "--glob=!*.tmp",
        \ "--glob=!*.o"
        \ ]

" 当在 quickfix 窗口里按回车跳转时自动关闭窗口
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>


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
" winmanager setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:winManagerWidth = 23
" let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
let g:winManagerWindowLayout = "FileExplorer|TagList"
let g:defaultExplorer = 1
let g:persistentBehaviour=1  "winmanager的窗口是最后一个窗口时，退出VIM
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
let g:AutoOpenWinManager = 0
nmap <silent> <leader>wm :WMToggle<cr>
autocmd BufWinEnter \[Buf\ List\] setl nonumber
nmap <silent> <F8> :WMToggle<cr>


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
" vim-matchup setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:matchup_matchparen_offscreen = {'method': 'popup'}
let g:matchup_matchparen_deferred = 1
let g:matchup_motion_override = 1
let g:matchup_text_obj_enabled = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabular setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-signify setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:signify_sign_add = '+'
let g:signify_sign_delete = '-'
let g:signify_sign_change = '~'

" vim-signify 左侧标记颜色
highlight SignifySignAdd    ctermfg=2  guifg=#00ff00
highlight SignifySignChange ctermfg=3  guifg=#ffff00
highlight SignifySignDelete ctermfg=1  guifg=#ff0000


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-rt-format setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 默认在 INSERT 模式下按 ENTER 格式化当前代码行，将下面设置
" 成 1 的话，可以用 CTRL+ENTER 来格式化，ENTER 将保留原来的功能
let g:rtf_ctrl_enter = 0

" 离开 INSERT 模式的时候再格式化一次
let g:rtf_on_insert_leave = 1

let g:rtformat_auto = 1
" 当打开 c/c++/h/hpp 文件时自动打开 RTF
" autocmd BufReadPost,BufNewFile *.c,*.cpp,*.cc,*.h,*.hpp RTFormatEnable


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-auto-popmenu setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cr与rt-format冲突
let g:apc_cr_confirm = 1
" 设定需要生效的文件类型，如果是 "*" 的话，代表所有类型
let g:apc_enable_ft = {'text':1, 'markdown':1, 'php':1, 'c':1, 'cpp':1, 'h':1}
let g:apc_min_length = 3
let g:apc_enable_tab = get(g:, 'apc_enable_tab', 0)   " not remap tab


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" git-messenger.vim setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:git_messenger_floating_win_border = 'single'
" none:简略 current:当前差异 all:全部差异
" let g:git_messenger_include_diff = "current"
