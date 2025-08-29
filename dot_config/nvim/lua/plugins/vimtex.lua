return {
	"lervag/vimtex",
	ft = { "tex", "plaintex", "bib" }, -- Load on LaTeX file types
	config = function()
		-- PDF Viewer Configuration
		-- macOS: Use Skim
		vim.g.vimtex_view_method = "skim"
		-- Linux: Use Zathura
		-- vim.g.vimtex_view_method = "zathura"

		-- Compiler Configuration
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			aux_dir = "build", -- Auxiliary files directory
			out_dir = "build", -- Output directory
			callback = 1, -- Enable callbacks
			continuous = 1, -- Continuous compilation
			executable = "latexmk", -- Compiler executable
			hooks = {}, -- Compilation hooks
			options = {
				"-verbose", -- Verbose output
				"-file-line-error", -- Show file and line in errors
				"-synctex=1", -- Enable SyncTeX
				"-interaction=nonstopmode", -- Don't stop on errors
				"-f", -- Force compilation even if up-to-date
			},
		}

		-- Quickfix Configuration
		vim.g.vimtex_quickfix_mode = 0 -- Don't auto-open quickfix window

		-- Filter out common warnings
		vim.g.vimtex_quickfix_ignore_filters = {
			"Overfull \\\\hbox",
			"Underfull \\\\hbox",
			"Overfull \\\\vbox",
			"Underfull \\\\vbox",
			"Package hyperref Warning",
			"Package rerunfilecheck Warning", 
			"Package natbib Warning",
			"Marginpar on page",
			"Float too large for page",
		}

		-- Disable VimTeX folding to avoid extend() errors
		-- You can enable this later once the core functionality works
		vim.g.vimtex_fold_enabled = 0

		-- Syntax and Concealment
		vim.g.vimtex_syntax_conceal = {
			accents = 1, -- Conceal accents
			ligatures = 1, -- Conceal ligatures
			cites = 1, -- Conceal citations
			fancy = 1, -- Fancy concealment
			spacing = 0, -- Don't conceal spacing
			greek = 1, -- Conceal Greek letters
			math_bounds = 1, -- Conceal math delimiters
			math_delimiters = 1, -- Conceal math delimiters
			math_fracs = 1, -- Conceal fractions
			math_super_sub = 1, -- Conceal superscripts/subscripts
			math_symbols = 1, -- Conceal math symbols
			sections = 0, -- Don't conceal sections
			styles = 1, -- Conceal text styles
		}

		-- Disable conflicting mappings
		vim.g.vimtex_mappings_disable = {
			["n"] = { "K" }, -- Don't override K for documentation lookup
		}

		-- LaTeX-specific keymaps
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "tex", "plaintex", "bib" },
			callback = function()
				local map = function(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = true, desc = "VimTeX: " .. desc })
				end

				-- Compilation keymaps
				map("n", "<leader>ll", ":VimtexCompile<CR>", "Compile")
				map("n", "<leader>lL", ":VimtexCompileSS<CR>", "Compile single shot")
				map("n", "<leader>lc", ":VimtexClean<CR>", "Clean auxiliary files")
				map("n", "<leader>lC", ":VimtexCleanAll<CR>", "Clean all output files")
				map("n", "<leader>lk", ":VimtexStop<CR>", "Stop compilation")
				map("n", "<leader>lK", ":VimtexStopAll<CR>", "Stop all compilation")
				
				-- Force recompilation keymap
				map("n", "<leader>lf", function()
					vim.cmd("VimtexClean")
					vim.cmd("VimtexCompile")
				end, "Force clean and recompile")

				-- Viewing keymaps
				map("n", "<leader>lv", ":VimtexView<CR>", "View PDF")
				map("n", "<leader>lr", ":VimtexReverseSearch<CR>", "Reverse search")

				-- Navigation keymaps
				map("n", "<leader>lt", ":VimtexTocOpen<CR>", "Open table of contents")
				map("n", "<leader>lT", ":VimtexTocToggle<CR>", "Toggle table of contents")

				-- Info and diagnostics
				map("n", "<leader>li", ":VimtexInfo<CR>", "VimTeX info")
				map("n", "<leader>lI", ":VimtexInfoFull<CR>", "VimTeX info (full)")
				map("n", "<leader>le", ":VimtexErrors<CR>", "Show errors")

				-- Context menu
				map("n", "<leader>lm", ":VimtexContextMenu<CR>", "Context menu")

				-- Motion keymaps (these might work as plug mappings)
				map("n", "]]", "<plug>(vimtex-]])", "Next section")
				map("n", "[[", "<plug>(vimtex-[[)", "Previous section")
				map("n", "][", "<plug>(vimtex-][)", "Next section end")
				map("n", "[]", "<plug>(vimtex-[])", "Previous section end")

				-- Text objects are automatically provided by VimTeX:
				-- ac, ic - around/inside command
				-- ad, id - around/inside delimited text
				-- ae, ie - around/inside environment
				-- a$, i$ - around/inside inline math
				-- aP, iP - around/inside paragraph
			end,
		})
	end,
}