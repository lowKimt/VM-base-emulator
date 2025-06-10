local VM = require("src/vm")

local vm = VM:new()

-- Memory Index 0 = 10
vm:exec(0x01, 10)

-- Print Index 0 (10)
vm:exec(0x03)

-- POP Index 0 (to 0)
vm:exec(0x02)

-- Print Index 0 (0)
vm:exec(0x03)
