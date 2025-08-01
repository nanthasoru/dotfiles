-- settings
vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.undofile = true
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true

vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.smartindent = true

-- Diagnostics (show error on the buffer)
-- Yanked from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.diagnostic.config({
	severity_sort = true,
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
})

-- lazy.nvim install
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({
	spec = {
		-- colorscheme
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				vim.cmd(":colorscheme tokyonight")
			end,
		},
		-- language server protocol
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				"saghen/blink.cmp",
				"rafamadriz/friendly-snippets",
			},
			config = function()
				local lsp = require("lspconfig")
				-- Servers : lua-language-server jdtls rust-analyzer pyright vscode-langservers-extracted typescript typescript-language-server clang
				lsp.lua_ls.setup({})
				lsp.jdtls.setup({})
				lsp.rust_analyzer.setup({})
				lsp.pyright.setup({})
				lsp.cssls.setup({})
				lsp.html.setup({})
				lsp.ts_ls.setup({})
				lsp.clangd.setup({})

				require("blink.cmp").setup({})
			end,
		},
		-- formatters : stylua rustfmt google-java-format python-black
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					rust = { "rustfmt" },
					java = { "google-java-format" },
					python = { "black" },
				},
			},
		},
		-- fuzzy finder
		{
			"nvim-telescope/telescope.nvim",
			opts = {},
		},
		checker = { enabled = true },
	},
})

-- Format file on save if possible with conform
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- Keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current line" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search in files" })
