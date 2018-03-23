abstract type MarkUnsigned <: Unsigned end
abstract type MarkSigned   <: Signed   end

primitive type MUInt128 <: MarkUnsigned 128 end
primitive type MUInt64  <: MarkUnsigned  64 end
primitive type MUInt32  <: MarkUnsigned  32 end
primitive type MUInt16  <: MarkUnsigned  16 end
primitive type MUInt8   <: MarkUnsigned   8 end

primitive type MInt128 <: MarkSigned 128 end
primitive type MInt64  <: MarkSigned  64 end
primitive type MInt32  <: MarkSigned  32 end
primitive type MInt16  <: MarkSigned  16 end
primitive type MInt8   <: MarkSigned   8 end

if Int64 === Int    ismarkable(x) ?  : throw(DomainError("$x"))

    const MInt  = MInt64
    const MUInt = MUInt64
else
    const MInt  = MInt32
    const MUInt = MUInt32
end

if UInt64 === UInt
    const MInt  = MInt64
    const MUInt = MUInt64
else
    const MInt  = MInt32
    const MUInt = MUInt32
end

const MUInts = Union{MUInt128, MUInt64, MUInt32, MUInt16, MUInt8}
const MInts = Union{MInt128, MInt64, MInt32, MInt16, MInt8}
const MIntegers = Union{MUInts, MInts}

struct imark <: MarkSigned end
struct umark <: MarkUnsigned end

unsigned(x::MUInt128) = reinterpret(UInt128, x) >> 1
unsigned(x::MUInt64)  = reinterpret(UInt64,  x) >> 1
unsigned(x::MUInt32)  = reinterpret(UInt32,  x) >> 1
unsigned(x::MUInt16)  = reinterpret(UInt16,  x) >> 1
unsigned(x::MUInt8)   = reinterpret(UInt8,   x) >> 1

signed(x::MInt128) = reinterpret(Int128, x) >> 1
signed(x::MInt64)  = reinterpret(Int64,  x) >> 1
signed(x::MInt32)  = reinterpret(Int32,  x) >> 1
signed(x::MInt16)  = reinterpret(Int16,  x) >> 1
signed(x::MInt8)   = reinterpret(Int8,   x) >> 1

unsigned(x::MInt128) = reinterpret(UInt128, x) >> 1
unsigned(x::MInt64)  = reinterpret(UInt64,  x) >> 1
unsigned(x::MInt32)  = reinterpret(UInt32,  x) >> 1
unsigned(x::MInt16)  = reinterpret(UInt16,  x) >> 1
unsigned(x::MInt8)   = reinterpret(UInt8,   x) >> 1

signed(x::MUInt128) = reinterpret(Int128, x) >> 1
signed(x::MUInt64)  = reinterpret(Int64,  x) >> 1
signed(x::MUInt32)  = reinterpret(Int32,  x) >> 1
signed(x::MUInt16)  = reinterpret(Int16,  x) >> 1
signed(x::MUInt8)   = reinterpret(Int8,   x) >> 1

imark(x::Int128) = reinterpret(MInt128, (x << 1))
imark(x::Int64)  = reinterpret(MInt64,  (x << 1))
imark(x::Int32)  = reinterpret(MInt32,  (x << 1))
imark(x::Int16)  = reinterpret(MInt16,  (x << 1))
imark(x::Int8)   = reinterpret(MInt8,   (x << 1))

umark(x::UInt128) = reinterpret(MUInt128, (x << 1))
umark(x::UInt64)  = reinterpret(MUInt64,  (x << 1))
umark(x::UInt32)  = reinterpret(MUInt32,  (x << 1))
umark(x::UInt16)  = reinterpret(MUInt16,  (x << 1))
umark(x::UInt8)   = reinterpret(MUInt8,   (x << 1))



for (M,I) in (
        (:MUInt128, :UInt128), (:MUInt64, :UInt64),
        (:MUInt32, :UInt32), (:MUInt16, :UInt16),
        (:MUInt8, :UInt8),
        (:MInt128, :Int128), (:MInt64, :Int64),
        (:MInt32, :Int32), (:MInt16, :Int16),
        (:MInt8, :Int8),
        (:MInt128, :UInt128), (:MInt64, :UInt64),
        (:MInt32, :UInt32), (:MInt16, :UInt16),
        (:MInt8, :UInt8),
        (:MUInt128, :Int128), (:MUInt64, :Int64),
        (:MUInt32, :Int32), (:MUInt16, :Int16),
        (:MUInt8, :Int8)
    )
  @eval begin
    $M(x::$I) = ismarkable(x) ? reinterpret($M, x<<1) : throw(OverflowError("$x"))
    $I(x::$M) = reinterpret($I, x) >> 1
    promote_rule(::Type{$M}, ::Type{$I}) = $M
    convert(::Type{$M}, x::$I) = reinterpret($M, x)
  end
end


for (M,I) in ((:MUInt128, :UInt128), (:MUInt64, :UInt64),
              (:MUInt32, :UInt32), (:MUInt16, :UInt16),
              (:MUInt8, :UInt8),
              (:MInt128, :Int128), (:MInt64, :Int64),
              (:MInt32, :Int32), (:MInt16, :Int16),
              (:MInt8, :Int8))
  @eval begin
    @inline ismarkable(x::$I) = ((typemin($I)>>1) <= x) & (x <= (typemax($I)>>1))
    @inline ismarkable(x::$M) = true
    @pure value_as_integer(x::$I)   = x
    @pure value_as_integer(x::$M)   = reinterpret($I,x) >> 1
    @pure value_as_notable(x::$M)   = x
    @inline value_as_notable(x::$I) = reinterpret($M, x<<1)
    value_as_realized(x::$M) = x
    value_as_realized(x::$I) = ismarkable(x) ? value_as_notable(x) : throw(DomainError())

    @pure zero(::Type{$M}) = reinterpret($M, zero($I))
    @pure one(::Type{$M})  = reinterpret($M, one($I) << 1)
    @inline iszero(x::$M)  = iszero(reinterpret($I, x) >> 1)
    @inline isone(x::$M)   = isone(reinterpret($I, x) >> 1)

    @inline iseven(x::$M)  = iseven(reinterpret($I, x) >> 1)
    @inline isodd(x::$M)   = isodd(reinterpret($I, x) >> 1)

    @pure typemax(::Type{$M}) = reinterpret($M, typemax($I) >> 1)
    @pure typemin(::Type{$M}) = reinterpret($M, typemin($I) >> 1)

    (|)(x::$M, y::$M) = reinterpret($M, (|)(reinterpret($I,x), reinterpret($I,y)))
    (&)(x::$M, y::$M) = reinterpret($M, (&)(reinterpret($I,x), reinterpret($I,y)))
    (⊻)(x::$M, y::$M) = reinterpret($M, (xor)(reinterpret($I,x), reinterpret($I,y)))

    leading_zeros(x::$M)  = leading_zeros(reinterpret($I,x) | lsbit($I))
    leading_ones(x::$M)   = leading_ones(reinterpret($I,x) & ~lsbit($I))
    trailing_zeros(x::$M) = trailing_zeros((reinterpret($I,x) >> 1) | msbit($I))
    trailing_ones(x::$M)  = trailing_ones((reinterpret($I,x) >> 1) & ~msbit($I))
    count_ones(x::$M)     = count_ones(reinterpret($I,x) & ~lsbit($I))
    count_zeros(x::$M)    = count_ones(reinterpret($I,x) | lsbit($I))

    flipsign(x::$M, y) = reinterpret($M, flipsign(reinterpret($I,x), y))
    copysign(x::$M, y) = reinterpret($M, copysign(reinterpret($I,x), y))
    flipsign(x::$M, y::$M) = reinterpret($M, flipsign(reinterpret($I,x), reinterpret($I,y)))
    copysign(x::$M, y::$M) = reinterpret($M, copysign(reinterpret($I,x), reinterpret($I,y)))
  end
end

string(x::MUInts) = string(unsigned(x))
string(x::MInts)  = string(signed(x))

show(io::IO, x::MIntegers) = print(io, string(x))
show(x::MIntegers) = print(STDOUT, string(x))

(&)(x::T, y::T) where {T<:MarkSigned} = imark(signed(x) & signed(y))
(|)(x::T, y::T) where {T<:MarkSigned} = imark(signed(x) | signed(y))
(⊻)(x::T, y::T) where {T<:MarkSigned} = imark(signed(x) ⊻ signed(y))

(-)(x::T) where {T<:MarkSigned} = imark(-signed(x))
(+)(x::T, y::T) where {T<:MarkSigned} = imark(signed(x) + signed(y))
(-)(x::T, y::T) where {T<:MarkSigned} = imark(signed(x) + signed(y))
(*)(x::T, y::T) where {T<:MarkSigned} = imark(signed(x) + signed(y))
(/)(x::T, y::T) where {T<:MarkSigned} = imark(signed(x) + signed(y))

(&)(x::T, y::T) where {T<:MarkUnsigned} = imark(unsigned(x) & unsigned(y))
(|)(x::T, y::T) where {T<:MarkUnsigned} = imark(unsigned(x) | unsigned(y))
(⊻)(x::T, y::T) where {T<:MarkUnsigned} = imark(unsigned(x) ⊻ unsigned(y))

(-)(x::T) where {T<:MarkUnsigned} = umark(-unsigned(x))
(+)(x::T, y::T) where {T<:MarkUnsigned} = umark(unsigned(x) + unsigned(y))
(-)(x::T, y::T) where {T<:MarkUnsigned} = umark(unsigned(x) + unsigned(y))
(*)(x::T, y::T) where {T<:MarkUnsigned} = umark(unsigned(x) + unsigned(y))
(/)(x::T, y::T) where {T<:MarkUnsigned} = umark(unsigned(x) + unsigned(y))

div(x::T, y::T) where {T<:MarkSigned} = imark(div(signed(x), signed(y)))
fld(x::T, y::T) where {T<:MarkSigned} = imark(fld(signed(x), signed(y)))
cld(x::T, y::T) where {T<:MarkSigned} = imark(cld(signed(x), signed(y)))
rem(x::T, y::T) where {T<:MarkSigned} = imark(rem(signed(x), signed(y)))
mod(x::T, y::T) where {T<:MarkSigned} = imark(mod(signed(x), signed(y)))
divrem(x::T, y::T) where {T<:MarkSigned} = imark(divrem(signed(x), signed(y)))
fldmod(x::T, y::T) where {T<:MarkSigned} = imark(fldmos(signed(x), signed(y)))

div(x::T, y::T) where {T<:MarkUnsigned} = imark(div(unsigned(x), unsigned(y)))
fld(x::T, y::T) where {T<:MarkUnsigned} = imark(fld(unsigned(x), unsigned(y)))
cld(x::T, y::T) where {T<:MarkUnsigned} = imark(cld(unsigned(x), unsigned(y)))
rem(x::T, y::T) where {T<:MarkUnsigned} = imark(rem(unsigned(x), unsigned(y)))
mod(x::T, y::T) where {T<:MarkUnsigned} = imark(mod(unsigned(x), unsigned(y)))
divrem(x::T, y::T) where {T<:MarkUnsigned} = imark(divrem(unsigned(x), unsigned(y)))
fldmod(x::T, y::T) where {T<:MarkUnsigned} = imark(fldmod(unsigned(x), unsigned(y)))
