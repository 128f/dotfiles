-- Prompt for an instruction, run it together with the visual selection through
-- `pi --model <model> -p /raw <instruction + selection>` async, show a spinner
-- anchored at the selection, then replace the selection with pi's response.
local M = {}

local ns = vim.api.nvim_create_namespace('pi_indicator')
local SPINNER = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }

-- Animated "pi is working" virtual text at end of the selection's first line.
local function start_indicator(buf, row, model)
  local i = 1
  local function render()
    if not vim.api.nvim_buf_is_valid(buf) then return end
    vim.api.nvim_buf_set_extmark(buf, ns, row, 0, {
      id = 1,
      virt_text = { { '  ' .. SPINNER[i] .. ' pi (' .. model .. ') …', 'DiagnosticInfo' } },
      virt_text_pos = 'eol',
    })
    i = i % #SPINNER + 1
  end
  render()
  local timer = vim.uv.new_timer()
  timer:start(120, 120, vim.schedule_wrap(render))
  return timer
end

local function stop_indicator(buf, timer)
  if timer then
    timer:stop()
    if not timer:is_closing() then timer:close() end
  end
  if vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  end
end

local function replace_region(buf, srow, scol, erow, ecol, mode, lines)
  if mode == 'V' then
    -- linewise: swap the whole lines out
    vim.api.nvim_buf_set_lines(buf, srow - 1, erow, false, lines)
  else
    -- charwise (blockwise falls back to charwise)
    local last = vim.api.nvim_buf_get_lines(buf, erow - 1, erow, false)[1] or ""
    ecol = math.min(ecol, #last)
    vim.api.nvim_buf_set_text(buf, srow - 1, scol - 1, erow - 1, ecol, lines)
  end
end

-- Drop a wrapping ```lang ... ``` fence if the model added one, so we insert raw
-- code rather than markdown. Returns a list of lines.
local function strip_code_fence(text)
  local lines = vim.split(text, '\n', { plain = true })
  if lines[1] and lines[1]:match('^```') then
    table.remove(lines, 1)
    if lines[#lines] and lines[#lines]:match('^```%s*$') then
      table.remove(lines, #lines)
    end
  end
  return lines
end

-- model: the value passed to `pi --model`. Call from a mapping that has already
-- left visual mode (so the '< and '> marks are current).
function M.run(model)
  if vim.fn.executable('pi') == 0 then
    vim.notify('pi: executable not found on PATH', vim.log.levels.ERROR)
    return
  end

  local mode = vim.fn.visualmode()
  local p1 = vim.fn.getpos("'<")
  local p2 = vim.fn.getpos("'>")
  local srow, scol = p1[2], p1[3]
  local erow, ecol = p2[2], p2[3]
  if srow == 0 then
    vim.notify('pi: no visual selection', vim.log.levels.WARN)
    return
  end

  local selection = table.concat(vim.fn.getregion(p1, p2, { type = mode }), '\n')
  local buf = vim.api.nvim_get_current_buf()

  vim.ui.input({ prompt = 'pi (' .. model .. ') > ' }, function(instruction)
    if not instruction or vim.trim(instruction) == '' then
      vim.notify('pi: cancelled (no instruction)', vim.log.levels.WARN)
      return
    end

    local ft = vim.bo[buf].filetype
    local fname = vim.api.nvim_buf_get_name(buf)
    fname = fname ~= '' and vim.fn.fnamemodify(fname, ':~:.') or '[No Name]'
    local context = 'Language: ' .. (ft ~= '' and ft or 'unknown') .. '\nFile: ' .. fname

    local content = '/raw ' .. instruction .. '\n\n' .. context .. '\n\n' .. selection
    local timer = start_indicator(buf, srow - 1, model)

    vim.system({ 'pi', '--model', model, '--no-tools', '-p', content }, { text = true }, function(obj)
      vim.schedule(function()
        stop_indicator(buf, timer)
        if obj.code ~= 0 then
          vim.notify('pi failed (exit ' .. tostring(obj.code) .. '):\n'
            .. (obj.stderr or ''), vim.log.levels.ERROR)
          return
        end
        local out = vim.trim(obj.stdout or '')
        if out == '' then
          vim.notify('pi: empty response', vim.log.levels.WARN)
          return
        end
        if not vim.api.nvim_buf_is_valid(buf) then return end
        local lines = strip_code_fence(out)
        replace_region(buf, srow, scol, erow, ecol, mode, lines)
        vim.notify('pi ← ' .. model .. ' (' .. #lines .. ' lines)', vim.log.levels.INFO)
      end)
    end)
  end)
end

return M
