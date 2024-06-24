-- AJ:+ gpt/warp coz I don't understand vim scripts/cmds yet
local titleBarWorkingDirectory = ''

local function getFullPath(path)
  local fullpath = ''
  local currFolder = vim.fn.fnamemodify(path, ':t')

  local head = vim.fn.fnamemodify(path, ':h')
  if string.len(head) == 1 then
    local pwd = vim.fn.getcwd()
    fullpath = pwd .. '/' .. path
  else
    fullpath = path
  end
  return fullpath
end

local function getTitle(fullpath)
  local is_dir = vim.fn.isdirectory(fullpath) == 1
  -- Remove the filename if the path is not a directory
  if not is_dir then
    fullpath = vim.fn.fnamemodify(fullpath, ':h')
  end

  -- Get the last two folders
  local parent_folder = vim.fn.fnamemodify(fullpath, ':h:t')
  local current_folder = vim.fn.fnamemodify(fullpath, ':t')

  return parent_folder .. ' :: ' .. current_folder .. '/'
end

local function set_title()
  vim.o.title = true
  local arg = vim.fn.argv(0)
  if arg == nil then
    return
  end

  local argIsDir = vim.fn.isdirectory(arg)
  -- nvim {{dirName}}
  -- dirname can be . or the sub-folder name we want to open
  -- in both cases, we put the current working directory as the
  -- current folder if . - `nvim .`
  -- subfolder if subfolder name was provided - `nvim folderName`
  -- local currWorkingDir, current_folder, parent_folder = '', '', ''
  local title = ''
  local fullPath = getFullPath(arg)
  title = getTitle(fullPath)

  if argIsDir == 1 then
    print('Dir opened, title set to =>' .. title)
    vim.cmd.cd(fullPath)
    print('PWD: ' .. fullPath)
  else
    print('File opened, title set to => ' .. title)
    print('PWD: ' .. vim.fn.getcwd())
  end
  titleBarWorkingDirectory = title
  vim.o.titlestring = title
end

vim.api.nvim_create_autocmd('VimEnter', {
  callback = set_title,
})

local function addToTitle()
  local filename = vim.fn.expand '%'
  vim.o.titlestring = titleBarWorkingDirectory .. filename
end

vim.api.nvim_create_autocmd('BufEnter', {
  callback = addToTitle,
})
