-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      local wk = require 'which-key'
      wk.setup()

      -- Document existing key chains

      wk.register {
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        --   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
          ['<leader>d'] = { name = '[D]elete' },
        --   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        -- ['<leader>.'] = { name = '[O]pen recent files', _ = 'which_key_ignore' },
        --   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        --   ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        --   ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
      }
      -- visual mode
      wk.register({
        ['<leader>h'] = { 'Git [H]unk' },
      }, { mode = 'v' })

      -- wk.register {
      --   ['<leader>'] = {
      --     n = {
      --       name = '+file',
      --       f = { '<cmd>Telescope find_files<cr>', 'Find File' },
      --       r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
      --       n = { '<cmd>enew<cr>', 'New File' },
      --     },
      --   },
      -- }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
