--[[
	Provides functions to calculate the smallest representable difference (Unit in the Last Place/Unit of Least Precision, ULP) near a given number of various float precisions.
	
	Licensed under the MIT License:
		https://github.com/Nowoshire/Luau-Float-Precision/blob/main/LICENSE

		MIT License
		
		Copyright (c) 2025-2026 Nowoshire
		
		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all
		copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
		SOFTWARE.
]]

local floatPrecision = {}

--[[
Calculates and returns the ULP (smallest representable difference) for the given FP16 number.
]]
function floatPrecision.ulp_fp16(x: number): number
	if x == 0 then
		return 2^-24
	end
	
	-- 2 ^ (exponent - mantissa bits)
	return 2 ^ ( math.floor( math.log(math.abs(x), 2) ) - 10 )
end

--[[
Calculates and returns the ULP (smallest representable difference) for the given FP32 (single) number.
]]
function floatPrecision.ulp_fp32(x: number): number
	if x == 0 then
		return 2^-126
	end
	
	-- 2 ^ (exponent - mantissa bits)
	return 2 ^ ( math.floor( math.log(math.abs(x), 2) ) - 23 )
end

--[[
Calculates and returns the ULP (smallest representable difference) for the given FP64 (double) number.
]]
function floatPrecision.ulp_fp64(x: number): number
	if x == 0 then
		return 2^-1022
	end
	
	-- 2 ^ (exponent - mantissa bits)
	return 2 ^ ( math.floor( math.log(math.abs(x), 2) ) - 52 )
end

--[[
Calculates and returns the ULP (smallest representable difference) for the given float with an arbitrary number of mantissa bits.

<code>exponentBits</code> is an optional parameter used to calculate the ULP when <code>x = 0</code>, if not defined, <code>11</code> bits will be used (binary64).

<strong>NOTE:</strong> Floats with mantissa bits > 52 (fp64) are not be representable in Luau, and this function will only be able to return an approximation.
]]
function floatPrecision.ulp_fpbits(x: number, mantissaBits: number, exponentBits: number?): number
	if x == 0 then
		local bias = 2 ^ ((exponentBits or 11) - 1) - 1
		local emin = 1 - bias
		
		return 2 ^ emin
	end
	
	-- 2 ^ (exponent - mantissa bits)
	return 2 ^ ( math.floor( math.log(math.abs(x), 2) ) - mantissaBits )
end

return floatPrecision
