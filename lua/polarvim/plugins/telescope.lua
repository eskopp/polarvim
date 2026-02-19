return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({})

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })

      vim.keymap.set("n", "<leader>fH", function()
        builtin.find_files({ cwd = vim.fn.expand("~") })
      end, { desc = "Find files (home)" })

      vim.keymap.set("n", "<leader>f/", function()
        builtin.find_files({ cwd = "/" })
      end, { desc = "Find files (/)" })
    end,
  },
}
