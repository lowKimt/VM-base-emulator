local VM = {}

VM.COMMANDS = {0x01, 0x02, 0x03}

function VM:new()
    local vm = setmetatable({}, {__index = self})
    vm:reset()
    return vm
end

function VM:reset()
    self.Stack = {}
    self.Memory = {}
end

VM.Handlers = {
    [VM.COMMANDS[1]] = function(self, arg)
        self.Memory[0] = arg
    end,
    [VM.COMMANDS[2]] = function(self)
        self.Memory[0] = 0
    end,
    [VM.COMMANDS[3]] = function(self)
        print(tostring(self.Memory[0]))
    end
}

function VM:exec(command, arg)
    local handler = self.Handlers[command]
    if not handler then
        print("Command does not exist: " .. tostring(command))
    end
    handler(self, arg)
end
return VM