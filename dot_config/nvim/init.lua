vim.g.mapleader = " " -- Global leader key set to Space
vim.g.maplocalleader = "," -- Local leader key set to comma
_G.vnext = {} -- Global table used as a namespace (modules can stash shared state on it). As in github.com/Allaman
require("config") -- Hand-off to lua/config/init.lua
