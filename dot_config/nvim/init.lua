-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require("go.format").gofmt()
    end,
    group = format_sync_grp,
})

-- https://www.reddit.com/r/neovim/comments/w35wvw/how_to_handle_code_diagnostics_that_bleed_off_the/
-- get diagnostics when message bleeds off of screens
vim.keymap.set(
    "n",
    "<leader>dd",
    "<cmd> lua vim.diagnostic.open_float() <CR>",
    { desc = "?   toggles local troubleshoot" }
)
