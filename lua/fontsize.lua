local warn = function(message)
    vim.api.nvim_echo({{'fontsize.nvim: ' .. message, 'WarningMsg'}}, true, {})
end

local M = {}

local default = nil
local size = nil
local font = nil
local max = nil 
local min = nil
local step = nil

M.indicator = function()
    return size or '~'
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
        return
    end
    if not (config.font) then
        warn('config must have `font` set.')
        return
    end
    default = config.default or 8
    size = default
    min = config.min or 6
    max = config.max or 30
    step = config.step or 1
    font = config.font
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
        'FontDefault', 
        function() M.change_size(0) end,
        {}
    )
end

return M
