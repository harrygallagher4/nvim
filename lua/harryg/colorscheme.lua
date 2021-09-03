local nvim = require'nvim'
local lush = require'lush'
local melange = require'melange.init'
local _ = melange
local c = melange.Melange.lush
local hsl = lush.hsl
local blend = require'harryg.colorutils'.blend

-- GUI options
local NONE = 'NONE'
local bf, it, un = 'bold', 'italic', 'underline'

local bg     = c.bg
local overbg = c.overbg
local faded  = c.faded

-- Foregrounds
local mid    = c.mid
local drop   = c.drop
local fg     = c.fg

-- Color palette
local red     = c.red
local salmon  = c.salmon
local orange  = c.orange
local amber   = c.amber
local yellow  = c.yellow

local green   = c.green
local teal    = c.teal
local cyan    = c.cyan

local blue    = c.blue
local purple  = c.purple
local magenta = c.magenta

local function sample(color) return {fg=color,lush={swatch=true}} end

local function fade(color, r)
    return (blend(color, overbg, r))
end

local spec = lush.extends({ melange }).with(function() return {
    -- Bases
    sample_bg_xxxxxxxxxx (sample(bg.li(1))), -- sample_bg_xxxxxxxxxx{
    sample_overbg_xxxxxx (sample(overbg)), -- sample_overbg_xxxxxx{
    sample_faded_xxxxxxx (sample(faded)), -- sample_faded_xxxxxxx{
    sample_mid_xxxxxxxxx (sample(mid)), -- sample_mid_xxxxxxxxx{
    sample_drop_xxxxxxxx (sample(drop)), -- sample_drop_xxxxxxxx{
    sample_fg_xxxxxxxxxx (sample(fg)), -- sample_fg_xxxxxxxxxx{
    -- Colors
    sample_red_xxxxxxxxx (sample(red)), -- sample_red_xxxxxxxxx{
    sample_salmon_xxxxxx (sample(salmon)), -- sample_salmon_xxxxxx{
    sample_orange_xxxxxx (sample(orange)), -- sample_orange_xxxxxx{
    sample_amber_xxxxxxx (sample(amber)), -- sample_amber_xxxxxxx{
    sample_yellow_xxxxxx (sample(yellow)), -- sample_yellow_xxxxxx{
    sample_green_xxxxxxx (sample(green)), -- sample_green_xxxxxxx{
    sample_teal_xxxxxxxx (sample(teal)), -- sample_teal_xxxxxxxx{
    sample_cyan_xxxxxxxx (sample(cyan)), -- sample_cyan_xxxxxxxx{
    sample_blue_xxxxxxxx (sample(blue)), -- sample_blue_xxxxxxxx{
    sample_purple_xxxxxx (sample(purple)), -- sample_purple_xxxxxx{
    sample_magenta_xxxxx (sample(magenta)), -- sample_magenta_xxxxx{

    Normal      { fg=fg, bg=bg },
    NormalNC    { Normal },
    CursorLine  { melange.CursorLine, bg=NONE },
    VertSplit   { fg=faded, bg=NONE },
    NormalFloat { fg=blend(amber, fg, 2/3) },
    FloatBorder { fg=drop, bg=NONE },

    LspFloatWinBorder { FloatBorder },
    LspFloatWinNormal { NormalFloat },
    MsgArea     { NormalFloat },

    Pmenu       { fg=blend(amber, fg, 2/3), bg=blend(amber, bg, 11/12) },
    PmenuSel    { bg=blend(amber, bg, 1/9), fg=bg },
    PmenuThumb  { bg=blend(amber, bg, 1/9) },
    PmenuSbar   { bg=blend(amber, bg, 2/3) },

    IndentBlanklineChar         { fg=blend(amber, overbg, 11/12) },
    IndentBlanklineContextChar  { fg=blend(amber, overbg, 1/3) },
    NonText                     { fg=blend(amber, overbg, 2/3) },

    lsperror        { fg=salmon },
    lspwarning      { fg=yellow },
    lspinformation  { fg=fade(fg, 0.1) },
    lsphint         { fg=blue },
    lsperrorf       { fg=fade(salmon, 0.4) },
    lspwarningf     { fg=fade(yellow, 0.4) },
    lspinformationf { fg=drop },
    lsphintf        { fg=fade(blue, 0.4) },
    LspDiagnosticsDefaultError          { fg=fade(salmon, 0.4) },
    LspDiagnosticsDefaultWarning        { fg=fade(yellow, 0.4) },
    LspDiagnosticsDefaultInformation    { fg=drop },
    LspDiagnosticsDefaultHint           { fg=fade(blue, 0.4) },
    LspDiagnosticsVirtualTextError          { LspDiagnosticsDefaultError, gui='italic' },
    LspDiagnosticsVirtualTextWarning        { LspDiagnosticsDefaultWarning, gui='italic' },
    LspDiagnosticsVirtualTextInformation    { LspDiagnosticsDefaultInformation, gui='italic' },
    LspDiagnosticsVirtualTextHint           { LspDiagnosticsDefaultHint, gui='italic' },
    LspDiagnosticsSignError                 { LspDiagnosticsDefaultError, bg=NONE, gui=NONE },
    LspDiagnosticsSignWarning               { LspDiagnosticsDefaultWarning, bg=NONE, gui=NONE },
    LspDiagnosticsSignInformation           { LspDiagnosticsDefaultInformation, bg=NONE, gui=NONE },
    LspDiagnosticsSignHint                  { LspDiagnosticsDefaultHint, bg=NONE, gui=NONE },

    TelescopeNormal         { fg=blend(amber, fg, 2/3) },
    TelescopePromptPrefix   { fg=amber, gui=bf },
    TelescopeSelection      { bg=blend(amber, bg, 1/9), fg=bg, gui=bf },
    TelescopeSelectionCaret { TelescopeSelection, gui=bf },
    TelescopeBorder         { fg=blend(amber, bg) },
    TelescopePromptBorder   { TelescopeBorder },
    TelescopePreviewBorder  { TelescopeBorder },
    TelescopeResultsBorder  { TelescopeBorder },

    GoneovimFloatWindowBorder { TelescopeBorder },

    -- rainbowcol_7 { fg=blue, lush={{{{{{{{      }}}}}}}} }, -- repeat 7 so you can see the 7-1 difference
    -- rainbowcol1 { fg=red },
    -- rainbowcol2 { fg=teal },
    -- rainbowcol3 { fg=purple },
    -- rainbowcol4 { fg=orange },
    -- rainbowcol5 { fg=green },
    -- rainbowcol6 { fg=yellow },
    -- rainbowcol7 { fg=blue },
    -- rainbowcol_1 { fg=red }, -- repeat 1 so you can see the 7-1 difference
} end)

return spec

