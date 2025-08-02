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

vim.pack.add({
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/stevearc/conform.nvim" },
})

vim.cmd(":colorscheme tokyonight")

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

-- completion
for _, server in ipairs(servers) do
	-- Yanked from : https://blog.viktomas.com/graph/neovim-native-built-in-lsp-autocomplete/
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

-- formatters : stylua rustfmt clang-format python-black
require("conform").setup({
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
})
vim.cmd("set completeopt+=noselect")

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

require("mini.pick").setup({})

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>s", ":Pick files<CR>")
vim.keymap.set("i", "<C-space>", vim.lsp.completion.get)

-- Yanked from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
vim.diagnostic.config({
	severity_sort = true,
	underline = { severity = vim.diagnostic.severity.ERROR },
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
