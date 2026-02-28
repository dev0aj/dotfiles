return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required

      -- Only one of these is needed.
      "sindrets/diffview.nvim",        -- optional
      -- "esmuellert/codediff.nvim",      -- optional

      -- Only one of these is needed.
      -- "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",              -- optional
      -- "nvim-mini/mini.pick",           -- optional
      "folke/snacks.nvim",             -- optional
    },
    config = function()
      local neogit = require("neogit")
      neogit.setup({
          commit_editor = {
              kind = "split",
              show_staged_diff = false,
              staged_diff_split_kind = "vsplit",
          },
      })

      vim.keymap.set("n", "<leader>hv", function()
          neogit.open({ kind = "vsplit" })
      end, { desc = "Open Neogit in vertical split" })
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    config = function()
      require("gitsigns").setup({
        signs = {
            add = { text = "┃" },
            change = { text = "┃" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            -- "eol" | "overlay" | "right_align"
            virt_text_pos = "eol",
            delay = 500,
            ignore_whitespace = false,
            virt_text_priority = 100,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      })

      local gs = package.loaded.gitsigns
      -- Navigation
      vim.keymap.set("n", "]g", function()
          if vim.wo.diff then
              return "]g"
          end
          vim.schedule(function()
              gs.next_hunk()
          end)
          return "<Ignore>"
      end, { expr = true })

      vim.keymap.set("n", "[g", function()
          if vim.wo.diff then
              return "[g"
          end
          vim.schedule(function()
              gs.prev_hunk()
          end)
          return "<Ignore>"
      end, { expr = true })

      -- Actions
      vim.keymap.set("n", "<leader>ha", gs.stage_hunk)
      vim.keymap.set("n", "<leader>hA", gs.stage_buffer)
      vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk)
      vim.keymap.set("n", "<leader>hr", gs.reset_hunk)
      vim.keymap.set("n", "<leader>hR", gs.reset_buffer)
      vim.keymap.set("n", "<leader>hp", "<Cmd>Gitsigns preview_hunk_inline<CR>", {})
      vim.keymap.set("n", "<leader>hb", gs.toggle_current_line_blame, {})
    end
  },
}
