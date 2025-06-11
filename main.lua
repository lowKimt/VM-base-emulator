local VM = require("src.vm")

local vm = VM:new()

-- Memory Index 0 = 10
vm:exec(VM.COMMANDS.OPCODE_PUSH, 0, 10)

-- Print Index 0 (10)
vm:exec(VM.COMMANDS.OPCODE_LOG, 0)

-- POP Index 0 (to 0)
vm:exec(VM.COMMANDS.OPCODE_POP, 0)

-- Print Index 0 (0)
vm:exec(VM.COMMANDS.OPCODE_LOG, 0)
