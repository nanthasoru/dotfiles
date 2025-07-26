-- VIM SETTINGS
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.number = true
vim.o.undofile = true

vim.o.autoindent = true
vim.o.smartindent = true

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- KEY BINDINGS
vim.keymap.set("n", "<leader><leader>", vim.cmd.Ex)

-- PLUGIN MANAGER : lazy.nvim
-- See https://lazy.folke.io/installation

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = true },
})
