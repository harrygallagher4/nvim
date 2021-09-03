local lush = require'lush'
local hsluv = require'hsluv'
local deg, rad = math.deg, math.rad

local function linearTween(start, stop)
    return function (i)
        return (((stop - start) * i) + start)
    end
end

local function radialTween(start, stop)
    start = rad(start)
    stop = rad(stop)

    local delta = math.atan2(math.sin(stop - start), math.cos(stop - start))
    return function(i)
        return ((deg(start + (delta * i)) + 360) % 360)
    end
end

local function blend_hsluv(start, stop, ratio)
    ratio = ratio or 0.5

    local h = radialTween(start[1], stop[1])
    local s = linearTween(start[2], stop[2])
    local l = linearTween(start[3], stop[3])

    return {h(ratio), s(ratio), l(ratio)}
end

local function blend(start, stop, ratio)
    local c1 = hsluv.hex_to_hsluv(start.hex)
    local c2 = hsluv.hex_to_hsluv(stop.hex)

    local mix = blend_hsluv(c1, c2, ratio)
    return lush.hsl(hsluv.hsluv_to_hex(mix))
end

local function blend_hex(start, stop, ratio)
    local c1 = hsluv.hex_to_hsluv(start)
    local c2 = hsluv.hex_to_hsluv(stop)

    local mix = blend_hsluv(c1, c2, ratio)
    return hsluv.hsluv_to_hex(mix)
end

local function fader(base)
    return function(color, ratio)
        return blend(color, base, ratio)
    end
end


return {
    blend_hsluv = blend_hsluv,
    blend_hex = blend_hex,
    blend = blend,
    fader = fader
}
