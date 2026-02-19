return {
  -- Manage external tools locally (no global npm needed)
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- Autoformat on save by filetype
  {
    "stevearc/conform.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local conform = require("conform")

      conform.setup({
        format_on_save = {
          timeout_ms = 2000,
          lsp_fallback = true,
        },
        formatters_by_ft = {
          python = { "black" },

          javascript = { "prettierd" },
          javascriptreact = { "prettierd" },
          typescript = { "prettierd" },
          typescriptreact = { "prettierd" },

          html = { "prettierd" },
          css = { "prettierd" },
          scss = { "prettierd" },
          json = { "prettierd" },
          markdown = { "prettierd" },
          yaml = { "prettierd" },
        },
      })
    end,
  },

  -- Lint on save (diagnostics only)
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "ruff" },
      }

      local grp = vim.api.nvim_create_augroup("LintOnSave", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
        group = grp,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
