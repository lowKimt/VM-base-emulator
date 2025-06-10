# Lua Virtual Machine (VM)

A lightweight stack-based virtual machine implemented in Lua. This VM provides basic operations for register manipulation and logging.

## Features
- Register-based memory operations
- Extensible opcode system
- Simple API for execution
- Error handling for invalid commands

## Installation
1. Clone the repository:
```bash
git clone https://github.com/yourusername/lua-vm.git
```
2. Require the VM module in your Lua code:
```lua
local VM = require("src.vm")
```

## Usage
```lua
-- Create VM instance
local vm = VM:new()

-- PUSH value 42 into register 1
vm:exec(VM.COMMANDS.OPCODE_PUSH, 1, 42)

-- LOG value from register 1 (prints 42)
vm:exec(VM.COMMANDS.OPCODE_LOG, 1)

-- POP register 1 (sets to 0)
vm:exec(VM.COMMANDS.OPCODE_POP, 1)
```

## API Reference

### `VM:new()`
Creates a new VM instance.
```lua
local vm = VM:new()
```

### `VM:reset()`
Resets VM memory (clears all registers).
```lua
vm:reset()
```

### `VM:exec(command, registerIndex, arg)`
Executes a VM command.

**Parameters:**
- `command`: Opcode constant (`VM.COMMANDS.*`)
- `registerIndex`: Register index (integer)
- `arg`: Argument value (for PUSH operations)

```lua
vm:exec(VM.COMMANDS.OPCODE_PUSH, 1, 100)
```

### Opcode Reference
| Opcode | Value | Description |
|--------|-------|-------------|
| `OPCODE_PUSH` | 0x01 | Stores value in register |
| `OPCODE_POP` | 0x02 | Clears register value |
| `OPCODE_LOG` | 0x03 | Prints register value |

## Error Handling
Invalid commands will throw an error:
```lua
vm:exec(0xFF, 1) -- Error: "Command does not exist: 255"
```

## License
MIT