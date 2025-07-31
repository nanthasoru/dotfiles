return {
	"neovim/nvim-lspconfig",

	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {},
		},
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {},
		},
		{
			"saghen/blink.cmp",
			dependencies = { "rafamadriz/friendly-snippets" },
			version = "1.*",
			opts = {
				-- 'default', 'super-tab', 'enter', 'none'
				keymap = { preset = "default" },

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
		{
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			opts = {
				ensure_installed = TOOLS,
			},
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
