
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node

local M = {}

local function tmpl_dir()
  return vim.fn.stdpath("config") .. "/templates"
end

-- return a list of language supported based on template on the fs
local function list_languages(dir)
  local ok, entries = pcall(vim.fn.readdir, dir)
  if not ok then
    return {}
  end
  local langs = {}
  for _, f in ipairs(entries) do
    local lang = f:match("^(.*)%.tpl$")
    if lang and #lang > 0 then
      table.insert(langs, lang)
    end
  end
  table.sort(langs)
  return langs
end

-- guess language using filetype
local function guess_language()
  local ft = vim.bo.filetype
  if ft and #ft > 0 then
    return ft
  end
  local name = vim.api.nvim_buf_get_name(0)
  if name and #name > 0 then
    local ext = name:match("%.([%w_%-]+)$")
    if ext and #ext > 0 then
      return ext
    end
  end
  return nil
end

-- inset: replace visual selection if range>0, otherwise insert at cursor
local function insert_lines(lines, opts)
  opts = opts or {}
  local bufnr = 0
  local cursor_pos = vim.api.nvim_win_get_cursor(0) -- {row, col} (1-indexed)
  local row = cursor_pos[1]

  if opts.range and opts.range > 0 then
    -- Remplacer la sélection visuelle : plage des lignes marquées '< et '>
    local start_line = vim.fn.getpos("'<")[2]
    local end_line   = vim.fn.getpos("'>")[2]
    -- Remplacer (API lignes 0-indexed, end exclusive)
    vim.api.nvim_buf_set_lines(bufnr, start_line - 1, end_line, false, lines)
    -- Repositionner le curseur à la fin du bloc inséré
    vim.api.nvim_win_set_cursor(0, { start_line + #lines - 1, 0 })
  else
    -- Insérer après la ligne courante (au curseur logique)
    vim.api.nvim_buf_set_lines(bufnr, row, row, false, lines)
    vim.api.nvim_win_set_cursor(0, { row + #lines, 0 })
  end
end

-- find template path for a language
local function template_path_for(lang)
  return string.format("%s/%s.tpl", tmpl_dir(), lang)
end

-- read a template and return a table of lines + err
local function read_template(lang)
  local path = template_path_for(lang)
  local ok, lines = pcall(vim.fn.readfile, path)
  if not ok then
    return nil, string.format("couldn't not read template: %s", path)
  end
  if not lines or vim.tbl_isempty(lines) then
    return nil, string.format("empty template: %s", path)
  end
  return lines, path
end

function M.setup()
  vim.api.nvim_create_user_command("Template", function(cmdargs)
    local lang = cmdargs.args
    if lang == nil or lang == "" then
      lang = guess_language()
      if not lang then
        vim.notify("Template: no language provided and filetype not defined.", vim.log.levels.WARN)
        return
      end
    end

    local lines, src_path = read_template(lang)
    if not lines then
      vim.notify(src_path or ("Template: template not found for '" .. lang .. "'"), vim.log.levels.ERROR)
      return
    end

    if cmdargs.bang then
      -- :Template! -> new buffer
      open_in_new_buffer(lines, lang, src_path)
      return
    end

    -- insert to current buffer (replace selection)
    insert_lines(lines, { range = cmdargs.range })
    vim.notify(("Template: '%s' inserted (%s)"):format(lang, src_path), vim.log.levels.INFO)
  end, {
    nargs = "?",
    bang = true,    --  :Template! to open a new buffer
    range = true,   -- support visual selection replacement
    complete = function(_, _, _)
      return list_languages()
    end,
    desc = "insert a template from ~/.config/nvim/templates/<language>.tpl (:Template! for a new buffer)",
  })
end

return M
