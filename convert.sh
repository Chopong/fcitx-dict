#!/bin/bash

# date: 2019-05-03, Fri, 12:09:16
# author: Chopong
# email: weisp.pku@gmail.com
# description:

# convert scel to org
mkdir -p tmp && cd tmp && mkdir -p orgfile
mv ~/Downloads/*.scel ./
for dict in *.scel; do scel2org $dict -o orgfile/$dict.org    ; done
cp ../pyPhrase.org orgfile/
cat orgfile/* | sort | uniq > dicts.org

# convert org to mb
createPYMB ../gbkpy.org dicts.org

# copy converted file to pinyin location.
cp pyphrase.mb ~/.config/fcitx/pinyin/
cp pybase.mb ~/.config/fcitx/pinyin/
cp dict.org ~/.config/fcitx/pinyin/
