--[[
Provides functions to calculate the smallest representable difference (Unit in the Last Place/Unit of Least Precision, ULP) near a given number using different float precisions.
]]

local floatPrecision = {}

--[[
Calculates and returns the ULP (smallest representable difference) for the given FP16 number.
]]
function floatPrecision.ulp_fp16(x: number): number
	if x == 0 then
		return 2^-24 -- 2^(-14 - 10)
	end
	
	-- 2 ^ (exponent - mantissa bits)
	return 2 ^ ( math.floor( math.log(math.abs(x), 2) ) - 10 )
end

--[[
Calculates and returns the ULP (smallest representable difference) for the given FP32 (single) number.
]]
function floatPrecision.ulp_fp32(x: number): number
	if x == 0 then
		return 1.401298464e-45 -- 2^-149
	end
	
	-- 2 ^ (exponent - mantissa bits)
	return 2 ^ ( math.floor( math.log(math.abs(x), 2) ) - 23 )
end

--[[
Calculates and returns the ULP (smallest representable difference) for the given FP64 (double) number.

<code>correctZeroSignificand</code> determines whether to return 2^−1074 when <code>x</code> is <code>0</code>.
When x = 0 and <code>correctZeroSignificand</code> is truthy, 2^−1074 will be returned otherwise 2^-1022 (the smallest value that operations can be performed on) will be returned.

<strong>NOTE:</strong> Attempting to perform calculations with the corrected value will result in it rounding to <code>0</code> due to insufficient precision.
]]
function floatPrecision.ulp_fp64(x: number, correctZeroSignificand: boolean?): number
	if x == 0 then
		return if correctZeroSignificand then
			4.94065645841247e-324 -- 2^-1074
		else 2^-1022
	end
	
	-- 2 ^ (exponent - mantissa bits)
	return 2 ^ ( math.floor( math.log(math.abs(x), 2) ) - 52 )
end

--[[
Calculates and returns the ULP (smallest representable difference) for the given float with an arbitrary number of mantissa bits.

<strong>NOTE:</strong> Floats with mantissa bits > 52 (fp64) are not be representable in Luau, and this function will only be able to return an approximation.
]]
function floatPrecision.ulp_fpbits(x: number, mantissaBits: number): number
	-- 2 ^ (exponent - mantissa bits)
	return 2 ^ ( math.floor( math.log(math.abs(x), 2) ) - mantissaBits )
end

return floatPrecision
