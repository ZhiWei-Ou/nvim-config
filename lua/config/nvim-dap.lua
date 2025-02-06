local dap = require('dap')
if os == "macOS" then
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
