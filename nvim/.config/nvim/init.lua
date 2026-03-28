require 'opts'
require 'keymaps'
require 'commands'

-- Diagnostic Config & Keymaps
vim.diagnostic.config({ virtual_text = true })

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup("plugins", {
  ui = {
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

vim.opt.spell = true
vim.opt.spelllang = { 'en_us' } -- Set your preferred language (e.g., 'en_gb', 'de')
vim.opt.spelloptions:append('camel') -- This option enables spell-checking of words within CamelCase identifiers.
-- Apply to all buffers on load
vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    vim.opt_local.syntax = "on"
  end,
})
