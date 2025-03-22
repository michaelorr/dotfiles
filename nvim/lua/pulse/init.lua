local M = {}


-- Store active timers
local active_timers = {}

local function clear_timers()
    for _, timer in ipairs(active_timers) do
        if timer then
            timer:stop()
        end
    end
    active_timers = {}
end

local function interpolate_color(start_hex, end_hex, steps)
    -- Convert hex to rgb
    local function hex_to_rgb(hex)
        hex = hex:gsub("#", "")
        return tonumber(hex:sub(1,2), 16),
               tonumber(hex:sub(3,4), 16),
               tonumber(hex:sub(5,6), 16)
    end

    -- Convert rgb to hex
    local function rgb_to_hex(r, g, b)
        return string.format("#%02x%02x%02x", r, g, b)
    end

    local sr, sg, sb = hex_to_rgb(start_hex)
    local er, eg, eb = hex_to_rgb(end_hex)

    local colors = {}
    for i = 0, steps - 1 do
        local ratio = i / (steps - 1)
        local r = math.floor(sr + (er - sr) * ratio)
        local g = math.floor(sg + (eg - sg) * ratio)
        local b = math.floor(sb + (eb - sb) * ratio)
        colors[i + 1] = rgb_to_hex(r, g, b)
    end
    return colors
end

local function pulse_line()
    clear_timers()

    -- Store original highlight
    local original_hl = vim.api.nvim_get_hl(0, { name = "OrigCursorLine" })
    local start_color = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "PulseCursorLine" }).bg)
    local end_color = original_hl.bg and string.format("#%06x", original_hl.bg)

    -- Generate fade steps
    local steps = 20  -- number of fade steps
    local colors = interpolate_color(start_color, end_color, steps)
    local step_duration = 10  -- ms between steps

    -- Initial bright color
    vim.api.nvim_set_hl(0, "CursorLine", { bg = colors[1] })
    vim.cmd("redraw")

    -- Fade through colors
    for i = 2, #colors do
        local timer_id = vim.defer_fn(function()
            vim.api.nvim_set_hl(0, "CursorLine", { bg = colors[i] })
            vim.cmd("redraw")

            if i == #colors then
                vim.api.nvim_set_hl(0, "CursorLine", original_hl)
            end
        end, step_duration * (i - 1))

        table.insert(active_timers, timer_id)
    end
end

function M.setup()
  -- Normal mode mappings
  vim.keymap.set('n', 'n', 'nzz<cmd>lua require("pulse").pulse()<CR>')
  vim.keymap.set('n', 'N', 'Nzz<cmd>lua require("pulse").pulse()<CR>')
  vim.keymap.set('n', '*', '*zz<cmd>lua require("pulse").pulse()<CR>')
  vim.keymap.set('n', '#', '#zz<cmd>lua require("pulse").pulse()<CR>')

  -- Create an augroup for our autocmd
  local group = vim.api.nvim_create_augroup('PulseGroup', { clear = true })

  -- Handle search commands
  vim.api.nvim_create_autocmd("CmdLineLeave", {
    -- this will still match any command that contains the pattern
    -- so the conditional below is necessary
    pattern = {'/', '?'},
    callback = function()
      -- Only pulse for search commands
      local cmdtype = vim.fn.getcmdtype()
      if cmdtype == '/' or cmdtype == '?' then
        vim.schedule(function()
          M.pulse()
        end)
      end
    end
  })
end

function M.pulse()
  pulse_line()
end

return M
