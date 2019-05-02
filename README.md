# fcitx-dict
fcitx框架下, 中文词库转换

## 读了一些关于fcitx词库的博文, 发现很多博文都提到了一个叫createPYMB的文件, 实际上这个工具已经集成在了fcitx-tools里, 可以直接使用包管理工具进行安装, 如debian

``` shell
  apt install fcitx-tools
```

然后使用命令createPYMB gbkpy.org pyPhrase.org即可

或者从搜狗网站上下载词库, 然后使用scel2org进行转换, 然后执行上面的步骤即可.
