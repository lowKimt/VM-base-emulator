local VM = {}

VM.COMMANDS = {
    OPCODE_PUSH = 0x01,
    OPCODE_POP  = 0x02,
    OPCODE_LOG  = 0x03
}   -- Changes: Replace single numbers with named Opcode(s)

function VM:new()
    local vm = setmetatable({}, {__index = self})
    vm:reset()
    return vm
end

function VM:reset()
    self.Memory = {}
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
    end
}

function VM:exec(command, registerIndex, arg)
    local handler = self.Handlers[command]
    if not handler then
        error("Command does not exist: " .. tostring(command)) -- Proper error return
    end
    handler(self, registerIndex, arg)
end

return VM