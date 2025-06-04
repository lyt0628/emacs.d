require "ytcgtest"
local Vec = require("Vec")
v = Vec.new(1, 2, 3)
assert v:get(2) == 2
