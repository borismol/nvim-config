return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      -- Optional: require('telescope').setup({}) goes here if you have custom settings

      -- Your keymaps go right here:
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

      local sorters = require('telescope.sorters')
      vim.keymap.set('n', '<leader>fe', function()
        builtin.current_buffer_fuzzy_find({
          sorter = sorters.get_substr_matcher({})
        })
      end, { desc = '[F]ind [E]xact word in current buffer' })
    end
}
