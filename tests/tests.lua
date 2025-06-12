-- Case 1
local VM = require(".src.vm")

local vm = VM:new()

-- spush 5, spush 10, add, spush 200, spush 5, div
vm:exec(vm.COMMANDS.OPCODE_STACK_PUSH, nil, 5)
vm:exec(vm.COMMANDS.OPCODE_STACK_PUSH, nil, 10)
vm:exec(vm.COMMANDS.OPCODE_ADD)
vm:exec(vm.COMMANDS.OPCODE_STACK_PUSH, nil, 200)
vm:exec(vm.COMMANDS.OPCODE_STACK_PUSH, nil, 2)
vm:exec(vm.COMMANDS.OPCODE_DIV)
-- spop [1], spop [2], log [1], log [2]
vm:exec(vm.COMMANDS.OPCODE_STACK_POP, 1)
vm:exec(vm.COMMANDS.OPCODE_STACK_POP, 2)
vm:exec(vm.COMMANDS.OPCODE_LOG, 1)
vm:exec(vm.COMMANDS.OPCODE_LOG, 2)