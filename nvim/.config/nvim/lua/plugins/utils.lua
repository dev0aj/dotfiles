return {
  { 'NMAC427/guess-indent.nvim', opts = {} },

  {
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        transparent = false,
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      vim.opt.termguicolors = true
      vim.cmd.colorscheme 'tokyonight-moon'
    end,
  },

  {
    "nvim-mini/mini.nvim",
    config = function()
      require("mini.surround").setup()
    end,
  },

}
