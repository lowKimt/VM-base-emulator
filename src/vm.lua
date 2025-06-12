-- VM (Virtual Machine) module for executing bytecode-like commands.
local VM = {}

-- Define operation codes for various VM commands.
VM.COMMANDS = {
    OPCODE_PUSH         = 0x01, -- Push a value into a register.
    OPCODE_POP          = 0x02, -- Pop (clear) a value from a register.
    OPCODE_LOG          = 0x03, -- Log the value of a register to console.
    OPCODE_MUL          = 0x04, -- Multiply two values from the stack.
    OPCODE_DIV          = 0x05, -- Divide two values from the stack.
    OPCODE_ADD          = 0x06, -- Add two values from the stack.
    OPCODE_STACK_PUSH   = 0x07, -- Push a value onto the internal stack.
    OPCODE_STACK_POP    = 0x08, -- Pop a value from the stack into a register.
    OPCODE_PEEK         = 0x09, -- Peek at a value on the stack without removing it.
    OPCODE_STACK_REMOVE_AT = 0x0A, -- Remove a value from a specific stack offset.
}

-- Constructor for creating a new VM instance.
function VM:new()
    local vm = setmetatable({}, {__index = self})
    vm:reset() -- Initialize memory and registers.
    return vm
end

-- Resets the VM's memory, including the stack and registers.
function VM:reset()
    self.Memory = {}
    self.Memory.Stack = {}    -- The primary stack for operations.
    self.Memory.Registers = {} -- General-purpose registers for storing values.
end

-- Handlers for each VM command, defining their execution logic.
VM.Handlers = {
    -- Handles pushing a value into a specified register.
    [VM.COMMANDS.OPCODE_PUSH] = function(self, registerIndex, arg)
        self.Memory.Registers[registerIndex] = arg
    end,
    -- Handles clearing a value from a specified register.
    [VM.COMMANDS.OPCODE_POP] = function(self, registerIndex)
        self.Memory.Registers[registerIndex] = 0
    end,
    -- Handles logging the value of a specified register.
    [VM.COMMANDS.OPCODE_LOG] = function(self, registerIndex)
        print(tostring(self.Memory.Registers[registerIndex]))
    end,
    -- Handles pushing a value onto the stack.
    [VM.COMMANDS.OPCODE_STACK_PUSH] = function(self, _, arg)
        table.insert(self.Memory.Stack, arg)
    end,
    -- Handles popping a value from the stack into a specified register.
    [VM.COMMANDS.OPCODE_STACK_POP] = function(self, registerIndex)
        local value = table.remove(self.Memory.Stack)
        if value == nil then error("Stack underflow! on sPOP") end
        self.Memory.Registers[registerIndex] = value
    end,
    -- Handles adding the top two values from the stack.
    [VM.COMMANDS.OPCODE_ADD] = function (self)
        local a = table.remove(self.Memory.Stack)
        local b = table.remove(self.Memory.Stack)
        if not a or not b then error("Stack Underflow on ADD!") end
        table.insert(self.Memory.Stack, a + b)
    end,
    -- Handles multiplying the top two values from the stack.
    [VM.COMMANDS.OPCODE_MUL] = function(self)
        local a = table.remove(self.Memory.Stack)
        local b = table.remove(self.Memory.Stack)
        if not a or not b then error("Stack Underflow on MUL!") end
        table.insert(self.Memory.Stack, a * b)
    end,
    -- Handles dividing the second-to-top value by the top value from the stack.
    [VM.COMMANDS.OPCODE_DIV] = function(self)
        local a = table.remove(self.Memory.Stack) -- Divisor
        local b = table.remove(self.Memory.Stack) -- Dividend
        if not a or not b then error("Stack Underflow on DIV!") end
        if a == 0 then error("Division by Zero!") end -- Check for division by zero
        table.insert(self.Memory.Stack, b / a) -- Corrected order: dividend / divisor
    end,
    -- Handles peeking at a value on the stack at a given offset.
    [VM.COMMANDS.OPCODE_PEEK] = function(self, registerIndex, stackOffset)
        local index = #self.Memory.Stack - (stackOffset or 0)
        local value = self.Memory.Stack[index]
        if value == nil then error("Invalid PEEK offset: " .. tostring(stackOffset)) end
        self.Memory.Registers[registerIndex] = value
    end,
    -- Handles removing a value from the stack at a given offset.
    [VM.COMMANDS.OPCODE_STACK_REMOVE_AT] = function (self, _, offset)
        local index = #self.Memory.Stack - (offset or 0)
        local removed = table.remove(self.Memory.Stack, index)
        if removed == nil then error("Invalid stack offset on remove: " .. tostring(offset)) end
    end
}

-- Executes a given VM command with optional arguments.
function VM:exec(command, registerIndex, arg)
    local handler = self.Handlers[command]
    if not handler then
        error("Command does not exist: " .. tostring(command)) -- Proper error return
    end
    handler(self, registerIndex, arg)
end

return VM

-- Comments added for readability and explanation of changes.
--
-- Changes Made:
-- 1. Division Bug Fix:
--    - In the `OPCODE_DIV` handler, the order of operands for division was corrected.
--    - Previously, it was `a / b`, where `a` was the top of the stack (divisor) and `b` was the second value (dividend).
--    - It has been changed to `b / a` to correctly perform `dividend / divisor`.
--    - A division by zero check was also added for `a` (the divisor).
--
-- 2. Code Readability:
--    - Added inline comments to `VM.COMMANDS` to briefly explain each opcode's purpose.
--    - Added comments to `VM:new()` and `VM:reset()` functions for clarity.
--    - Added comments to each handler function within `VM.Handlers` to describe their functionality.
--    - Added a comment to the `VM:exec` function.