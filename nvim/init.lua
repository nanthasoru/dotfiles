vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.undofile = true
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
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

require("lazy").setup({
	checker = { enabled = true },
	spec = {
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				vim.cmd(":colorscheme tokyonight")
			end,
		},
		{
			"neovim/nvim-lspconfig",
			config = function()
				local lsp = require("lspconfig")
				-- Servers : lua-language-server jdtls rust-analyzer pyright vscode-langservers-extracted typescript typescript-language-server clang
				local servers = {
					lsp.lua_ls,
					lsp.jdtls,
					lsp.rust_analyzer,
					lsp.pyright,
					lsp.cssls,
					lsp.html,
					lsp.ts_ls,
					lsp.clangd,
				}

				for _, server in ipairs(servers) do
					server.setup({
						on_attach = function(client, bufnr)
							vim.lsp.completion.enable(true, client.id, bufnr, {
								autotrigger = true,
								convert = function(item)
									return { abbr = item.label:gsub("%b()", "") }
								end,
							})
						end,
					})
				end
			end,
		},
		-- formatters : stylua rustfmt clang-format python-black
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					rust = { "rustfmt" },
					c = { "clang-format" },
					cpp = { "clang-format" },
					json = { "clang-format" },
					java = { "clang-format" },
					javascript = { "clang-format" },
					typescript = { "clang-format" },
					python = { "black" },
				},
			},
		},
		{
			"echasnovski/mini.pick",
			opts = {},
		},
	},
})

-- doesn't fill the first autocomplete suggestion
vim.cmd("set completeopt+=noselect")

-- Format file on save if possible with conform
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- Keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- remove highlighting after search on esc
vim.keymap.set("n", "<leader>s", ":Pick files<CR>")
vim.keymap.set("i", "<C-space>", vim.lsp.completion.get)
