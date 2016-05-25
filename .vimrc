"=============================================================================
"     FileName: .vimrc
"         Desc: vim setting
"       Author: jysong
"        Email: jiyi@soundlifegroup.com
"     HomePage: http://www.soundlifegroup.cn
"      Version: 0.0.1
"   LastChange: 2015-12-01 21:12:05
"      History:
"=============================================================================
" An example for a vimrc file.一般设置cli相关设置，即命令行相关设置，插件相关设置。原因加载顺序是先读取vimrc配置，然后读取plugin插件，然后加载GUI，最后再读取gvimrc配置文件。所以，GUI以及快捷键一般放到gvimrc里设置，有时候在vimrc设置跟界面显示相关的没作用，要在gvimrc里设置才有用。vimrc配置是vim，gvimrc配置文件是gvim，如果想要vim也有配色等，可以将界面相关的设置放在vimrc文件里重新设置一下。  
   
"-------------------------------------------------------------------------------  
"           基本设置  
"-------------------------------------------------------------------------------  
" When started as "evim", evim.vim will already have done these settings.  
if v:progname =~? "evim"  
  finish  
endif   

"启用Vim的特性，而不是Vi的（必须放到配置的最前边）  
set nocompatible  
  
" 设置编码    
set encoding=utf-8    
"set fenc=utf-8    
set fencs=utf-8,gbk
"set fileencodings=ucs-bom,utf-8,cp936,gb2312,gb18030,big5   
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
   
"显示行号  
set number  
" 高亮显示当前行/列
set cursorline
"set cursorcolumn
  
"设置默认打开窗口大小  
set lines=70 columns=220  
  
"设置窗口透明度  
set transparency=10  
  
"设置背景色  
set bg=dark  
  
"用 koehler 调色板  
colorscheme molokai  
"colorscheme desert
"set background=dark

"隐藏工具栏和滑动条  
set guioptions=aAce      
            
"设置标签栏  
"最多30个标签  
set tabpagemax=30   
"显示标签栏    
set showtabline=2     
set helplang=cn
       
  
"设定文件浏览器目录为当前目录  
set bsdir=buffer  
set autochdir  
  
"总是在窗口右下角显示光标的位置  
set ruler     
      
"在Vim窗口右下角显示未完成的命令   
set showcmd           
  
" 启用鼠标  
if has('mouse')  
  set mouse=a  
endif  
  
"设置语法高亮  
if &t_Co > 2 || has("gui_running")  
syntax on  
endif  
  
  
"-------------------------------------------------------------------------------  
"           文本操作设置  
"-------------------------------------------------------------------------------  
  
"设置按着Command键回车，直接进入下一行"
imap <D-Enter> <ESC>o  
"设置Tab键跟行尾符显示出来  
set list lcs=tab:>-,trail:-  
  
"设置Insert模式和Normal模式下Left和Right箭头键左右移动可以超出当前行  
set whichwrap=b,s,<,>,[,]  
  
"设置光标移动到屏幕之外时，自动向右滚动10个字符  
set sidescroll=10  
  
  
"设置使~命令成为操作符命令，从而使~命令可以跟光标移动命令组合使用  
set tildeop  
  
"定义键映射，不使用Q命令启动Ex模式，令Q命令完成gq命令的功能---即文本格式化。  
map Q gq  
  
" CTRL-U 在Insert模式下可以删除当前光标所在行所在列之前的所有字符.  Insert模式下，在Enter换行之后，可以立即使用CTRL-U命令删除换行符。  
inoremap <C-U> <C-G>u<C-U>  
  
"使 "p" 命令在Visual模式下用拷贝的字符覆盖被选中的字符。  
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>  

"F2键插入当前日期"
imap <F3> <CR>Date: <Esc>:read !date<CR>kJ
map <F3> <CR>Date: <Esc>:read !date<CR>kJ
  
  
"-------------------------------------------------------------------------------
"搜索设置  
"-------------------------------------------------------------------------------  
"设置查找到文件尾部后折返开头或查找到开头后折返尾部。  
set wrapscan  
  
  
"-------------------------------------------------------------------------------  
"           文件设置  
"-------------------------------------------------------------------------------  
  
"设置当Vim覆盖一个文件的时候保持一个备份文件，但vms除外（vms会自动备份。备份文件的名称是在原来的文件名上加上 "~" 字符  
if has("vms")  
  set nobackup         
else  
  set backup          
endif  
  
  
if has("autocmd")  
  "启用文件类型检测并启用文件类型相关插件，不同类型的文件需要不同的插件支持，同时加载缩进设置文件, 用于自动根据语言特点自动缩进.  
  filetype plugin indent on  

  "将下面脚本命令放到自动命令分组里，这样可以很方便地删除这些命令.  
  augroup vimrcEx  
  autocmd!
  "au! "删除原来组的自动命令  

  "对于所有文件类型，设置textwidth为78个字符.  
  autocmd FileType text setlocal textwidth=120  
    
  "//vim启动后自动打开NerdTree  
  autocmd vimenter * NERDTree  
  autocmd vimenter * if !argc() | NERDTree | endif  
  "设置关闭vim NerdTree窗口  
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif  
  
  "当打开编辑文件时总是自动执行该脚本，跳转到最后一个有效的光标位置Mark标记。当一个事件正在处理时，不执行该脚本命令。  
  "行首的反斜杠用于把所有语句连接成一行，避免一行写得太长.   
  autocmd BufReadPost *  
    \ if line("'\"") > 1 && line("'\"") <= line("$") |  
    \   exe "normal! g`\"" |  
    \ endif  
  
  augroup END  
else  
  "Enter换行时总是使用与前一行的缩进等自动缩进。  
  set autoindent  
  "设置智能缩进  
  set smartindent         
endif    
  
  
"编辑一个文件时，你所编辑的内容没保存的情况下，可以把现在的文件内容与编辑之前的文件内容进行对比，不同的内容将高亮显示  
if !exists(":DiffOrig")  
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis  
          \ | wincmd p | diffthis  
endif  
"-------------------------------------------------------------------------------  
"           插件设置  
"-------------------------------------------------------------------------------  
  
"插件相关的设置  
"matchit 的字符匹配自定义设置  
let b:match_words = '\<if\>:\<endif\>,'  
        \ . '\<while\>:\<continue\>:\<break\>:\<endwhile\>'  
  
  
"Vundle 的配置  
  
filetype off                   " required!  
  
set rtp+=~/.vim/bundle/vundle/  
call vundle#rc()  
  
" let Vundle manage Vundle  
" required!   
"管理Vim插件   
Bundle 'gmarik/vundle'   
  
  
" My Bundles here:  
" original repos on github  
"文本按字符对齐  
Bundle 'godlygeek/tabular'  
  
" vim-scripts repos  
"实现“begin”/“end”类似地匹配,~/.vimrc文件中添加自定义的设置：let b:match_words = '\<if\>:\<endif\>,'
"        \ . '\<while\>:\<continue\>:\<break\>:\<endwhile\>'  
Bundle 'matchit.zip'       
Bundle 'moria'  
Bundle 'word_complete.vim'  
Bundle 'SuperTab'  
Bundle 'xptemplate'  
Bundle 'ctags.vim'  
Bundle 'taglist.vim'  
Bundle 'winmanager'  
Bundle 'Command-T'  
"Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-fugitive'
Bundle 'AutoClose'
Bundle 'ZenCoding.vim'
Bundle '_jsbeautify'
Bundle 'EasyMotion'
Bundle 'FencView.vim'
Bundle 'UltiSnips'
Bundle 'Valloric/YouCompleteMe'
Bundle 'klen/python-mode'
Bundle 'davidhalter/jedi-vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'ihacklog/AuthorInfo'
Bundle 'dyng/ctrlsf.vim'
Bundle 'fortyMiles/LineChanger'
  
" non github repos  
"Bundle 'git://git.wincent.com/command-t.git'  
" ...  
Bundle 'https://github.com/scrooloose/nerdtree.git'  
Bundle 'Xuyuanp/nerdtree-git-plugin'
Bundle 'othree/xml.vim'
Bundle 'ianva/vim-youdao-translater'
Bundle 'Mizuchi/STL-Syntax'
Bundle 'suan/vim-instant-markdown'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/syntastic'
   
Bundle 'vim-scripts/a.vim'
Bundle 'kshenoy/vim-signature'

Bundle 'majutsushi/tagbar'

Bundle 'dgryski/vim-godef'
Bundle 'Blackrush/vim-gocode'
Bundle 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'fatih/vim-go'


filetype plugin indent on     " required!  
"  
" Brief help  
" :BundleList          - list configured bundles  
" :BundleInstall(!)    - install(update) bundles  
" :BundleSearch(!) foo - search(or refresh cache first) for foo  
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles  
"  
" see :h vundle for more details or wiki for FAQ  
" NOTE: comments after Bundle command are not allowed.. 
"
" Powerline setup

""-----------------------"NERDTreesetting" --------------------------------""
map <F2> :NERDTreeToggle<CR>
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "~",
    \ "Renamed"   : ">",
    \ "Unmerged"  : "-",
    \ "Deleted"   : "x",
    \ "Dirty"     : "!",
    \ "Clean"     : "0",
    \ "Unknown"   : "?"
    \ }

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
augroup nerdtree_autocmds
    autocmd!

    au VimEnter * call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
    au VimEnter * call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
    au VimEnter * call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
    au VimEnter * call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
    au VimEnter * call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
    au VimEnter * call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
    au VimEnter * call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
    au VimEnter * call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
    au VimEnter * call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
    au VimEnter * call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
    au VimEnter * call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
    au VimEnter * call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
    au VimEnter * call NERDTreeHighlightFile('rb', 'Red', 'none', '#ffa500', '#151515')
    au VimEnter * call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
    au VimEnter * call NERDTreeHighlightFile('py', 'Magenta', 'none', '#ff00ff', '#151515')
augroup END

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let NERDTreeIgnore = ['\.pyc$', '__pycache__', '*\~']

""-----------------------------------------------------------------------------------------""
" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

" support python3"
"let g:pymode_python = 'python3'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pylink', 'pep8']

" Auto check on save
let g:pymode_lint_write = 1
let g:pymode_lint_message = 1

    "highlight characters past column 120
" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_syntax_highlight_self = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 1

"Set max line length
let g:pymode_options_max_line_length = 120

"
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
augroup END

"================================================================================"
""===>edit .vimrc  auto open new tab

function! MySys()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfunction

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
elseif MySys() == 'windows'
    " Set helplang
    set helplang=cn
    "Fast reloading of the _vimrc
    map <silent> <leader>ss :source ~/_vimrc<cr>
    "Fast editing of _vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
    "When _vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source ~/_vimrc
endif

" For windows version
if MySys() == 'windows'
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif 
"--------------------------------------------------------------------------------"

"================================================================================"
""====> AuthorInfo setting

let g:vimrc_author='jysong'
let g:vimrc_email='jiyi@soundlifegroup.com'
let g:vimrc_homepage='http://www.soundlifegroup.com'

nmap <F4> :AuthorInfoDetect<cr>
"--------------------------------------------------------------------------------"


"================================================================================"
""====> ConqueTerm setting

map <F10> :ConqueTermSplit bash<cr>

let g:ConqueTerm_Color = 2
let g:ConqueTerm_InsertOnEnter = 0
"--------------------------------------------------------------------------------"


"================================================================================"
""====>vim-youdao-translater

vnoremap <silent> <C-T> <Esc>:Ydv<CR>
nnoremap <silent> <C-T> <Esc>:Ydc<CR>
noremap <leader>yd :Yde<CR>
"--------------------------------------------------------------------------------"


"================================================================================"
"=====>Powerline"

let g:Powerline_colorscheme='solarized256'
"--------------------------------------------------------------------------------"

"================================================================================"
"=====> vim-indent-guides"
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
nmap <silent> <Leader>i <Plug>IndentGuidesToggle

"================================================================================"
"======> "

" 设置显示／隐藏标签列表子窗口的快捷键。速记：tag list 
nnoremap <F9> :TagbarToggle<CR> 
" 设置标签子窗口的宽度 
let tagbar_width=32
" tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=1
" 设置 ctags 对哪些代码元素生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
        \ 'd:macros:1',
        \ 'g:enums',
        \ 't:typedefs:0:0',
        \ 'e:enumerators:0:0',
        \ 'n:namespaces',
        \ 'c:classes',
        \ 's:structs',
        \ 'u:unions',
        \ 'f:functions',
        \ 'm:members:0:0',
        \ 'v:global:0:0',
        \ 'x:external:0:0',
        \ 'l:local:0:0'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


"--------------------------------------------------------------------------------"
"======> go setting
autocmd BufWritePre *.go :Fmt

"Run commands such as go run for the current file with <leader>r or go build and go test for the current package with <leader>b and <leader>t respectively.
"Display beautifully annotated source code to see which functions are covered with <leader>c.
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap <Leader>s <Plug>(go-implements)

au FileType go nmap <Leader>e <Plug>(go-rename)

"By default syntax-highlighting for Functions, Methods and Structs is disabled. To change it:"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"Enable goimports to automatically insert import paths instead of gofmt:"
let g:go_fmt_command = "goimports"

"By default vim-go shows errors for the fmt command, to disable it:"
let g:go_fmt_fail_silently = 1


"--------------------------------------------------------------------------------"
"======> syntastic setting
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:ycm_show_diagnostics_ui = 0
let g:syntastic_python_checkers = ['pylint']
"let g:syntastic_mode_map = {
"    \ "mode": "active",
"    \ "passive_filetypes": ["python"] }
