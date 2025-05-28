require('arrow').setup({
  show_icons = true,
  leader_key = ';', -- Recommended to be a single key
  buffer_leader_key = 'm', -- Per Buffer Mappings
   always_show_path = true,
})
local statusline = require('arrow.statusline')
statusline.is_on_arrow_file() -- return nil if current file is not on arrow.  Return the index if it is.
statusline.text_for_statusline() -- return the text to be shown in the statusline (the index if is on arrow or "" if not)
statusline.text_for_statusline_with_icons() -- Same, but with an bow and arrow icon ;D
