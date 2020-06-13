local _0_0 = nil
do
  local name_23_0_ = "conjure.client.janet.netrepl.transport"
  local loaded_23_0_ = package.loaded[name_23_0_]
  local module_23_0_ = nil
  if ("table" == type(loaded_23_0_)) then
    module_23_0_ = loaded_23_0_
  else
    module_23_0_ = {}
  end
  module_23_0_["aniseed/module"] = name_23_0_
  module_23_0_["aniseed/locals"] = (module_23_0_["aniseed/locals"] or {})
  module_23_0_["aniseed/local-fns"] = (module_23_0_["aniseed/local-fns"] or {})
  package.loaded[name_23_0_] = module_23_0_
  _0_0 = module_23_0_
end
local function _1_(...)
  _0_0["aniseed/local-fns"] = {require = {a = "conjure.aniseed.core", bit = "bit", str = "conjure.aniseed.string"}}
  return {require("conjure.aniseed.core"), require("bit"), require("conjure.aniseed.string")}
end
local _2_ = _1_(...)
local a = _2_[1]
local bit = _2_[2]
local str = _2_[3]
do local _ = ({nil, _0_0, {{}, nil}})[2] end
local encode = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function encode0(msg)
      local n = a.count(msg)
      return (string.char(bit.band(n, 255), bit.band(bit.rshift(n, 8), 255), bit.band(bit.rshift(n, 16), 255), bit.band(bit.rshift(n, 24), 255)) .. msg)
    end
    v_23_0_0 = encode0
    _0_0["encode"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["encode"] = v_23_0_
  encode = v_23_0_
end
local split = nil
do
  local v_23_0_ = nil
  local function split0(chunk)
    local b0, b1, b2, b3 = string.byte(chunk, 1, 4)
    return bit.bor(bit.band(b0, 255), bit.lshift(bit.band(b1, 255), 8), bit.lshift(bit.band(b2, 255), 16), bit.lshift(bit.band(b3, 255), 24)), string.sub(chunk, 5)
  end
  v_23_0_ = split0
  _0_0["aniseed/locals"]["split"] = v_23_0_
  split = v_23_0_
end
local decoder = nil
do
  local v_23_0_ = nil
  do
    local v_23_0_0 = nil
    local function decoder0()
      local awaiting = nil
      local buffer = ""
      local function reset()
        awaiting = nil
        buffer = ""
        return nil
      end
      local function decode(chunk, acc)
        local acc0 = (acc or {})
        if awaiting then
          local before = a.count(buffer)
          local seen = a.count(chunk)
          buffer = (buffer .. chunk)
          if (seen > awaiting) then
            local consumed = string.sub(buffer, 1, (before + awaiting))
            local next_chunk = string.sub(chunk, a.inc(awaiting))
            table.insert(acc0, consumed)
            reset()
            return decode(next_chunk, acc0)
          elseif (seen == awaiting) then
            table.insert(acc0, buffer)
            reset()
            return acc0
          else
            awaiting = (awaiting - seen)
            return acc0
          end
        else
          local n, rem = split(chunk)
          awaiting = n
          return decode(rem, acc0)
        end
      end
      return decode
    end
    v_23_0_0 = decoder0
    _0_0["decoder"] = v_23_0_0
    v_23_0_ = v_23_0_0
  end
  _0_0["aniseed/locals"]["decoder"] = v_23_0_
  decoder = v_23_0_
end
return nil