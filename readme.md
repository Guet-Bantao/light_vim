|  plugin  | description  |
|  ----  | ----  |
| a.vim  | c文件和h文件快速切换 |
| airline.vim  | 增强vim底部状态栏显示 |
| autoload_cscope.vim   | 自动加载cscope |
| bufexplorer.vim  | 可以打开历史文件列表 |
| comment.vim  | 快速注释代码 |
| ctrlp.vim  | 兼容性很好的模糊搜索插件 |
| rainbow_main.vim  | 彩虹插件，给括号配彩虹色 |
| taglist.vim  | 显示出tags列表 |
| winmanager.vim | 多窗口管理 |



<center><b> Light_VIM简易使用说明 </b></center>

进入项目根目录，执行：
ctags -R `pwd`
find `pwd` -name "*.c"  -o -name "*.c" -o -name "*.cpp" > cscope.files  
cscope -bR -i cscope.files 
以上命令也可以通过直接执行source ~/.vim/buildenv.sh脚本执行
此配置安装了插件并设置了自动递归查找索引文件，会自动加载cscope.out 和 tags

//注：<Ctrl+v>代表Ctrl和v键一起按；<Ctrl>+v代表先按Ctrl键松开之后按v键

F2：屏幕双开打开文件并浏览（同理，可在命令模式下输入:fe实现）
F3：快速粘贴（本设置支持<Ctrl+v>粘贴）
F4：查看文件修改内容（同理，可在命令模式下输入changes实现）
F7：打开\关闭左侧Taglist窗口
F8：打开\关闭右侧winmanage窗口
F9：打开BufExplorer，历史文件列表

<Ctrl+w+w>：切换Taglist和显示区域等多个窗口
<shift+3> ：向前实现快速查找并高亮显示某个单词
<shift+8> ：向后实现快速查找并高亮显示某个单词

<Ctrl+a>：实现全选并复制功能
<Ctrl+v>：实现快速粘贴

<空格>+f：快速搜索当前文件里出现某个单词的位置并小窗口预览（v键可选择单词）。
<空格>+ww：保存
<空格>+wq：保存退出
<空格>+wf：强制保存
<空格>+qf：强制退出
<空格>+qq：退出
<空格>+ds：自动删除尾随空格
<空格>+dm：自动删除尾随^M
<空格>+fe：打开一个垂直分隔的窗口浏览当前文件所在的目录

<Ctrl+]>：跳转到函数、宏、枚举等定义的位置（本设置支持<Ctrl+鼠标左键>跳转，同理，可在命令模式下输入tag 函数\变量名）
<CTRL+W+]>：分隔当前窗口并跳转到光标下的tag
<Ctrl+T>：返回上一次跳转的位置
<Ctrl+\>+g：查找函数、宏、枚举等定义的位置，类似ctags所提供的功能（比如有可能只在头文件处）
<Ctrl+\>+s：查找C语言符号，即查找函数名、宏、枚举值等出现的地方（包括头文件）
<Ctrl+\>+t：查找指定的字符串
<Ctrl+\>+c：查找调用本函数的函数
<Ctrl+\>+d：查找本函数调用的函数
<Ctrl+\>+e：查找egrep模式，相当于egrep功能，但查找速度快多了
<Ctrl+\>+f：查找并打开文件，类似vim的find功能
<Ctrl+\>+i：查找包含本文件的文件
上面功能同理可在命令模式下输入cs find g\s\t\c\d\e\f\i 函数、宏、枚 等实现相应功能
更多其他功能可输入：help cscope查看


Run :CtrlP or :CtrlP [starting-directory] to invoke CtrlP in find file mode.
Run :CtrlPBuffer or :CtrlPMRU to invoke CtrlP in find buffer or find MRU file mode.
Run :CtrlPMixed to search in Files, Buffers and MRU files at the same time.
<Ctrl+p>：打开CtrlP插件，通过名字模糊查找文件。（等同于输入:CtrlP ）
在CtrlP被打开时：
* <F5> 更新目录缓存。
* <Ctrl-f> / <c-b> 在模式之间切换
* <Ctrl-d> 在”完整路径匹配“ 和 ”文件名匹配“ 之间切换
* <Ctrl-r> 在“字符串模式” 和 “正则表达式模式” 之间切换
* <Ctrl-j> / <c-k> 上下移动光标
* <Ctrl-t> 在新的 tab 打开文件
* <Ctrl-v> 垂直分割打开
* <Ctrl-x> 水平分割打开
* <Ctrl-p>, <c-n> 选择历史记录
* <Ctrl-y> 文件不存在时创建文件及目录
* <Ctrl-z> 标记/取消标记， 标记多个文件后可以使用 <c-o> 同时打开多个文件

INSERT输入模式下通过<Ctrl+n>，<Ctrl+p>，可以实现单词（给查单词的部分字符）的自动补全和输入提示的功能。
NORMAL命令模式下<g>+<c>+<c>批量自动注释/反代码
VISUAL可视模式下<g>+<c>批量自动注释/反代码

--------------------------------------------------------------------------------------
更多细节：
<空格>+1：C格式风格
<空格>+2：HTML格式风格
<空格>+3：Python格式风格
<空格>+4：Javascript格式风格
<空格>+Enter：Fast remove highlight search
<空格>+ee：Fast editing of .vimrc
<空格>+ss：Fast reloading of the .vimrc

