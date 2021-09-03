local lush = require'lush'
local util = require'harryg.colorutilsfnl'
local palette = require'melange.colors'.Melange.lush -- this is how melange exposes the palette

local function lcol(c)
    return palette[c]
end
local function hcol(c)
    return palette[c].hex
end
local function pr(c)
    if type(c) == "string" then
    	print(c)
    elseif c.hex ~= nil then
        print(c.hex)
    else
        print(vim.inspect(c))
    end
end

pr''
pr(lcol'red')
pr(lcol'green')

pr''
-- lush: mix two `lush.hsl` colors
-- mine: convert two `lush.hsl` colors to hex, hex to hsluv, transform, hsluv
-------- to hex, hex to `lush.hsl` color
pr(lcol'red'.mix(lcol'green', 50))
pr(util['blend-lush'](lcol'red', lcol'green', 0.5))

pr''
-- lush: mix two `lush.hsluv` colors
-- mine: convert two hex colors to hsluv, transform, convert back
pr(lush.hsluv(hcol'red').mix(lush.hsluv(hcol'green'), 50))
print(util['blend-hex'](hcol'red', hcol'green', 0.5))

