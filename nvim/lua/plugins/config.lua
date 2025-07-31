-- This file's purpose is to allow easy IDE configuration.
-- Mason installer will install any specified package in TOOLS
-- stevearc's comform.nvim plugin will enable code formatting for all specified languages in FMT

TOOLS = {
	-- "fish-lsp",
	-- "bash-language-server",

	"vim-language-server",
	"lua-language-server",
	"stylua",

	-- "jdtls",
	-- "google-java-format",

	-- "rust-analyzer",
	-- "rustfmt",

	-- "hyprls",

	-- "cssls",
	-- "html-lsp",
	-- "typescript-language-server",

	-- "pyright",
	-- "black",

	-- "clangd",
}

FMT = {
	lua = { "stylua" },
	-- rust = { "rustfmt" },
	-- java = { "google-java-format" },
	-- python = { "black" },
}

local plugins = {

	-- makes neovim feel like a plane, code editor
	require("plugins.devtools"),

	-- makes me feel more comfortable
	require("plugins.helper"),

	-- lsp support :D
	require("plugins.nvim-lspconfig"),

	-- only purpose is to make Neovim look good, you could totally, without any consequences, delete it
	require("plugins.prettyui"),

	-- for java development, if you don't need it delete this, and the ftplugin/ folder
	{
		"mfussenegger/nvim-jdtls",
	},

	{
		"folke/lazydev.nvim", -- really useful
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}

return plugins
