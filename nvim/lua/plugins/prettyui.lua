return {
	{
		"norcalli/nvim-colorizer.lua", -- colorizer, example : #fff
		config = function()
			require("colorizer").setup()
		end,
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
		"lukas-reineke/indent-blankline.nvim", -- indentation marks
		main = "ibl",
		opts = {},
	},
}
