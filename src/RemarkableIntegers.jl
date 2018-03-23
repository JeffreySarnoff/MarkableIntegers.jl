#=>

Creating software coheres obtainable intent with the actual.

Design is movement and the ideation of software is dance,
Good code escribes source into eventhood; we the dancer.

Copyright &copy; 2014-2018 by Jeffrey Sarnoff.  All Rights Reserved.

=#

module RemarkableIntegers

export NoteInt128, NoteInt64, NoteInt32, NoteInt, NoteInt16,
    NoteInt8, NoteUInt128, NoteUInt64, NoteUInt32, NoteUInt,
    NoteUInt16, NoteUInt8, note, unnote, isnoted, @note!, @unnote!

import Base: @pure, sizeof, signed, unsigned,
    leading_zeros, trailing_zeros, leading_ones, trailing_ones,
    convert, promote_rule, string, show,
    (&), (|), (⊻), (<=), (<), (==), (!=), (>=), (>), isless, isequal

import Base.Math: zero, one, iszero, isone, isinteger, typemax, typemin,
    isodd, iseven, sign, signbit, abs, copysign, flipsign,
    (+), (-), (*), (/), (%), div, fld, cld, mod, rem, sqrt, cbrt


include("type.jl")
include("notation.jl")
include("bits.jl")
include("compare.jl")


macro note!(x)
    quote
        $(esc(x)) = note($(esc(x)))
        return nothing
    end
end

macro unnote!(x)
    quote
        $(esc(x)) = unnote($(esc(x)))
        return nothing
    end
end

end # module NoteableIntegers
