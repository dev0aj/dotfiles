-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

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
vim.keymap.set("n", "J", "$mzJ`z")

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

-- -- Diagnostic keymaps
vim.keymap.set("n", "<leader>dg", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

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

-- lsp (overwritten by snacks)
vim.keymap.set({ "n" }, "gd", vim.lsp.buf.definition)
vim.keymap.set({ "n" }, "gD", vim.lsp.buf.declaration)
vim.keymap.set({ "n" }, "gt", vim.lsp.buf.type_definition)
vim.keymap.set({ "n" }, "gi", vim.lsp.buf.implementation)
vim.keymap.set({ "n" }, "gr", vim.lsp.buf.references)
vim.keymap.set({ "n" }, "K", vim.lsp.buf.hover)
vim.keymap.set({ "n" }, "<leader>cr", vim.lsp.buf.rename)
vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set({ "n" }, "<leader>i", function()
	vim.lsp.buf.format({ async = true })
end)


-- Toggle location list (your existing one, cleaned up)
vim.keymap.set("n", "<leader>ll", function()
  local win = vim.fn.getloclist(0, { winid = 0 }).winid
  if win ~= 0 then
    vim.cmd("lclose")
  else
    vim.cmd("lopen")
  end
end, { desc = "Toggle [L]ocation list (current file)" })

local function is_qf_open()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      return true
    end
  end
  return false
end
vim.keymap.set("n", "<leader>ql", function()
  if is_qf_open() then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end, { desc = "Toggle [Q]uickfix list (project)" })

-- Show diagnostic under cursor (floating window)
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Diagnostics: Show error under cursor" })
vim.keymap.set(
  "n",
  "<leader>dl",
  function () vim.diagnostic.setloclist({ open = true }) end,
  { desc = "Diagnostics: Send to loc list" }
)


-- Bracketed Navigation
-- Location list
vim.keymap.set("n", "]l", "<cmd>lnext<CR>", { desc = "Loclist: Next item" })
vim.keymap.set("n", "[l", "<cmd>lprev<CR>", { desc = "Loclist: Previous item" })

-- Quickfix
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { desc = "Quickfix: Next item" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { desc = "Quickfix: Previous item" })

-- diagnostics
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostics: Next issue" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostics: Previous issue" })

-- errors
vim.keymap.set(
	"n",
	"]e",
	function()
	  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	end,
	{ desc = "Diagnostics: Next [E]rror" }
)
vim.keymap.set(
	"n",
	"[e",
	function()
		vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	end,
	{ desc = "Diagnostics: Previous [E]rror" }
)

vim.keymap.set("n", "<leader>qq", function()
  -- Iterate all windows
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)
    local buf_type = vim.api.nvim_buf_get_option(buf, "buftype")
    local win_config = vim.api.nvim_win_get_config(win)

    -- Skip normal buffers
    local is_normal = buf_type == "" or buf_type == "acwrite"

    -- Determine if floating window
    local is_float = win_config.relative ~= ""

    -- Close if not a normal buffer or if floating
    if not is_normal or is_float then
      vim.api.nvim_win_close(win, true)
    end
  end

  -- Also close quickfix and location list explicitly
  if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
    vim.cmd("cclose")
  end
  if vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 then
    vim.cmd("lclose")
  end
end, { desc = "Close all extra windaws (quickfix, loclist, terminal, floats)" })

-- spell
vim.keymap.set("n", "<leader>sp", "<cmd>set spell!<cr>", { desc = "Toggle spell check" })
