local function opencwdRecentFiles()
  local cwd = vim.fn.getcwd()
  require('telescope.builtin').oldfiles {
    cwd = cwd,
    prompt_title = 'Recent Files in /' .. vim.fn.fnamemodify(cwd, ':t'),
    file_ignore_patterns = { '%.git/', '%.cache/' },
  }
end
vim.keymap.set('n', '<leader>.', opencwdRecentFiles, { desc = '[.]Recent Files, Curr.WorkDir' })
return {
  opencwdRecentFiles = opencwdRecentFiles
}