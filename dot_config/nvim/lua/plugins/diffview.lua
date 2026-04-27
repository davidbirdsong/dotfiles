return {
    {
        "sindrets/diffview.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- optional but nice
        },
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFileHistory",
        },
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
            { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
            { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
        },
        config = function()
            require("diffview").setup({
                -- leave empty for defaults, or customize here
            })
        end,
    },
}
