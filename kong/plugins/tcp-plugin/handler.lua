
local typedefs = require "kong.db.schema.typedefs"

local plugin = {
  PRIORITY = 1000, -- set the plugin priority, which determines plugin execution order
  VERSION = "0.1",
}

function plugin:init_worker()
  kong.log.err("!!!!!!!!!!!!! TCP init_worker")
  dump(typedefs.protocols)
end

function plugin:certificate(plugin_conf)
end

function plugin:rewrite(plugin_conf)
end

function plugin:preread(plugin_conf)
  kong.log.inspect(plugin_conf)   -- check the logs for a pretty-printed config!

  kong.log.err("!!!!!!!!!!!!! TCP preread")
  dump(typedefs.protocols)


end

function plugin:access(plugin_conf)
  kong.log.inspect(plugin_conf)   -- check the logs for a pretty-printed config!

  kong.log.err("!!!!!!!!!!!!! TCP access")
  dump(typedefs.protocols)
end

function plugin:header_filter(plugin_conf)
end

function plugin:body_filter(plugin_conf)
end

function plugin:log(plugin_conf)
  kong.log.err("!!!!!!!!!!!!! TCP log")
end

dump = function(...)
  local info = debug.getinfo(2) or {}
  local input = { n = select("#", ...), ...}
  local write = require("pl.pretty").write
  local serialized
  if input.n == 1 and type(input[1]) == "table" then
    serialized = "(" .. type(input[1]) .. "): " .. write(input[1])
  elseif input.n == 1 then
    serialized = "(" .. type(input[1]) .. "): " .. tostring(input[1]) .. "\n"
  else
    local n
    n, input.n = input.n, nil
    serialized = "(list, #" .. n .. "): " .. write(input)
  end

  print(ngx.WARN,
          "\027[31m\n",
          "function '", tostring(info.name), ":" , tostring(info.currentline),
          "' in '", tostring(info.short_src), "' wants you to know:\n",
          serialized,
          "\027[0m")
end

return plugin
