---@brief CMake configure, build and run integration
---@refer https://github.com/Civitasv/cmake-tools.nvim

return {
  'Civitasv/cmake-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  enabled = true,
  opts = {
    cmake_regenerate_on_save = false,
    cmake_generate_options = {
      '-DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE',
      '--no-warn-unused-cli',
      '-GUnix Makefiles',
    },
    cmake_build_options = { '-j 10' },
    cmake_build_directory = function()
      return 'build'
    end,
    cmake_kits_path = '~/.local/share/CMakeTools/cmake-tools-kits.json',
    cmake_runner = {
      name = 'terminal',
      opts = {
        name = 'Main Terminal',
      },
    },
  },
}
