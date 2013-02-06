-- SICK: Simple Indicative of Competitive sKill
-- aka libhighscore
local h = {}
h.scores = {}

function h.rndName(s)
	local name=""
	local A="ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    for i=1,s do
		local n=math.random(string.len(A))
		name=name..string.sub(A,n,n)
	end
	return name;
end

function h.set(filename, places, name)
	h.filename = filename
	h.places = places
	if not h.load() then
		h.scores = {}
		for i = 1, places do
			h.scores[i] = {i, name or h.rndName(3)}
		end
	end
end

function h.load()
	local file = love.filesystem.newFile(h.filename)
	if not love.filesystem.exists(h.filename) or not file:open("r") then return end
	h.scores = {}
	for line in file:lines() do
		local i = line:find('\t', 1, true)
		h.scores[#h.scores+1] = {tonumber(line:sub(1, i-1)), line:sub(i+1)}
	end
	return file:close()
end

local function sortScore(a, b)
	return a[1] > b[1]
end
function h.add(name, score)
print(#h.scores)
	h.scores[#h.scores+1] = {score, name}
	table.sort(h.scores, sortScore)
end

function h.save()
	local file = love.filesystem.newFile(h.filename)
	if not file:open("w") then return end
	for i = 1, #h.scores do
		item = h.scores[i]
		file:write(item[1] .. "\t" .. item[2] .. "\n")
	end
	return file:close()
end

setmetatable(h, {__call = function(self)
	local i = 0
	return function()
		i = i + 1
		if i <= h.places and h.scores[i] then
			return i, unpack(h.scores[i])
		end
	end
end})

HS = h

return h
