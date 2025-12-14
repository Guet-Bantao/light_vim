# 🌟Light Vim

```
  _     _       _     _    __     ___
 | |   (_) __ _| |__ | |_  \ \   / (_)_ __ ___
 | |   | |/ _` | '_ \| __|  \ \ / /| |  _ ` _ \
 | |___| | (_| | | | | |_    \ V / | | | | | | |
 |_____|_|\__, |_| |_|\__|    \_/  |_|_| |_| |_|
          |___/
```

为什么还在使用VIM?
因为代码环境都部署在Linux中，也在Linux中编译，使用VIM方便快捷，开箱即用。
为什么没用使用neovim?
因为服务器没有预装，大部分Linux服务器都是不联网的，VIM成了最好的选择！

这套配置更新到第五版，基本不会再改了，已经非常完美了。


# 🛠安装

尽量使用Vim8.0以上版本以获得更好体验。
```bash
git clone https://github.com/Guet-Bantao/light_vim.git
sudo apt-get install ranger
sudo apt install global
sudo /usr/bin/python3.6 -m pip install autopep8
sudo mv rg /usr/local/bin/
写~/.bashrc
export PATH=~/ctags/tmp/bin:$PATH

note: 无法联网不install可以直接使用库里面离线的rg和ctags
```

# 📦特性

 * 代码自动提示补全
 * Tab插入代码片段
 * 查找函数定义/应用
 * 自动管理索引库
 * Enter自动格式化代码
 * 修改提示
 * 查找高亮
 * 模糊搜索
 * 彩虹括号，首尾括号跳转
 * 高亮空格、高亮不可见字符
 * 快速注释
 * 函数预览
 * 区分空格和Tab缩进
 * Git信息显示


# 🖋Key Mapping

<leader>默认为<空格>
## 函数定义/引用跳转

| keymap | desc |
|--------|------|
| `Ctrl+]` | 跳转定义 |
| `Ctrl+t` | 返回跳转 |
| `<leader>cs` | Find symbol (reference) under cursor |
| `<leader>cg` | Find symbol definition under cursor |
| `<leader>cd` | Functions called by this function |
| `<leader>cc` | Functions calling this function |
| `<leader>ct` | Find text string under cursor |
| `<leader>ce` | Find egrep pattern under cursor |
| `<leader>cf` | Find file name under cursor |
| `<leader>ci` | Find files #including the file name under cursor |
| `<leader>ca` | Find places where current symbol is assigned |
| `<leader>cz` | Find current word in ctags database |
| `%` | 跳转到匹配的括号 |

## Fx键
| keymap | desc |
|--------|------|
| `F2` | 浏览进入文件目录 |
| `F7` | 函数预览 |
| `F8` | 显示文件目录 |
| `F9` | 管理Buf文件 |
| `F10` | 纯净显示 |

## 代码补全
| keymap | desc |
|--------|------|
| `Tab` | 插入片段 |
| `Ctrl+n` | 下一个补全候选词 |
| `Ctrl+p` | 上一个补全候选词 |

note: 最好的补全应该是基于LSP，但是基于Light Vim的理念，轻量化，这里没有使用，没有联网不好安装。

## 🔗文件操作
| keymap | desc |
|--------|------|
| `Ctrl+p` | 查找文件 |
| `<leader>g` | 查找字符串 |
| `<leader>gm` | 显示Git提交信息 |
| `<leader>ww` | 文件保存 |
| `<leader>wq` | 文件保存退出 |
| `<leader>wf` | 文件强制保存退出 |
| `<leader>qq` | 文件退出 |
| `<leader>qf` | 文件强制退出 |
| `Tab` | 下一个Buf文件 |
| `Shift+Tab` | 上一个Buf文件 |

# 🤖Q&A

Q: gutentags: gutentags: gtags-cscope job failed, returned: 1
A: Vim后台扫描索引需要几秒时间，如果GTAGS没生成就关闭Vim会导致GTAGS生成失败，重新打开Vim等一会就好了。

Q: 回车无法自动格式化代码
A：sudo /usr/bin/python3.6 -m pip install autopep8，格式化使用的是autopep8工具，python3.6替换成Vim使用的python版本。

