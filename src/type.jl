
abstract type NoteUnsigned <: Unsigned end
abstract type NoteSigned   <: Signed   end

primitive type NoteUInt128 <: NoteUnsigned 128 end
primitive type NoteUInt64  <: NoteUnsigned  64 end
primitive type NoteUInt32  <: NoteUnsigned  32 end
primitive type NoteUInt16  <: NoteUnsigned  16 end
primitive type NoteUInt8   <: NoteUnsigned   8 end

primitive type NoteInt128 <: NoteSigned 128 end
primitive type NoteInt64  <: NoteSigned  64 end
primitive type NoteInt32  <: NoteSigned  32 end
primitive type NoteInt16  <: NoteSigned  16 end
primitive type NoteInt8   <: NoteSigned   8 end

if Int64 === Int
    const NoteInt  = NoteInt64
    const NoteUInt = NoteUInt64
else
    const NoteInt  = NoteInt32
    const NoteUInt = NoteUInt32
end

if UInt64 === UInt
    const NoteInt  = NoteInt64
    const NoteUInt = NoteUInt64
else
    const NoteInt  = NoteInt32
    const NoteUInt = NoteUInt32
end

const NoteUInts = Union{NoteUInt128, NoteUInt64, NoteUInt32, NoteUInt16, NoteUInt8}
const NoteInts = Union{NoteInt128, NoteInt64, NoteInt32, NoteInt16, NoteInt8}
const NoteIntegers = Union{NoteUInts, NoteInts}

struct inote <: NoteSigned end
struct unote <: NoteUnsigned end

unsigned(x::NoteUInt128) = reinterpret(UInt128, x) >> 1
unsigned(x::NoteUInt64)  = reinterpret(UInt64,  x) >> 1
unsigned(x::NoteUInt32)  = reinterpret(UInt32,  x) >> 1
unsigned(x::NoteUInt16)  = reinterpret(UInt16,  x) >> 1
unsigned(x::NoteUInt8)   = reinterpret(UInt8,   x) >> 1

signed(x::NoteInt128) = reinterpret(Int128, x) >> 1
signed(x::NoteInt64)  = reinterpret(Int64,  x) >> 1
signed(x::NoteInt32)  = reinterpret(Int32,  x) >> 1
signed(x::NoteInt16)  = reinterpret(Int16,  x) >> 1
signed(x::NoteInt8)   = reinterpret(Int8,   x) >> 1

unsigned(x::NoteInt128) = reinterpret(UInt128, x) >> 1
unsigned(x::NoteInt64)  = reinterpret(UInt64,  x) >> 1
unsigned(x::NoteInt32)  = reinterpret(UInt32,  x) >> 1
unsigned(x::NoteInt16)  = reinterpret(UInt16,  x) >> 1
unsigned(x::NoteInt8)   = reinterpret(UInt8,   x) >> 1

signed(x::NoteUInt128) = reinterpret(Int128, x) >> 1
signed(x::NoteUInt64)  = reinterpret(Int64,  x) >> 1
signed(x::NoteUInt32)  = reinterpret(Int32,  x) >> 1
signed(x::NoteUInt16)  = reinterpret(Int16,  x) >> 1
signed(x::NoteUInt8)   = reinterpret(Int8,   x) >> 1

inote(x::Int128) = reinterpret(NoteInt128, (x << 1))
inote(x::Int64)  = reinterpret(NoteInt64,  (x << 1))
inote(x::Int32)  = reinterpret(NoteInt32,  (x << 1))
inote(x::Int16)  = reinterpret(NoteInt16,  (x << 1))
inote(x::Int8)   = reinterpret(NoteInt8,   (x << 1))

unote(x::UInt128) = reinterpret(NoteUInt128, (x << 1))
unote(x::UInt64)  = reinterpret(NoteUInt64,  (x << 1))
unote(x::UInt32)  = reinterpret(NoteUInt32,  (x << 1))
unote(x::UInt16)  = reinterpret(NoteUInt16,  (x << 1))
unote(x::UInt8)   = reinterpret(NoteUInt8,   (x << 1))



for (M,I) in (
        (:NoteUInt128, :UInt128), (:NoteUInt64, :UInt64),
        (:NoteUInt32, :UInt32), (:NoteUInt16, :UInt16),
        (:NoteUInt8, :UInt8),
        (:NoteInt128, :Int128), (:NoteInt64, :Int64),
        (:NoteInt32, :Int32), (:NoteInt16, :Int16),
        (:NoteInt8, :Int8),
        (:NoteInt128, :UInt128), (:NoteInt64, :UInt64),
        (:NoteInt32, :UInt32), (:NoteInt16, :UInt16),
        (:NoteInt8, :UInt8),
        (:NoteUInt128, :Int128), (:NoteUInt64, :Int64),
        (:NoteUInt32, :Int32), (:NoteUInt16, :Int16),
        (:NoteUInt8, :Int8)
    )
  @eval begin
    $M(x::$I) = reinterpret($M, x)
    promote_rule(::Type{$M}, ::Type{$I}) = $M
    convert(::Type{$M}, x::$I) = reinterpret($M, x)
  end
end


for (M,I) in ((:NoteUInt128, :UInt128), (:NoteUInt64, :UInt64),
              (:NoteUInt32, :UInt32), (:NoteUInt16, :UInt16),
              (:NoteUInt8, :UInt8),
              (:NoteInt128, :Int128), (:NoteInt64, :Int64),
              (:NoteInt32, :Int32), (:NoteInt16, :Int16),
              (:NoteInt8, :Int8))
  @eval begin
    @inline isnoteable(x::$I) = ((typemin($I)>>1) <= x) & (x <= (typemax($I)>>1))
    @inline isnoteable(x::$M) = true
    @pure value_as_integer(x::$I)   = x
    @pure value_as_integer(x::$M)   = reinterpret($I,x) >> 1
    @pure value_as_notable(x::$M)   = x
    @inline value_as_notable(x::$I) = reinterpret($M, x<<1)
    value_as_realized(x::$M) = x
    value_as_realized(x::$I) = isnoteable(x) ? value_as_notable(x) : throw(DomainError())

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

    $M(x::$I) = isnoteable(x) ? reinterpret($M, x<<1) : throw(DomainError("$x"))
    $I(x::$M) = reinterpret($I, x) >> 1
    @inline convert(::Type{$M}, x::$I) =
        isnoteable(x) ? reinterpret($M, x<<1) : throw(DomainError("$x"))
    @inline convert(::Type{$I}, x::$M) = reinterpret($I,x) >> 1
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

string(x::NoteUInts) = string(unsigned(x))
string(x::NoteInts)  = string(signed(x))

show(io::IO, x::NoteIntegers) = print(io, string(x))
show(x::NoteIntegers) = print(STDOUT, string(x))

(&)(x::T, y::T) where {T<:NoteSigned} = inote(signed(x) & signed(y))
(|)(x::T, y::T) where {T<:NoteSigned} = inote(signed(x) | signed(y))
(⊻)(x::T, y::T) where {T<:NoteSigned} = inote(signed(x) ⊻ signed(y))

(-)(x::T) where {T<:NoteSigned} = inote(-signed(x))
(+)(x::T, y::T) where {T<:NoteSigned} = inote(signed(x) + signed(y))
(-)(x::T, y::T) where {T<:NoteSigned} = inote(signed(x) + signed(y))
(*)(x::T, y::T) where {T<:NoteSigned} = inote(signed(x) + signed(y))
(/)(x::T, y::T) where {T<:NoteSigned} = inote(signed(x) + signed(y))

(&)(x::T, y::T) where {T<:NoteUnsigned} = inote(unsigned(x) & unsigned(y))
(|)(x::T, y::T) where {T<:NoteUnsigned} = inote(unsigned(x) | unsigned(y))
(⊻)(x::T, y::T) where {T<:NoteUnsigned} = inote(unsigned(x) ⊻ unsigned(y))

(-)(x::T) where {T<:NoteUnsigned} = unote(-unsigned(x))
(+)(x::T, y::T) where {T<:NoteUnsigned} = unote(unsigned(x) + unsigned(y))
(-)(x::T, y::T) where {T<:NoteUnsigned} = unote(unsigned(x) + unsigned(y))
(*)(x::T, y::T) where {T<:NoteUnsigned} = unote(unsigned(x) + unsigned(y))
(/)(x::T, y::T) where {T<:NoteUnsigned} = unote(unsigned(x) + unsigned(y))

div(x::T, y::T) where {T<:NoteSigned} = inote(div(signed(x), signed(y)))
fld(x::T, y::T) where {T<:NoteSigned} = inote(fld(signed(x), signed(y)))
cld(x::T, y::T) where {T<:NoteSigned} = inote(cld(signed(x), signed(y)))
rem(x::T, y::T) where {T<:NoteSigned} = inote(rem(signed(x), signed(y)))
mod(x::T, y::T) where {T<:NoteSigned} = inote(mod(signed(x), signed(y)))
divrem(x::T, y::T) where {T<:NoteSigned} = inote(divrem(signed(x), signed(y)))
fldmod(x::T, y::T) where {T<:NoteSigned} = inote(fldmos(signed(x), signed(y)))

div(x::T, y::T) where {T<:NoteUnsigned} = inote(div(unsigned(x), unsigned(y)))
fld(x::T, y::T) where {T<:NoteUnsigned} = inote(fld(unsigned(x), unsigned(y)))
cld(x::T, y::T) where {T<:NoteUnsigned} = inote(cld(unsigned(x), unsigned(y)))
rem(x::T, y::T) where {T<:NoteUnsigned} = inote(rem(unsigned(x), unsigned(y)))
mod(x::T, y::T) where {T<:NoteUnsigned} = inote(mod(unsigned(x), unsigned(y)))
divrem(x::T, y::T) where {T<:NoteUnsigned} = inote(divrem(unsigned(x), unsigned(y)))
fldmod(x::T, y::T) where {T<:NoteUnsigned} = inote(fldmod(unsigned(x), unsigned(y)))
