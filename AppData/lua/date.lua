--[[
date_translator: 将 `date` 翻译为当前日期
translator 的功能是将分好段的输入串翻译为一系列候选项。
欲定义的 translator 包含三个输入参数：
 - input: 待翻译的字符串
 - seg: 包含 `start` 和 `_end` 两个属性，分别表示当前串在输入框中的起始和结束位置
 - env: 可选参数，表示 translator 所处的环境（本例没有体现）
translator 的输出是若干候选项。
与通常的函数使用 `return` 返回不同，translator 要求您使用 `yield` 产生候选项。
`yield` 每次只能产生一个候选项。有多个候选时，可以多次使用 `yield` 。
请看如下示例：
--]]

local function rqzdx2(a)
   -- 日期转大写2
   -- 贰零零玖年零陆月贰拾叁日
   --a=1(贰零壹玖年)、2(零陆月)、3(贰拾叁日)、12(贰零壹玖年零陆月)、23(零陆月贰拾叁日)、其它为(贰零壹玖年零陆月贰拾叁日)
   result = ""
   number = {[0] = "零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖", "拾"}
   year0 = os.date("%Y")

   for i = 0, 9 do
      year0 = string.gsub(year0, i, number[i])
   end

   -- for i= 1, 4 do

   -- year0=  string.gsub(year0,string.sub(year0,i,1),number[string.sub(year0,i,1)*1])
   -- end

   monthnumber = {[0] = "零", "零壹", "零贰", "零叁", "零肆", "零伍", "零陆", "零柒", "零捌", "零玖", "零壹拾", "壹拾壹", "壹拾贰"}
   month0 = monthnumber[os.date("%m") * 1]

   daynumber = {
      [0] = "零",
      "零壹",
      "零贰",
      "零叁",
      "零肆",
      "零伍",
      "零陆",
      "零柒",
      "零捌",
      "零玖",
      "零壹拾",
      "壹拾壹",
      "壹拾贰",
      "壹拾叁",
      "壹拾肆",
      "壹拾伍",
      "壹拾陆",
      "壹拾柒",
      "壹拾捌",
      "壹拾玖",
      "贰拾",
      "贰拾壹",
      "贰拾贰",
      "贰拾叁",
      "贰拾肆",
      "贰拾伍",
      "贰拾陆",
      "贰拾柒",
      "贰拾捌",
      "贰拾玖",
      "叁拾",
      "叁拾壹"
   }
   day0 = daynumber[os.date("%d") * 1]

   if a == 1 then
      result = year0 .. "年"
   elseif a == 2 then
      result = month0 .. "月"
   elseif a == 3 then
      result = day0 .. "日"
   elseif a == 12 then
      result = year0 .. "年" .. month0 .. "月"
   elseif a == 23 then
      result = month0 .. "月" .. day0 .. "日"
   else
      result = year0 .. "年" .. month0 .. "月" .. day0 .. "日"
   end
   return result
end

local function rqzdx1(a)
   -- 日期转大写1
   --a=1(二〇一九年)、2(六月)、3(二十三日)、12(二〇一九年六月)、23(六月二十三日)、其它为(二〇一九年六月二十三日)
   -- 二〇一九年六月二十三日
   result = ""
   number = {[0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九"}
   year0 = os.date("%Y")
   for i = 0, 9 do
      year0 = string.gsub(year0, i, number[i])
   end

   monthnumber = {[0] = "〇", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"}
   month0 = monthnumber[os.date("%m") * 1]

   daynumber = {
      [0] = "〇",
      "一",
      "二",
      "三",
      "四",
      "五",
      "六",
      "七",
      "八",
      "九",
      "十",
      "十一",
      "十二",
      "十三",
      "十四",
      "十五",
      "十六",
      "十七",
      "十八",
      "十九",
      "二十",
      "二十一",
      "二十二",
      "二十三",
      "二十四",
      "二十五",
      "二十六",
      "二十七",
      "二十八",
      "二十九",
      "三十",
      "三十一"
   }
   day0 = daynumber[os.date("%d") * 1]

   if a == 1 then
      result = year0 .. "年"
   elseif a == 2 then
      result = month0 .. "月"
   elseif a == 3 then
      result = day0 .. "日"
   elseif a == 12 then
      result = year0 .. "年" .. month0 .. "月"
   elseif a == 23 then
      result = month0 .. "月" .. day0 .. "日"
   else
      result = year0 .. "年" .. month0 .. "月" .. day0 .. "日"
   end
   return result
end

local function translator(input, seg)
   -- 如果输入串为 `date` 则翻译
   if (input == "date" or input == "rq") then
      yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), " 日期短格式"))
      yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), " 日期长格式"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(), " 日期大写"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(), " 会计日期大写"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(1), " 年大写"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(1), " 会计年大写"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(2), " 月份大写"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(2), " 会计月份大写"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(3), " 天大写"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(3), " 会计天大写"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(12), " 年月大写"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(12), " 会计年月大写"))
      yield(Candidate("date", seg.start, seg._end, rqzdx1(23), " 月天大写"))
      yield(Candidate("date", seg.start, seg._end, rqzdx2(23), " 会计月天大写"))
   end
end

-- 将上述定义导出
return translator
