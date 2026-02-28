-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- center cusror on screen when moving
vim.keymap.set("", "<C-d>", "<C-d>zz")
vim.keymap.set("", "<C-u>", "<C-u>zz")
vim.keymap.set({ "n", "v" }, "n", "nzzzv")
vim.keymap.set({ "n", "v" }, "N", "Nzzzv")

-- append next line to current line without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Keybinds copy/paste
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader>D", [["_D]])
vim.keymap.set({ "n", "v" }, "<leader>c", [["_c]])
vim.keymap.set({ "n", "v" }, "<leader>C", [["_C]])
vim.keymap.set("n", "x", [["_x]])
-- delete to void register when pasting over a selection
vim.keymap.set("x", "<leader>p", [["_dP]])

-- map register n to <leader>n
vim.keymap.set("n", "<leader>1", [["1]])
vim.keymap.set("n", "<leader>2", [["2]])
vim.keymap.set("n", "<leader>3", [["3]])
vim.keymap.set("n", "<leader>4", [["4]])
vim.keymap.set("n", "<leader>5", [["5]])
vim.keymap.set("n", "<leader>6", [["6]])
vim.keymap.set("n", "<leader>7", [["7]])
vim.keymap.set("n", "<leader>8", [["8]])
vim.keymap.set("n", "<leader>9", [["9]])

-- keep text highlighted after indent/outdent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- -- quickfix list movement
-- local function quickFixToggle()
--     local qf_exists = false
--     for _, win in pairs(vim.fn.getwininfo()) do
--         if win["quickfix"] == 1 then
--             qf_exists = true
--         end
--     end
--     if qf_exists == true then
--         vim.cmd("cclose")
--         return
--     end
--     if not vim.tbl_isempty(vim.fn.getqflist()) then
--         vim.cmd("copen")
--     end
-- end
-- 
-- vim.keymap.set("n", "<leader>qo", quickFixToggle)
-- vim.keymap.set("n", "]q", "<cmd>cnext<cr>")
-- vim.keymap.set("n", "[q", "<cmd>cprev<cr>")

-- -- Diagnostic keymaps
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
-- vim.keymap.set("n", "<leader>dg", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
-- vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- function _G.set_terminal_keymaps()
--     local opts = { buffer = 0 }
--     vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
--     vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
--     vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
--     vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
-- end
--
-- -- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- delete marks
vim.keymap.set("n", "<leader>dm", "<Cmd>delmarks a-z<CR>")
vim.keymap.set("n", "<leader>dM", "<Cmd>delm! | delm A-Z0-9<CR>")

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })
