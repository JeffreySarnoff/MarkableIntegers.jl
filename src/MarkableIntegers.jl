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

"""
```julia
three = 3
3
markable_three = Markable(three)
3
isunmarked(markable_three)
true
@mark!(markable_three)
3
ismarked(markable_three)
true
```
""" @mark!

"""
```julia
three = 3
3
markable_three = Markable(three)
3
isunmarked(markable_three)
true
@mark!(markable_three)
3
ismarked(markable_three)
true
@unmark!(markable_three)
3
ismarked(markable_three)
false
```
""" @unmark!

export Markable,
       Marked, Unmarked,
       @mark!, @unmark!,
       ismarked, isunmarked, allmarked, allunmarked,
       MarkInt128, MarkInt64, MarkInt32, MarkInt16, MarkInt8, MarkInt,
       MarkUInt128, MarkUInt64, MarkUInt32, MarkUInt16, MarkUInt8, MarkUInt,
       MarkableSigned, MarkableUnsigned, MarkableInteger

import Base: @pure, promote_type, promote_rule, convert, mark, unmark, ismarked,
    Signed, Unsigned, signed, unsigned,
    leading_zeros, trailing_zeros, leading_ones, trailing_ones,
    convert, promote_rule, string, show,
    (<=), (<), (==), (!=), (>=), (>), isless, isequal,
    (~), (&), (|), (⊻)

import Base.Math: zero, one, iszero, isone, isinteger, typemax, typemin,
    isodd, iseven, sign, signbit, abs, copysign, flipsign,
    (+), (-), (*), (/), (\), (^), div, fld, cld, mod, rem,
    sqrt, cbrt

import Base.Checked:  add_with_overflow, sub_with_overflow, mul_with_overflow,
    checked_neg, checked_abs, checked_add, checked_sub, checked_mul,
    checked_div, checked_fld, checked_cld, checked_rem, checked_div


include("type.jl")
include("promote.jl")
include("notation.jl")
include("bits.jl")
include("compare.jl")



end # module MarkableIntegers