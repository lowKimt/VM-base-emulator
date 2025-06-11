local VM = {}

VM.COMMANDS = {
    OPCODE_PUSH         = 0x01,
    OPCODE_POP          = 0x02,
    OPCODE_LOG          = 0x03,
    OPCODE_ADD          = 0x04,
    OPCODE_STACK_PUSH   = 0x05,
    OPCODE_STACK_POP    = 0x06,
}   -- Changes: Add stack Opcodes

function VM:new()
    local vm = setmetatable({}, {__index = self})
    vm:reset()
    return vm
end

function VM:reset()
    self.Memory = {}
    self.Memory.Stack = {} -- Finally add stack.
    self.Memory.Registers = {}
end

VM.Handlers = {
    [VM.COMMANDS.OPCODE_PUSH] = function(self, registerIndex, arg)
        self.Memory.Registers[registerIndex] = arg
    end,
    [VM.COMMANDS.OPCODE_POP] = function(self, registerIndex)
        self.Memory.Registers[registerIndex] = 0
    end,
    [VM.COMMANDS.OPCODE_LOG] = function(self, registerIndex)
        print(tostring(self.Memory.Registers[registerIndex]))
    end,
    [VM.COMMANDS.OPCODE_STACK_PUSH] = function(self, _, arg)        --] PUSH STACK
        table.insert(self.Memory.Stack, arg)
    end,
    [VM.COMMANDS.OPCODE_STACK_POP] = function(self, registerIndex)  --] POP  STACK
        local value = table.remove(self.Memory.Stack)
        if value == nil then error("Stack underflow! on sPOP") end
        self.Memory.Registers[registerIndex] = value
    end,
    [VM.COMMANDS.OPCODE_ADD] = function (self)  -- ADD function
        local a = table.remove(self.Memory.Stack)
        local b = table.remove(self.Memory.Stack)
        if not a or not b then error("Stack Underflow on ADD!") end
        table.insert(self.Memory.Stack, a + b)
    end
} -- Changes: Enabling Stack OPCodes

function VM:exec(command, registerIndex, arg)
    local handler = self.Handlers[command]
    if not handler then
        error("Command does not exist: " .. tostring(command)) -- Proper error return
    end
    handler(self, registerIndex, arg)
end

return VM