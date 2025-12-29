--!strict
--[[
	Maid class for easy memory management
	
	-- Created by dokso - 12/29/2025
]]

-- Start Class --
local Maid = {};
Maid.__index = Maid;

-- Types --
export type Task = Instance | RBXScriptConnection | (() -> ()) | any | nil;

export type Maid = typeof(setmetatable({} :: {
	Tasks: {Task};
	Links: {RBXScriptConnection};
	Alive: boolean;
}, Maid));

-- Implementation --
--[=[
	Creates a new maid
	
	```lua
	local maid = Maid.new();
	```
	
	@return Maid
]=]
function Maid.new(): Maid
	local self = setmetatable({}, Maid);
	self.Tasks = {};
	self.Links = {};
	self.Alive = true;

	return self;
end

--[=[
	Adds all the parameters to the maid, and returns them for potential use

	Accepted types: Instance | RBXScriptConnection | (() -> ()) | Any table with a Destroy method

	```lua
	local part, decal = maid:Add(
		Instance.new("Part"),
		Instance.new("Decal")
	);
	```

	@param ...: Task
	@return ...: Task
]=]
function Maid.Add(self: Maid, ...: Task): ...Task
	if not self.Alive then return warn("Cannot give tasks to a dead maid"); end

	local tbl = {...};
	for _, task in tbl do
		table.insert(self.Tasks, task);
	end
	return unpack(tbl);
end

--[=[
	Cleans all the currently registered tasks in the maid
	
	```lua
	maid:Cleanup();
	```
]=]
function Maid.Cleanup(self: Maid)
	local tasks = self.Tasks;
	self.Tasks = {};
	
	for i, job in tasks do
		local success, err = pcall(function()
			if typeof(job) == "Instance" then
				job:Destroy();
			elseif typeof(job) == "RBXScriptConnection" then
				job:Disconnect();
			elseif typeof(job) == "function" then
				(job::any)();
			elseif typeof(job) == "table" and typeof(job.Destroy) == "function" then
				(job::any):Destroy();
			end
		end);
		if not success then
			warn(`Maid failed task {tostring(job)}, error: {err}`);
		end
	end
end

--[=[
	Runs cleanup and makes the maid unusable
	
	```lua
	maid:Destroy();
	```
]=]
function Maid.Destroy(self: Maid)
	self.Alive = false;
	self:Cleanup();
	table.freeze(self :: {});
end

--[=[
	Destroys the maid when the passed event fires
	
	@param signal: RBXScriptSignal
	@return RBXScriptConnection
]=]
function Maid.Link(self: Maid, signal: RBXScriptSignal): RBXScriptConnection
	return signal:Connect(function()
		self:Cleanup();
	end);
end

-- Finish!!! --
return Maid;
