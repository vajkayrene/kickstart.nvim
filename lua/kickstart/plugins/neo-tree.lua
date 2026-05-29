-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

---@module 'lazy'
---@type LazySpec
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  config = function()
      -- 1. Run Setup explicitly 
      require('neo-tree').setup({
        window = {
          winoptions = {
            number = true,         -- Force absolute numbers
            relativenumber = false, -- Change to true if you prefer relative numbers
          },
        },
        filesystem = {
          window = {
            mappings = {
              ['\\'] = 'close_window',
            },
          },
        },
      })
  
      -- 2. Global fallback API hook to force it if Neo-tree's internal UI engine fails to paint it
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'neo-tree',
        callback = function()
          vim.opt_local.number = true
          vim.opt_local.signcolumn = 'yes' -- Ensures space for numbers isn't collapsed
        end,
      })
    end,
}
