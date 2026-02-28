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
      require("mini.pairs").setup()
    end,
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    keys = {
        -- Will use Telescope if installed or a vim.ui.select picker otherwise
        { "<leader>wf", "<cmd>AutoSession search<CR>", desc = "Session Find" },
        { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },
        { "<leader>wa", "<cmd>AutoSession toggle<CR>", desc = "Toggle autosave" },
    },

    config = function()
        require("auto-session").setup({
            log_level = "error",
            auto_save_enabled = true,
            auto_restore_enabled = true,
            auto_session_use_git_branch = true,
            auto_restore_lazy_delay_enabled = true,

            session_lens = {
                -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
                load_on_setup = true,
                previewer = false,
                mappings = {
                    -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
                    delete_session = { { "n" }, "dd" },
                    alternate_session = { { "n" }, "ss" },
                },
                -- Can also set some Telescope picker options
                theme_conf = {
                    border = true,
                    layout_config = {
                        width = 0.8,
                        height = 0.4,
                    },
                    preview = false
                },
            },
        })
    end,
  }

}
