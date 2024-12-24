local dap = require('dap')
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb', -- adjust as needed, must be absolute path
  name = 'lldb'
}
