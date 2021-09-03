local ls = require'luasnip'
local s = ls.s
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d
local sn = ls.sn

ls.snippets = {
    all = {
		ls.parser.parse_snippet(
            {trig = "sniptest"},
            "snippet ${0:sniptest} inserted!"
        ),

        -- s({trig = "__fsnip"}, {
        --     i(1),
        --     f(function (args)
        --     	return {tostring(math.random(1000, 9999)) .. args[1][1]}
        --     end, {1}),
        --     i(0)
        -- })
		-- snip({trig = "__snip%d*", regTrig = true, wordTrig = true}, {
            -- ins(0),
            -- text({" "}),
		-- 	func(function(args)
                -- pr(args)
                -- return {'' .. string.gsub(vim.inspect(args), '\n', '')}
            -- end, {}),
		-- }),
    },
    nix = {
        s(
            {
                trig = "=([%w%.]+)",
                regTrig = true,
                wordTrig = true,
                dscr = 'Nix property key'
            },
            {
                f(
                    function (args)
                        return {args[1].captures[1]..' = '}
                    end,
                    {}
                ),
                i(0),
                t({';'})
            }
        )
    },
	rust = {
		ls.parser.parse_snippet(
            {trig = "fn"},
            "/// $1\nfn $2($3) ${4:-> $5 }\\{\n\t$0\n\\}"
        )
	}
}
