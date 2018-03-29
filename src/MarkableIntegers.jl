__precompile__()

module MarkableIntegers

"""
   Markable(::Type{<:Signed})   ⇢ T<:MarkableSigned
   Markable(::Type{<:Unsigned}) ⇢ T<:MarkableUnsigned

MarkInt16 === Markable(Int16)

""" Markable

"""
   Unmarked(x<:Signed)   ⇢ x<:MarkableSigned    && isunmarked(x)
   Unmarked(x<:Unsigned) ⇢ x<:MarkableUnsigned  && isunmarked(x)

```julia
three = 3
3
unmarked_three = Unmarked(three)
3
isunmarked(unmarked_three)
true
!ismarked(unmarked_three)
true
```
""" Unmarked

"""
   Marked(x<:Signed)   ⇢ x<:MarkableSigned    && ismarked(x)
   Marked(x<:Unsigned) ⇢ x<:MarkableUnsigned  && ismarked(x)

```julia
three = 3
3
marked_three = Marked(three)
3
ismarked(marked_three)
true
!isunmarked(marked_three)
true
```
""" Marked



   Markable(Unsigned) -> MarkableUnsigned
export Markable,                   # f(x::Signed) -> MarkableSigned, MarkableUnsigned
       Marked, Unmarked,           # apply to Signed and Unsigned Integers
                                             # 
       @mark!, @unmark!,                     # use with MarkableIntegers
    MInt128, MInt64, MInt32, MInt, MInt16,
    MInt8, MUInt128, MUInt64, MUInt32, MUInt,
    MUInt16, MUInt8, mark, unmark, ismarked, @mark!, @unmark!

import Base: @pure, sizeof, signed, unsigned,
    leading_zeros, trailing_zeros, leading_ones, trailing_ones,
    convert, promote_rule, string, show,
    (&), (|), (⊻), (<=), (<), (==), (!=), (>=), (>), isless, isequal,
    ismarked, mark, unmark 

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



end # module MarkableIntegers
