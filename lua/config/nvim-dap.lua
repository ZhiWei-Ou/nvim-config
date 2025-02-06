local dap = require('dap')
print("--os:", os)
if vim.loop.os_uname().sysname == "Darwin" then
    dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb', -- adjust as needed, must be absolute path
        name = 'lldb'
    }
else
    dap.adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/gdb', -- adjust as needed, must be absolute path
        name = 'gdb'
    }
end
