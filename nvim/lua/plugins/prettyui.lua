return {
	{
		"nvim-treesitter/nvim-treesitter", -- Correct color parsing
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"java",
				"rust",
				"python",
			},
			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,

				disable = function(lang, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},

			additional_vim_regex_highlighting = false,
		},
	},
	{
		"folke/tokyonight.nvim", -- great theme
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"xiyaowong/transparent.nvim", -- to match my hyprland/alacritty transparency and blur config
		opts = {},
	},
	{
		"sphamba/smear-cursor.nvim", -- cursor animation goes brrrr
		opts = {},
	},
	{
		"stevearc/conform.nvim", -- formatting files !
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
				java = { "google-java-format" },
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim", -- indentation marks
		main = "ibl",
		opts = {},
	},
	{
		"norcalli/nvim-colorizer.lua", -- colorizer, example : #fff
		config = function()
			require("colorizer").setup()
		end,
	},
}
