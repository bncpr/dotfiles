#!/bin/bash

ln -srf config.lua ~/.config/lvim/config.lua

mkdir -pv ~/.config/nvim/after/ftplugin
ln -srf ftplugin/c.lua ~/.config/nvim/after/ftplugin/c.lua
ln -srf ftplugin/c.lua ~/.config/nvim/after/ftplugin/cpp.lua

mkdir -pv ~/.config/lvim/luasnippets
ln -srf snippets/* ~/.config/lvim/luasnippets/
