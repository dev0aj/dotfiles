return {
    "nvim-lualine/lualine.nvim",
    event = "BufReadPre",
    opts = {
        options = {
            theme = "auto",
            component_separators = "",
        },
        sections = {
            lualine_a = {
                {
                    "mode",
                    color = { gui = "bold" },
                },
            },
            lualine_b = {
                {
                    "filename",
                    path = 1,
                    color = { gui = "bold" },
                },
            },
            lualine_c = {
                "diagnostics",
            },
            lualine_x = {},
            lualine_y = {
                {
                    "diff",
                    symbols = { added = " ", modified = "󰝤 ", removed = " " },
                },
            },
            lualine_z = {
                {
                    "branch",
                    icon = "",
                    color = { gui = "bold" },
                },
            },
        },
        inactive_sections = {
            lualine_a = {
                {
                    "filename",
                    file_status = true,
                    path = 1,
                },
                "diagnostics",
                "diff",
            },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { "location" },
        },
        tabline = {},
        extensions = {
            "trouble",
            "fzf",
            "nvim-dap-ui",
        },
    },
}
