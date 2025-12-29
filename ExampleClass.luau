--!strict
--[[
	Example math operation module
	To be used as a standard for how classes should be written and documented
	To understand the @param and @return comments refer to moonwave documentation: https://eryn.io/moonwave/docs/intro
	
	-- Created by dokso - 12/29/2025
]]

-- Start Class --
local MathOperation = {};
MathOperation.__index = MathOperation;

-- Typing --
export type MathOperation = typeof(setmetatable({} :: {
	NumberA: number;
	NumberB: number;
}, MathOperation));

-- Implementation --
--[=[
	Creates a new math operation
	
	```lua
	local operation = MathOperation.new(1,10);
	```
	
	@param NumberA: number
	@param NumberB: number
	@return MathOperation
]=]
function MathOperation.new(numberA: number, numberB: number): MathOperation
	local self = setmetatable({}, MathOperation);
	self.NumberA = numberA;
	self.NumberB = numberB;
	
	return self;
end

--[=[
	Adds two numbers
	
	```lua
	MathOperation.new(5,10):Add(); -- 15
	```
	
	@return number
]=]
function MathOperation.Add(self: MathOperation): number
	return self.NumberA + self.NumberB;
end

--[=[
	Subtracts two numbers
	
	```lua
	MathOperation.new(5,12):Sub(); -- -7
	```
	
	@return number
]=]
function MathOperation.Sub(self: MathOperation): number
	return self.NumberA - self.NumberB;
end

--[=[
	Multiplies two numbers
	
	```lua
	MathOperation.new(3,4):Mul(); -- 12
	```
	
	@return number
]=]
function MathOperation.Mul(self: MathOperation): number
	return self.NumberA * self.NumberB;
end

--[=[
	Divides two numbers
	
	```lua
	MathOperation.new(25,2):Div(); -- 12.5
	```
	
	@return number
]=]
function MathOperation.Div(self: MathOperation): number
	return self.NumberA / self.NumberB;
end

--[=[
	Sets number A to a different number
	
	```lua
	local operation = MathOperation.new(4,5);
	operation:Add(); -- 4+5 = 9
	operation:SetA(5);
	operation:Add(); -- 5+5 = 10
	```
	
	@param numberA: number
]=]
function MathOperation.SetA(self: MathOperation, numberA: number)
	self.NumberA = numberA;
end

--[=[
	Sets number B to a different number
	
	```lua
	local operation = MathOperation.new(4,5);
	operation:Add(); -- 4+5 = 9
	operation:SetB(6);
	operation:Add(); -- 4+6 = 10
	```
	
	@param numberB: number
]=]
function MathOperation.SetB(self: MathOperation, numberB: number)
	self.NumberB = numberB;
end

-- Finish!!! --
return MathOperation;
