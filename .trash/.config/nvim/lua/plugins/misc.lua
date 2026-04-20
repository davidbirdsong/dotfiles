return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
        opts.close_if_last_window = true
        opts.enable_git_status = true
        opts.filesystem = opts.filesystem or {}
        opts.filesystem.filtered_items = vim.tbl_deep_extend("force", opts.filesystem.filtered_items or {}, {
            visible = true,
            never_show = { ".git" },
            never_show_by_pattern = { "*.o", "*.swp" },
            --hide_dotfiles = false,
            -- hide_gitignored = false,
            --
        })
    end,
}
