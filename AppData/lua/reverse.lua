--[[
reverse_lookup_filter: 依地球拼音为候选项加上带调拼音的注释
本例说明了环境的用法。
--]]

-- 帮助函数（可跳过）
local function xform_py(inp)
   if inp == "" then return "" end
   inp = string.gsub(inp, "([aeiou])(ng?)([1234])", "%1%3%2")
   inp = string.gsub(inp, "([aeiou])(r)([1234])", "%1%3%2")
   inp = string.gsub(inp, "([aeo])([iuo])([1234])", "%1%3%2")

   inp = string.gsub(inp, "a1", "ā")
   inp = string.gsub(inp, "a2", "á")
   inp = string.gsub(inp, "a3", "ǎ")
   inp = string.gsub(inp, "a4", "à")
-- 增加加重音调a5音支持，注音有第五个音调，如：'啊'有5个音，其中一个'a5'（注音是˙ㄚ），声调除了1234声外，还额外有一个加重音调。
   inp = string.gsub(inp, "a5", "a")

   inp = string.gsub(inp, "e1", "ē")
   inp = string.gsub(inp, "e2", "é")
   inp = string.gsub(inp, "e3", "ě")
   inp = string.gsub(inp, "e4", "è")
-- 增加加重音调e5音支持，注音有第五个音调，如：'么'(繁体字和异体字是麽）的'me5'音（注音是˙ㄇㄜ）。
   inp = string.gsub(inp, "e5", "e")

   inp = string.gsub(inp, "o1", "ō")
   inp = string.gsub(inp, "o2", "ó")
   inp = string.gsub(inp, "o3", "ǒ")
   inp = string.gsub(inp, "o4", "ò")
-- 增加加重音调o5音支持，注音有第五个音调，如：'卜'(繁体字和异体字是'蔔'）的'bo5'音（注音是˙ㄅㄛ）。
   inp = string.gsub(inp, "o5", "o")

   inp = string.gsub(inp, "i1", "ī")
   inp = string.gsub(inp, "i2", "í")
   inp = string.gsub(inp, "i3", "ǐ")
   inp = string.gsub(inp, "i4", "ì")
-- 增加加重音调i5音支持，注音有第五个音调，如：'哩'(异体字是'唎'）的'li5'音（注音是˙ㄌ一）。
   inp = string.gsub(inp, "i5", "i")

   inp = string.gsub(inp, "u1", "ū")
   inp = string.gsub(inp, "u2", "ú")
   inp = string.gsub(inp, "u3", "ǔ")
   inp = string.gsub(inp, "u4", "ù")
-- 增加加重音调u5音支持，注音有第五个音调，如：'頭'的'tou5'音（注音是˙ㄊㄡ）。
   inp = string.gsub(inp, "u5", "u")

   inp = string.gsub(inp, "v1", "ǖ")
   inp = string.gsub(inp, "v2", "ǘ")
   inp = string.gsub(inp, "v3", "ǚ")
   inp = string.gsub(inp, "v4", "ǜ")

-- 增加加重音调n5音支持，注音有第五个音调，如：'嗯'的'en5'音（注音是˙ㄊㄡ）。
   inp = string.gsub(inp, "n5", "n")

-- 增加加重音调g5音支持，注音有第五个音调，如：'裳'(异体字是'常'）的'shang5'音（注音是˙ㄕㄤ）。
   inp = string.gsub(inp, "g5", "g")

   inp = string.gsub(inp, "([nljqxy])v", "%1ü")
   inp = string.gsub(inp, "eh[0-5]?", "ê")
   return "(" .. inp .. ")"
end

local function reverse_lookup_filter(input, pydb)
   for cand in input:iter() do
      cand:get_genuine().comment = cand.comment .. " " .. xform_py(pydb:lookup(cand.text))
      yield(cand)
   end
end

--[[
如下，filter 除 `input` 外，可以有第二个参数 `env`。
--]]
local function filter(input, env)
   --[[ 从 `env` 中拿到拼音的反查库 `pydb`。
        `env` 是一个表，默认的属性有（本例没有使用）：
          - engine: 输入法引擎对象
          - name_space: 当前组件的实例名
        `env` 还可以添加其他的属性，如本例的 `pydb`。
   --]]
   reverse_lookup_filter(input, env.pydb)
end

--[[
当需要在 `env` 中加入非默认的属性时，可以定义一个 init 函数对其初始化。
--]]
local function init(env)
   -- 当此组件被载入时，打开反查库，并存入 `pydb` 中
   -- env.pydb = ReverseDb("build/pinyin_simp.reverse.bin")
   -- env.pydb = ReverseDb("build/terra_pinyin.reverse.bin")
   env.pydb = ReverseDb("lua/terra_pinyin.reverse.bin")
end

--[[ 导出带环境初始化的组件。
需要两个属性：
 - init: 指向初始化函数
 - func: 指向实际函数
--]]
return { init = init, func = filter }