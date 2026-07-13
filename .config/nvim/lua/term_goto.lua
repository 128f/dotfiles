-- Jump from a "path:line:col" reference in a terminal buffer (e.g. a Rust
-- compiler error like `--> src/scheduler/systems.rs:57:46`) to that exact
-- spot in a real editor window. Bound to `gd` in toggleterm buffers.
local M = {}

-- Find a `path:line[:col]` token on `line`, preferring one under the cursor.
local function parse_location(line, cursor_col)
  local best
  local init = 1
  while true do
    local s, e, file, lnum, col = line:find("([%w%._%-/]+):(%d+):?(%d*)", init)
    if not s then break end
    local cand = { file = file, lnum = tonumber(lnum), col = tonumber(col), s = s, e = e }
    best = best or cand
    -- cursor_col is 0-based; the pattern positions are 1-based.
    if cursor_col + 1 >= s and cursor_col + 1 <= e then
      return cand
    end
    init = e + 1
  end
  return best
end

-- Turn a (usually relative) path into an absolute one that exists.
local function resolve(file)
  if vim.fn.filereadable(file) == 1 then
    return vim.fn.fnamemodify(file, ":p")
  end
  local cwd = vim.fn.getcwd()
  local p = cwd .. "/" .. file
  if vim.fn.filereadable(p) == 1 then
    return p
  end
  -- Last resort: search downward from cwd for the basename and match the
  -- relative suffix (handles errors reported from a subdir/workspace member).
  for _, m in ipairs(vim.fs.find(vim.fs.basename(file), { path = cwd, type = "file", limit = 20 })) do
    if m:sub(-#file) == file then
      return m
    end
  end
  return nil
end

function M.goto_location()
  local line = vim.api.nvim_get_current_line()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local loc = parse_location(line, col)
  if not loc then
    vim.notify("term_goto: no file:line under cursor", vim.log.levels.WARN)
    return
  end

  local path = resolve(loc.file)
  if not path then
    vim.notify("term_goto: file not found: " .. loc.file, vim.log.levels.WARN)
    return
  end

  -- Land in a real (non-floating, non-terminal) editor window.
  local target
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    local b = vim.api.nvim_win_get_buf(w)
    if vim.bo[b].buftype ~= "terminal" and vim.api.nvim_win_get_config(w).relative == "" then
      target = w
      break
    end
  end

  -- If we're sitting in a float (the toggleterm), hide it.
  if vim.api.nvim_win_get_config(0).relative ~= "" then
    pcall(vim.api.nvim_win_close, 0, false)
  end
  if target and vim.api.nvim_win_is_valid(target) then
    vim.api.nvim_set_current_win(target)
  end

  vim.cmd.edit(vim.fn.fnameescape(path))
  pcall(vim.api.nvim_win_set_cursor, 0, { loc.lnum or 1, (loc.col or 1) - 1 })
  vim.cmd("normal! zz")
end

return M
