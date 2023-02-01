#!/bin/bash

ln -srf config.lua ~/.config/lvim/config.lua

mkdir -pv ~/.config/lvim/ftplugin
ln -srf ftplugin/c.lua ~/.config/lvim/ftplugin/c.lua
ln -srf ftplugin/c.lua ~/.config/lvim/ftplugin/cpp.lua

mkdir -pv ~/.config/lvim/luasnippets
ln -srf snippets ~/.config/lvim/luasnippets
