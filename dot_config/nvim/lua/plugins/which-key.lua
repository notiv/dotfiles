return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 10000 -- Work-around to prevent triggering only with the <leader>
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer local keymaps (which-key)",
    },
  },
}
