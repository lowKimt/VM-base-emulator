-- Case 1
local VM = require(".src.vm")

local vm = VM:new()

-- Push 5, Push 10, Add, Pop to Register[1], Log Register[1]
vm:exec(vm.COMMANDS.OPCODE_STACK_PUSH, nil, 5)
vm:exec(vm.COMMANDS.OPCODE_STACK_PUSH, nil, 10)
vm:exec(vm.COMMANDS.OPCODE_ADD)
vm:exec(vm.COMMANDS.OPCODE_STACK_POP, 1)
vm:exec(vm.COMMANDS.OPCODE_LOG, 1)  -- Should print: 15
