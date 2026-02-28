-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd("VimResized", { command = "wincmd ="})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({"c", "r", "o"})
  end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
	pattern = { ".env", ".env.*" },
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})

-- show cursorline only in active window enable
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

-- removes trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Keep the cursor position when yanking
local cursorPreYank

vim.keymap.set({ "n", "x" }, "y", function()
    cursorPreYank = vim.api.nvim_win_get_cursor(0)
    return "y"
end, { expr = true })

vim.keymap.set("n", "Y", function()
    cursorPreYank = vim.api.nvim_win_get_cursor(0)
    return "y$"
end, { expr = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        if vim.v.event.operator == "y" and cursorPreYank then
            vim.api.nvim_win_set_cursor(0, cursorPreYank)
        end
    end,
})
