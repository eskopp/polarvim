return {
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, config = function()
      vim.cmd.colorscheme("tokyonight")
    end
  },

  { "nvim-lua/plenary.nvim" },

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function()
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if not ok then
        return
      end

      configs.setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
}
