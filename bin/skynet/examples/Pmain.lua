local skynet = require "skynet"

  skynet.start(function()
    skynet.error("[Pmain] start")

    local ping1 = skynet.newservice("ping")
    local ping2 = skynet.newservice("ping")

    skynet.send(ping1, "lua", "start",
		ping2)

    skynet.exit()
  end)

+++
[:00000002] LAUNCH snlua bootstrap
[:00000002] lua loader error : /tmp/babel-MzniTA/skynet-src-QgbVR4.lua:2: attempt to call a nil value (field 'register')
stack traceback:
	/tmp/babel-MzniTA/skynet-src-QgbVR4.lua:2: in local 'main'
	./lualib/loader.lua:50: in main chunk
[:00000002] KILL self
local skynet = require "skynet"

local CMD = {}

function CMD.start(source, target)
    skynet.send(target, "lua", "ping",
		1)
end

function CMD.ping(source, count)
    local id = skynet.self()
    skynet.error("["..id.."] recv ping count="..count)
    skynet.sleep(100)

    skynet.send(source, "lua", "ping", count+1)
end


skynet.start(function()
    skynet.dispatch("lua", function(session, source, cmd, ...)
      local f = assert(CMD[cmd]) 
      f(source,...)
    end)
