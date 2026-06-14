local bin_name = 'http-language-server'
local cmd = { bin_name, '--stdio' }

if vim.fn.has 'win32' == 1 then
  cmd = { 'cmd.exe', '/C', bin_name, '--stdio' }
end

return {
  default_config = {
    cmd = cmd,
    filetypes = { '.http' },
    root_dir = vim.fs.dirname(vim.fs.find({ '.git', '.env' }, { path = './', upward = true })[1]),
    single_file_support = true,
  },
}
