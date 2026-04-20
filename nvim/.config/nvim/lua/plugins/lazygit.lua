return {
  'kdheepak/lazygit.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = { 'LazyGit', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
  keys = {
    { '<leader>l', '<cmd>LazyGit<CR>', desc = 'LazyGit' },
  },
  config = function()
    vim.g.lazygit_floating_window_border_chars = { '', '', '', '', '', '', '', '' }

    require('utils.ft').bind_tmux_nav('lazygit')

    local function gen_commit_type(type, should_prompt)
      return function()
        if not should_prompt then
          local keys = vim.api.nvim_replace_termcodes(type .. ': ', true, false, true)
          return vim.api.nvim_feedkeys(keys, 't', false)
        end

        vim.ui.input({ prompt = type .. ' ' }, function(scope)
          if not scope then
            return
          end

          scope = vim.trim(scope)
          local output = scope == '' and type .. ': ' or type .. '(' .. scope:gsub('%s+', '/') .. '): '

          local keys = vim.api.nvim_replace_termcodes(output, true, false, true)
          vim.api.nvim_feedkeys(keys, 't', false)
        end)
      end
    end

    local prefix = '<C-l>'
    local function map_commit_type(key, type)
      vim.keymap.set('t', prefix .. key, gen_commit_type(type, true), { buffer = true })
      vim.keymap.set('t', prefix .. '<C-' .. key .. '>', gen_commit_type(type, true), { buffer = true })
      vim.keymap.set('t', prefix .. key:upper(), gen_commit_type(type, false), { buffer = true })
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'lazygit',
      callback = function()
        vim.keymap.set('c', '<C-k>', '<C-c>', { buffer = true })
        vim.keymap.set('t', prefix .. '<Esc>', '<Nop>', { buffer = true })
        vim.keymap.set('t', prefix .. '<C-k>', '<Nop>', { buffer = true })

        map_commit_type('n', 'feat')
        map_commit_type('f', 'fix')
        map_commit_type('c', 'chore')
        map_commit_type('b', 'build')
        map_commit_type('p', 'perf')
        map_commit_type('r', 'refactor')
        map_commit_type('d', 'docs')
        map_commit_type('t', 'test')
        map_commit_type('s', 'style')
      end,
    })
  end,
}
