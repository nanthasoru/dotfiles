return {
	"neovim/nvim-lspconfig",

	dependencies = {
		{
			"mason-org/mason.nvim", -- Mason Portable LSP, linter... package manager
			opts = {},
		},
		{
			"mason-org/mason-lspconfig.nvim", -- bridge
			opts = {},
		},
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim", -- really cool to automate the installation of packages
			opts = {
				ensure_installed = {
					"vim-language-server",
					"lua-language-server",
					"stylua",
					"jdtls",
					"google-java-format",
					"rust-analyzer",
					"rustfmt",
					"fish-lsp",
					"bash-language-server",
					"hyprls",
					"cssls",
				},
			},
		},
		{
			"saghen/blink.cmp", -- completion
			dependencies = { "rafamadriz/friendly-snippets" },
			version = "1.*",
			opts = {
				-- 'default', 'super-tab', 'enter', 'none'
				keymap = { preset = "super-tab" },

				appearance = {
					nerd_font_variant = "mono",
				},

				completion = { documentation = { auto_show = true } },

				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},

				fuzzy = { implementation = "lua" },
			},
			opts_extend = { "sources.default" },
		},
		-- LSP support
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		{
			"mfussenegger/nvim-jdtls",
		},
	},

	opts = {
		servers = {
			lua_ls = {},
		},
	},

	config = function(_, opts)
		local lspconfig = require("lspconfig")
		for server, config in pairs(opts.servers) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end
	end,
}
