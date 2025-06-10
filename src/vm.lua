local VM = {}

VM.COMMANDS = {0x01, 0x02, 0x03}

-- 0x01 PUSH
-- 0x02 POP
-- 0x03 PRINT/LOG

function VM:new()
    local vm = setmetatable({}, {__index = self})
    vm:reset()
    return vm
end

function VM:reset()
    self.Memory = {}   -- I'll find something to do with this, eventually.
    self.Memory.Registers = {}
end

VM.Handlers = {
    [0x01] = function(self, registerIndex, arg)
        self.Memory.Registers[registerIndex] = arg
    end,
    [0x02] = function(self, registerIndex)
        self.Memory.Registers[registerIndex] = 0
    end,
    [0x03] = function(self, registerIndex)
        print(tostring(self.Memory.Registers[registerIndex]))
    end
}

function VM:exec(command, registerIndex, arg)
    local handler = self.Handlers[command]
    if not handler then
        print("Command does not exist: " .. tostring(command))
        return -- add return
    end
    handler(self, registerIndex, arg)
end
return VM