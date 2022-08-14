local warn = function(message)
    vim.api.nvim_echo({{'fontsize.nvim: ' .. message, 'ErrorMsg'}}, true, {})
end

local M = {}

-- Base font size
local default = nil
-- Current size
local size = nil
-- Font string
local font = nil
-- Maximum size
local max = nil 
-- Minimum size
local min = nil
-- Step size
local step = nil

-- Default configuration
local defaults = {
    min = 6,
    default = 8,
    max = 20,
    step = 1
}

-- Returns the current size. 
-- Useful for e.g. integration in a statusline
M.indicator = function()
    return (' ' .. (size or '~'))
end

M.update_font = function()
    vim.o.guifont = font .. ':h' .. size
end

M.change_size = function(change)
    if change < 0 then 
        size = math.max(min, size - step)
    elseif change > 0 then 
        size = math.min(max, size + step)
    else
        size = default
    end
    M.update_font()
end

M.init = function(config) 
    if not config then
        warn('missing config.')
        return
    end
    if not (config.font) then
        warn('config must have `font` set.')
        return
    end

    -- Load values
    default = config.default or defaults.default
    min = config.min or defaults.min
    max = config.max or defaults.max
    step = config.step or defaults.step
    size = default
    font = config.font

    -- Fix min/max mismatch
    if min > max then 
        local temp = min 
        min = max 
        max = temp
    end

    -- User commands
    vim.api.nvim_create_user_command(
        'FontIncrease', 
        function() M.change_size(1) end,
        {}
    )
    vim.api.nvim_create_user_command(
        'FontDecrease', 
        function() M.change_size(-1) end,
        {}
    )
    vim.api.nvim_create_user_command(
        'FontReset', 
        function() M.change_size(0) end,
        {}
    )
end

return M
