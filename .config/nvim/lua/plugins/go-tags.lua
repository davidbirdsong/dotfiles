return {
    "devkvlt/go-tags.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },

    config = function()
        require("go-tags").setup({
            commands = {
                ["GoTagsAddJSON"] = { "-add-tags", "json" },
                ["GoTagsRemoveJSON"] = { "-remove-tags", "json" },
            },
        })
    end,
}
