local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end

dap.adapters.cppdbg = {
	id = 'cppdbg',
	type = 'executable',
	command = '/home/abdelrahman/Sources/cpptools/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7'
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
}

dap.configurations.c = dap.configurations.cpp
