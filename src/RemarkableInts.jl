__precompile__()

module RemarkableInts

export MInt128, MInt64, MInt32, MInt, MInt16,
    MInt8, MUInt128, MUInt64, MUInt32, MUInt,
    MUInt16, MUInt8, mark, unmark, ismarked, @mark!, @unmark!

import Base: @pure, sizeof, signed, unsigned,
    leading_zeros, trailing_zeros, leading_ones, trailing_ones,
    convert, promote_rule, string, show,
    (&), (|), (⊻), (<=), (<), (==), (!=), (>=), (>), isless, isequal,
    ismarked 

import Base.Math: zero, one, iszero, isone, isinteger, typemax, typemin,
    isodd, iseven, sign, signbit, abs, copysign, flipsign,
    (+), (-), (*), (/), (%), div, fld, cld, mod, rem, sqrt, cbrt


macro mark!(x)
    quote
        $(esc(x)) = mark($(esc(x)))
        return nothing
    end
end

macro unmark!(x)
    quote
        $(esc(x)) = unmark($(esc(x)))
        return nothing
    end
end

include("type.jl")
include("notation.jl")
include("bits.jl")
include("compare.jl")



end # module RemarkableInts
