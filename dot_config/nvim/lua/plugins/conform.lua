return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "ruff" },
            -- You can customize some of the format options for the filetype (:help conform.format)
            rust = { "rustfmt" },
            -- LaTeX formatting
            tex = { "latexindent" },
            plaintex = { "latexindent" },
            bib = { "bibtex-tidy" }, -- Optional: BibTeX formatting
            -- Conform will run the first available formatter
        },
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_format = "fallback",
        },
        formatters = {
            latexindent = {
                prepend_args = {
                    "-g", "/dev/stderr", -- Send log to stderr
                    "-m", -- Modify line breaks
                },
            },
        },
    },
}
