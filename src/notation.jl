mark(x::MInt128) = (|)(x, lsbit(MInt128))
mark(x::MInt64)  = (|)(x, lsbit(MInt64))
mark(x::MInt32)  = (|)(x, lsbit(MInt32))
mark(x::MInt16)  = (|)(x, lsbit(MInt16))
mark(x::MInt8)   = (|)(x, lsbit(MInt8))

mark(x::MUInt128) = (|)(x, lsbit(MUInt128))
mark(x::MUInt64)  = (|)(x, lsbit(MUInt64))
mark(x::MUInt32)  = (|)(x, lsbit(MUInt32))
mark(x::MUInt16)  = (|)(x, lsbit(MUInt16))
mark(x::MUInt8)   = (|)(x, lsbit(MUInt8))

unmark(x::T) where {T<:Signed}   = x
unmark(x::T) where {T<:Unsigned} = x


unmark(x::MInt128) = (&)(x, msbits(MInt128))
unmark(x::MInt64)  = (&)(x, msbits(MInt64))
unmark(x::MInt32)  = (&)(x, msbits(MInt32))
unmark(x::MInt16)  = (&)(x, msbits(MInt16))
unmark(x::MInt8)   = (&)(x, msbits(MInt8))

unmark(x::MUInt128) = (&)(x, msbits(MUInt128))
unmark(x::MUInt64)  = (&)(x, msbits(MUInt64))
unmark(x::MUInt32)  = (&)(x, msbits(MUInt32))
unmark(x::MUInt16)  = (&)(x, msbits(MUInt16))
unmark(x::MUInt8)   = (&)(x, msbits(MUInt8))

unmark(x::T) where {T<:Signed}   = x
unmark(x::T) where {T<:Unsigned} = x


ismarked(x::MInt128) = (&)(x, lsbit(MInt128)) === lsbit(MInt128)
ismarked(x::MInt64)  = (&)(x, lsbit(MInt64))  === lsbit(MInt64)
ismarked(x::MInt32)  = (&)(x, lsbit(MInt32))  === lsbit(MInt32)
ismarked(x::MInt16)  = (&)(x, lsbit(MInt16))  === lsbit(MInt16)
ismarked(x::MInt8)   = (&)(x, lsbit(MInt8))   === lsbit(MInt8)

ismarked(x::MUInt128) = (&)(x, lsbit(MUInt128)) === lsbit(MUInt128)
ismarked(x::MUInt64)  = (&)(x, lsbit(MUInt64))  === lsbit(MUInt64)
ismarked(x::MUInt32)  = (&)(x, lsbit(MUInt32))  === lsbit(MUInt32)
ismarked(x::MUInt16)  = (&)(x, lsbit(MUInt16))  === lsbit(MUInt16)
ismarked(x::MUInt8)   = (&)(x, lsbit(MUInt8))   === lsbit(MUInt8)

ismarked(x::T) where {T<:Signed}   = false
ismarked(x::T) where {T<:Unsigned} = false

@inline marked(x::Vector{T}) where {T<:MIntegers} = map(ismarked, x)
findall(x::Vector{T}) where {T<:MIntegers}  = findall(marked(x))
findallnot(x) = map((!),findall(x))
allmarked(x::Vector{T}) where {T<:MIntegers}   = x[findall(x)]
allunmarked(x::Vector{T}) where {T<:MIntegers} = x[findallnot(x)]
