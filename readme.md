---
layout: post
date: 2019-05-02, Thu, 22:05:32
author: Chopong
email: weisp.pku@gmail.com
category: note

title: 中文输入法词库
subtitle: 在Linux系统环境下, 使用fcitx框架下的输入法, 进行安装词库, 优化输入体验
tags: post note Linux fcitx Chinese dictionary sougou sunpinyin
---
# Table of Contents #
* TOC
{:toc}
# 中文输入法词库 #

## 在Linux系统环境下, 使用fcitx框架下的输入法, 进行安装词库, 优化输入体验 ##

## 背景 ##

在Linux系统上进行中文输入不像在Windows那样简单, 之前已经推过一篇博文说明如何在Linux下进行 [中文输入][6], 但是输入体验和Windows下的还是有差距.

目前, **搜狗输入法** 和 **Deepin**合作已经开发了Linux版本, 有需要的朋友可以直接去搜狗官网进行下载. 但是对我来说, 每次重启后搜狗输入法总是改变我的输入法设置, 导致我的一些软件不能按我想的方式进行中文输入, 比如在emacs上输入会吃字, 即从英文切换到中文输入法时, 第一个字母仍然是英文字母, 每次都要删掉, 非常麻烦, 所以我就想怎么才能避免这个问题呢? 使用fcitx框架下的其他输入法, 配合搜狗输入法的词库, 无疑是最佳搭配, 所以才有这篇博文.

在fcitx框架下, 很多输入法都可以搭配个人的词库, 本博文也时按照这个思路进行简单总结:

* sunpinyin + userdict (优点: 最简单, 无须转换)
* pinyin + 下载词库 (直接下载网上词库, 需要转换, 缺点: 体积大)
* pinyin + 自定义词库 (从搜狗官网下载, 可自定义输入的词库, 需要两次转换)

## 具体方法 ##

### 1. sunpinyin + userdict ###

1). 下载sunpinyin-userdict.7z 完整版词库[`地址`][2];
2). 解压后得到userdict文件, 将其移动到 `~/.sunpinyin/`
3). 覆盖原来的文件就行, 若看不见目录, C-h 即能看见.
4). 注销重新登录.

### 2. pinyin + 下载词库 ###

fcitx-pinyin 也可以安装词库, 不过不能直接使用, 需要进行转换, 按照之前的薄荷开源网的一篇[`帖子`][1], fcitx-pinyin使用词库需要下载sg2fcitx转换工具[`sg2fcitx`][3], 但实际上这里面的`createPYMB`已经集成到了`fcitx-tools`中, 可以直接使用安装包管理工具进行安装, 然后直接调用即可, 比如:

``` shell
    sudo apt install fcitx-tools
```

1). [二选一]下载/安装 转换工具

* sg2fcitx
* fcitx-tools

2). 下载别人制作好的词库, 比如[`fcitx-sougou-phrase-full`][2]

3). 使用`createPYMB`进行转换

* 使用`fcitx-tools`
``` shell
    cd ~/Downloads/fcitx-sougou-phrase-full
    createPYMB gbkpy.org pyPhrase.org
```

* 或者使用下载的文件`sg2fcitx`

把解压后的`createPYMB`和`sg2fcitx`复制到刚才下载, 等待转换的词库文件夹`fcitx-sougou-phrase-full`中

 ``` shell
    ./createPYMB gbkpy.org pyPhrase.org
```

4). 转换大概需要几分钟, 即可生成`pybase.mb`和`pyphrase.mb`两个词库文件, 加上`pyPhrase.org`, 把这三个文件都复制到 `/usr/share/fcitx/data`或者`/usr/share/fcitx/pinyin`下.

5). 注销系统, 重新登录后即可使用.

### 3. pinyin + 自定义词库 ###

第二种方法实际上已经比较好用了, 但是别人的词库包太大, 好多词库自己根本用不到, 想自己定义词库怎么办呢? 下面介绍第三种方法, 从搜狗官网下载scel文件, 然后转换成org文件, 再按照方法2进行第二次转换即可.

1). 从搜狗官网下载scel词库, 保存到默认位置`~/Downloads`(其他位置也行)

2). 使用`scel2org`进行转换(`scel2org`已经集成在`fcitx-tools`里, 可以直接使用安装包管理工具进行安装).

``` shell
    mkdir -p tmp && cd tmp && mkdir -p orgfile
    mv ~/Downloads/*.scel ./
    for dict in *.scel; do scel2org $dict -o orgfile/$dict.org    ; done
    cp ../pyPhrase.org orgfile/
    cat ../orgfile/* | sort | uniq > dicts.org
```

3). 然后按照第二种方法进行二次转换.

> 如果你觉得麻烦, 直接fork本repo, 然后使用下面的命令即可:

``` shell
    shell convert.sh
```

### 参考资料 ###



* [薄荷开源网][1]
* [hslinuxextra][2]
* [sg2fcitx][3]
* [fcitx-pinyin-lexicon][4]
* [搜狗官网][5]

[1]:http://www.mintos.org/skill/fcitx-sougou.html
[2]:https://code.google.com/archive/p/hslinuxextra/downloads
[3]:http://code.google.com/p/sg2fcitx/downloads/list
[4]:https://github.com/AlessandroChen/fcitx-pinyin-lexicon
[5]:https://pinyin.sogou.com/dict/
[6]:https://chopong.github.io/note/2019/04/22/%E4%B8%AD%E6%96%87%E8%BE%93%E5%85%A5/
