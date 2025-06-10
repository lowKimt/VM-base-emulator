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
    -- self.Stack = {} -- Unused for now; Do not Delete!
    self.Memory = {}
end

VM.Handlers = {
    -- self.Memory[0] is a placeholder, I will change this to be more flexible.
    [0x01] = function(self, arg)
        self.Memory[0] = arg
    end,
    [0x02] = function(self)
        self.Memory[0] = 0
    end,
    [0x03] = function(self)
        print(tostring(self.Memory[0]))
    end
}

function VM:exec(command, arg)
    local handler = self.Handlers[command]
    if not handler then
        print("Command does not exist: " .. tostring(command))
        return -- add return
    end
    handler(self, arg)
end
return VM