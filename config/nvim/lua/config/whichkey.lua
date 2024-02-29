local wk = require("which-key")
wk.setup()
wk.register({
  ["<c-b>"] = { "scrll down", "scrolldown" },
  ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
})
