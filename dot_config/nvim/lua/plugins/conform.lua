return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            hcl = { "terraform_fmt" },
            terraform = { "terraform_fmt" },
            tf = { "terraform_fmt" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            json = { "prettier" },
        },
    },
}
