require('codediff').setup({
  keymaps = {
    view = {
      quit = "q",                    -- Close diff tab
      toggle_explorer = "<leader>b",  -- Toggle explorer visibility (explorer mode only)
      next_hunk = "<c-n>",   -- Jump to next change
      prev_hunk = "<c-p>",   -- Jump to previous change
      next_file = "<c-j>",   -- Next file in explorer mode
      prev_file = "<c-k>",   -- Previous file in explorer mode
      diff_get = "do",    -- Get change from other buffer (like vimdiff)
      diff_put = "dp",    -- Put change to other buffer (like vimdiff)
    }
  }
})
