
note(x::NoteInt128) = (|)(x, lsbit(NoteInt128))
note(x::NoteInt64)  = (|)(x, lsbit(NoteInt64))
note(x::NoteInt32)  = (|)(x, lsbit(NoteInt32))
note(x::NoteInt16)  = (|)(x, lsbit(NoteInt16))
note(x::NoteInt8)   = (|)(x, lsbit(NoteInt8))

note(x::NoteUInt128) = (|)(x, lsbit(NoteUInt128))
note(x::NoteUInt64)  = (|)(x, lsbit(NoteUInt64))
note(x::NoteUInt32)  = (|)(x, lsbit(NoteUInt32))
note(x::NoteUInt16)  = (|)(x, lsbit(NoteUInt16))
note(x::NoteUInt8)   = (|)(x, lsbit(NoteUInt8))

unnote(x::NoteInt128) = (&)(x, msbits(NoteInt128))
unnote(x::NoteInt64)  = (&)(x, msbits(NoteInt64))
unnote(x::NoteInt32)  = (&)(x, msbits(NoteInt32))
unnote(x::NoteInt16)  = (&)(x, msbits(NoteInt16))
unnote(x::NoteInt8)   = (&)(x, msbits(NoteInt8))

unnote(x::NoteUInt128) = (&)(x, msbits(NoteUInt128))
unnote(x::NoteUInt64)  = (&)(x, msbits(NoteUInt64))
unnote(x::NoteUInt32)  = (&)(x, msbits(NoteUInt32))
unnote(x::NoteUInt16)  = (&)(x, msbits(NoteUInt16))
unnote(x::NoteUInt8)   = (&)(x, msbits(NoteUInt8))

isnoted(x::NoteInt128) = (&)(x, lsbit(NoteInt128)) === lsbit(NoteInt128)
isnoted(x::NoteInt64)  = (&)(x, lsbit(NoteInt64))  === lsbit(NoteInt64)
isnoted(x::NoteInt32)  = (&)(x, lsbit(NoteInt32))  === lsbit(NoteInt32)
isnoted(x::NoteInt16)  = (&)(x, lsbit(NoteInt16))  === lsbit(NoteInt16)
isnoted(x::NoteInt8)   = (&)(x, lsbit(NoteInt8))   === lsbit(NoteInt8)

isnoted(x::NoteUInt128) = (&)(x, lsbit(NoteUInt128)) === lsbit(NoteUInt128)
isnoted(x::NoteUInt64)  = (&)(x, lsbit(NoteUInt64))  === lsbit(NoteUInt64)
isnoted(x::NoteUInt32)  = (&)(x, lsbit(NoteUInt32))  === lsbit(NoteUInt32)
isnoted(x::NoteUInt16)  = (&)(x, lsbit(NoteUInt16))  === lsbit(NoteUInt16)
isnoted(x::NoteUInt8)   = (&)(x, lsbit(NoteUInt8))   === lsbit(NoteUInt8)

isnoted(x::T) where {T<:Signed}   = false
isnoted(x::T) where {T<:Unsigned} = false

@inline noted(x::Vector{T}) where {T<:NoteIntegers} = map(isnoted, x)
findall(x::Vector{T}) where {T<:NoteIntegers}  = findall(noted(x))
findallnot(x) = map((!),findall(x))
allnoted(x::Vector{T}) where {T<:NoteIntegers}   = x[findall(x)]
allunnoted(x::Vector{T}) where {T<:NoteIntegers} = x[findallnot(x)]
