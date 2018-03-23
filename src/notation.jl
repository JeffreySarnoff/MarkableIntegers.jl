
mark(x::MarkInt128) = (|)(x, lsbit(MarkInt128))
mark(x::MarkInt64)  = (|)(x, lsbit(MarkInt64))
mark(x::MarkInt32)  = (|)(x, lsbit(MarkInt32))
mark(x::MarkInt16)  = (|)(x, lsbit(MarkInt16))
mark(x::MarkInt8)   = (|)(x, lsbit(MarkInt8))

mark(x::MarkUInt128) = (|)(x, lsbit(MarkUInt128))
mark(x::MarkUInt64)  = (|)(x, lsbit(MarkUInt64))
mark(x::MarkUInt32)  = (|)(x, lsbit(MarkUInt32))
mark(x::MarkUInt16)  = (|)(x, lsbit(MarkUInt16))
mark(x::MarkUInt8)   = (|)(x, lsbit(MarkUInt8))

unmark(x::MarkInt128) = (&)(x, msbits(MarkInt128))
unmark(x::MarkInt64)  = (&)(x, msbits(MarkInt64))
unmark(x::MarkInt32)  = (&)(x, msbits(MarkInt32))
unmark(x::MarkInt16)  = (&)(x, msbits(MarkInt16))
unmark(x::MarkInt8)   = (&)(x, msbits(MarkInt8))

unmark(x::MarkUInt128) = (&)(x, msbits(MarkUInt128))
unmark(x::MarkUInt64)  = (&)(x, msbits(MarkUInt64))
unmark(x::MarkUInt32)  = (&)(x, msbits(MarkUInt32))
unmark(x::MarkUInt16)  = (&)(x, msbits(MarkUInt16))
unmark(x::MarkUInt8)   = (&)(x, msbits(MarkUInt8))

ismarked(x::MarkInt128) = (&)(x, lsbit(MarkInt128)) === lsbit(MarkInt128)
ismarked(x::MarkInt64)  = (&)(x, lsbit(MarkInt64))  === lsbit(MarkInt64)
ismarked(x::MarkInt32)  = (&)(x, lsbit(MarkInt32))  === lsbit(MarkInt32)
ismarked(x::MarkInt16)  = (&)(x, lsbit(MarkInt16))  === lsbit(MarkInt16)
ismarked(x::MarkInt8)   = (&)(x, lsbit(MarkInt8))   === lsbit(MarkInt8)

ismarked(x::MarkUInt128) = (&)(x, lsbit(MarkUInt128)) === lsbit(MarkUInt128)
ismarked(x::MarkUInt64)  = (&)(x, lsbit(MarkUInt64))  === lsbit(MarkUInt64)
ismarked(x::MarkUInt32)  = (&)(x, lsbit(MarkUInt32))  === lsbit(MarkUInt32)
ismarked(x::MarkUInt16)  = (&)(x, lsbit(MarkUInt16))  === lsbit(MarkUInt16)
ismarked(x::MarkUInt8)   = (&)(x, lsbit(MarkUInt8))   === lsbit(MarkUInt8)

ismarked(x::T) where {T<:Signed}   = false
ismarked(x::T) where {T<:Unsigned} = false

@inline markd(x::Vector{T}) where {T<:MarkIntegers} = map(ismarked, x)
findall(x::Vector{T}) where {T<:MarkIntegers}  = findall(markd(x))
findallnot(x) = map((!),findall(x))
allmarked(x::Vector{T}) where {T<:MarkIntegers}   = x[findall(x)]
allunmarked(x::Vector{T}) where {T<:MarkIntegers} = x[findallnot(x)]

allumarked(x::Vector{T}) where {T<:NoteIntegers} = x[findallnot(x)]
