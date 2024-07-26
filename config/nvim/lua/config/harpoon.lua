local harpoon = require("harpoon")
harpoon:setup()

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

local mappings = {
  {"<c-e>", function() toggle_telescope(harpoon:list()) end, mode = {"n", "v", "i"}, opt = { desc = "harpooned files" }},
  {"<leader>a", function() harpoon:list():add() end, mode = "n", opt = { desc = "harpoon current file" }},
}

for _, mapping in pairs(mappings) do
  local opt = vim.tbl_extend("force", default_opts, mapping.opt or {})
  vim.keymap.set(mapping.mode, mapping[1], mapping[2], opt)
end
