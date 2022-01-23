
local function lab(use)
    return function (t)
        local repo = t[1]
        local parts = vim.split(repo, '/')
        if #parts ~= 2 then return use(t) end
        local user = parts[1]; local name = parts[2]
        t[1] = string.format('https://gitlab.com/%s/%s.git', user, name)
        t['as'] = name
        return use(t)
    end
end

return lab

