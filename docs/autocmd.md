# Neovim Autocmd 事件参考

Neovim 的 Autocommand（自动命令）允许您在特定事件发生时自动执行命令。这是实现 Neovim 高度自动化和个性化配置的核心功能，对于插件开发尤其重要。

当定义一个 Autocommand 时，通常使用以下结构：

```lua
-- 使用 Lua API
vim.api.nvim_create_autocmd("EVENT_NAME", {
  group = "MyGroupName", -- 使用组来方便地管理一组相关的自动命令
  pattern = "*.lua",   -- 仅当事件在匹配此模式的文件上发生时触发
  desc = "A short description of what this does.", -- 描述
  callback = function(args)
    -- 当事件发生时要执行的函数
    -- args 是一个包含事件信息的表，例如：
    -- args.buf: 缓冲区编号
    -- args.file: 文件名
    -- args.match: 匹配的模式
    print("Event " .. args.event .. " triggered on " .. args.file)
  end,
})
```

以下是 Neovim 中常用 `autocmd` 事件的列表及其适用场景。

## Autocmd 事件列表

| 事件 (Event) | 触发时机 (Trigger) | 适用场景 / 备注 (Use Case / Notes) |
| :--- | :--- | :--- |
| **`BufNewFile`** | 开始编辑一个不存在的新文件时 | 为新文件设置模板、初始内容或特定的选项。 |
| **`BufReadPre`** | 从文件读取内容到缓冲区之前 | 设置二进制模式（`set bin`）等，用于处理特殊文件格式。 |
| **`BufRead`** / **`BufReadPost`** | 将文件内容读入缓冲区之后 | 文件加载后执行操作，如跳转到上次光标位置、折叠代码、语法高亮调整等。`BufReadPost` 在 `BufRead` 之后触发。 |
| **`BufWritePre`** | 将缓冲区内容写入文件之前 | 保存前自动格式化代码（LSP astyle）、移除行尾多余空格等。 |
| **`BufWritePost`** | 将缓冲区内容写入文件之后 | 保存后执行操作，如编译文件、重新加载服务、同步文件到别处等。 |
| **`BufEnter`** | 进入一个缓冲区时 | 为特定缓冲区设置局部选项 (`setlocal`)、键位映射 (`map <buffer>`)。 |
| **`BufLeave`** | 离开一个缓冲区时 | 清理为特定缓冲区设置的局部设置或状态。 |
| **`BufDelete`** / **`BufWipeout`** | 缓冲区从缓冲区列表中删除时 | 清理与该缓冲区相关的插件状态或资源。`BufWipeout` 会彻底删除所有信息。 |
| **`FileType`** | 'filetype' 选项被设置时 | 最常用的事件之一。用于为特定文件类型设置专属的选项、缩进、键位映射等。 |
| **`Syntax`** | 'syntax' 选项被设置时 | 当语法高亮方案确定后进行调整或执行相关操作。 |
| **`InsertEnter`** | 进入插入模式时 | 在进入插入模式时更改状态栏外观、设置输入法状态等。 |
| **`InsertLeave`** | 离开插入模式时 | 在离开插入模式时恢复状态栏、关闭拼写检查等。 |
| **`TextChanged`** | 在普通模式下文本发生改变时 | 用于实现如 Git Gutter（文件变动提示）等需要实时响应文本变化的功能。 |
| **`TextChangedI`** | 在插入模式下文本发生改变时 | 用于触发自动补全、语法检查、实时预览（如 Markdown）等。 |
_**`TextChangedP`**_ | _在插入模式下文本改变且补全菜单可见时_ | _针对补全过程中的文本变化执行特殊逻辑。_ |
| **`TextYankPost`** | 复制或删除文本之后 | 高亮刚复制的区域、将复制内容发送到系统剪贴板之外的其他地方。 |
| **`VimEnter`** | Neovim 完成所有启动过程后 | 执行只需在启动时运行一次的插件初始化、服务启动等操作。 |
| **`VimLeavePre`** | 退出 Neovim 之前 | 在退出前保存会话、清理临时文件或停止后台服务。 |
| **`VimResized`** | Neovim 窗口大小改变后 | 重新绘制 UI 元素，如状态栏、Win-bar 等，以适应新窗口大小。 |
| **`CursorHold`** | 在普通模式下光标停止移动一段时间后 | 当用户暂停操作时，触发后台任务，如 LSP 的诊断信息更新、显示光标处符号的文档。 |
| **`CursorHoldI`** | 在插入模式下光sor停止移动一段时间后 | 类似 `CursorHold`，但用于插入模式，如触发签名帮助 (Signature Help)。 |
| **`CursorMoved`** | 光标在普通模式或可视模式下移动后 | 实时更新光标位置相关的 UI，例如高亮当前函数上下文。 |
| **`WinEnter`** | 进入一个窗口时 | 设置窗口局部选项 (`set winlocal`)，或根据窗口类型调整其外观。 |
| **`WinLeave`** | 离开一个窗口时 | 清理窗口局部设置。 |
| **`TabEnter`** | 进入一个标签页 (Tab) 时 | 更新标签栏 UI，或根据标签页内容设置特定状态。 |
| **`QuickFixCmdPre`** | Quickfix 命令（如 `:make`, `:grep`）执行前 | 在执行 Quickfix 命令前进行准备工作，例如设置编译器参数。 |
| **`QuickFixCmdPost`** | Quickfix 命令执行后 | 在 Quickfix 列表生成后自动打开 Quickfix 窗口、或对结果进行过滤。 |
| **`TermOpen`** | 终端缓冲区被创建时 | 配置终端环境，如设置 shell、环境变量、终端特定的键位映射。 |
| **`TermClose`** | 终端任务结束时 | 在终端关闭后执行清理或报告任务。 |
| **`CmdlineEnter`** | 进入命令行模式时 | 自定义命令行外观或行为。 |
| **`CmdlineLeave`** | 离开命令行模式时 | 清理或恢复命令行的自定义设置。 |
| **`User`** | 由 `:doautocmd User <pattern>` 手动触发时 | 用于插件内部或插件之间通信，定义自定义事件。开发者可以定义自己的事件，如 `User MyPluginStart`。 |

---
**注意:**
*   频繁触发的事件 (如 `CursorMoved`, `TextChangedI`) 中的回调函数应尽可能高效，避免造成编辑器卡顿。
*   使用 `autocmd` 组 (`augroup`) 来组织您的自动命令，并在每次重载配置时先用 `au!` 清除组内所有命令，可以防止重复定义。