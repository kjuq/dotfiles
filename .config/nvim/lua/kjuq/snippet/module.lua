---@alias kjuq.snp.body (fun():string)|string|string[]

---@class kjuq.snp.snippet
---@field trigger string
---@field body kjuq.snp.body

---@class kjuq.snp.snippets
---@field snippets kjuq.snp.snippet[]
---@field new fun():kjuq.snp.snippets
---@field add fun(self:kjuq.snp.snippets, trigger:string, body:kjuq.snp.body):nil

local M = {}

---@class kjuq.snp.snippets
local snippets = {}
snippets.__index = snippets

function snippets.new()
	local self = setmetatable({}, snippets)
	---@type kjuq.snp.snippet[]
	self.snippets = {}
	return self
end

function snippets:add(trigger, body)
	self.snippets[#self.snippets + 1] = {
		trigger = trigger,
		body = body,
	}
end

M.snippets = snippets

return M
