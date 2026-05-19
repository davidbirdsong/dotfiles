local function is_supabase_platform(bufnr)
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    return filepath:find(vim.fn.expand("~/src/supabase/platform"), 1, true) == 1
end

local function js_formatter(bufnr)
    if is_supabase_platform(bufnr) then
        return { "oxfmt" }
    end
    return { "prettier" }
end

return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            hcl = { "terraform_fmt" },
            terraform = { "terraform_fmt" },
            tf = { "terraform_fmt" },
            javascript = js_formatter,
            javascriptreact = js_formatter,
            typescript = js_formatter,
            typescriptreact = js_formatter,
            json = js_formatter,
            jsonc = js_formatter,
        },
    },
}
