bitsof(::Type{UInt8})   =   8
bitsof(::Type{UInt16})  =  16
bitsof(::Type{UInt32})  =  32
bitsof(::Type{UInt64})  =  64
bitsof(::Type{UInt128}) = 128
bitsof(::Type{Int8})    =   8
bitsof(::Type{Int16})   =  16
bitsof(::Type{Int32})   =  32
bitsof(::Type{Int64})   =  64
bitsof(::Type{Int128})  = 128

lsbit(::Type{UInt8})    = 0x01
lsbit(::Type{UInt16})   = 0x0001
lsbit(::Type{UInt32})   = 0x00000001
lsbit(::Type{UInt64})   = 0x0000000000000001
lsbit(::Type{UInt128})  = 0x00000000000000000000000000000001
lsbit(::Type{Int8})     = 0x01%Int8
lsbit(::Type{Int16})    = 0x0001%Int16
lsbit(::Type{Int32})    = 0x00000001%Int32
lsbit(::Type{Int64})    = 0x0000000000000001%Int64
lsbit(::Type{Int128})   = 0x00000000000000000000000000000001%Int128

lsbit(::Type{NoteUInt8})    = 0x01%NoteUInt8
lsbit(::Type{NoteUInt16})   = 0x0001%NoteUInt16
lsbit(::Type{NoteUInt32})   = 0x00000001%NoteUInt32
lsbit(::Type{NoteUInt64})   = 0x0000000000000001%NoteUInt64
lsbit(::Type{NoteUInt128})  = 0x00000000000000000000000000000001%NoteUInt128
lsbit(::Type{NoteInt8})     = 0x01%NoteInt8
lsbit(::Type{NoteInt16})    = 0x0001%NoteInt16
lsbit(::Type{NoteInt32})    = 0x00000001%NoteInt32
lsbit(::Type{NoteInt64})    = 0x0000000000000001%NoteInt64
lsbit(::Type{NoteInt128})   = 0x00000000000000000000000000000001%NoteInt128

msbit(::Type{UInt8})    = 0x80
msbit(::Type{UInt16})   = 0x8000
msbit(::Type{UInt32})   = 0x80000000
msbit(::Type{UInt64})   = 0x8000000000000000
msbit(::Type{UInt128})  = 0x80000000000000000000000000000000
msbit(::Type{Int8})     = 0x80%Int8
msbit(::Type{Int16})    = 0x8000%Int16
msbit(::Type{Int32})    = 0x80000000%Int32
msbit(::Type{Int64})    = 0x8000000000000000%Int64
msbit(::Type{Int128})   = 0x80000000000000000000000000000000%Int128

msbit(::Type{NoteUInt8})    = 0x80%NoteUInt8
msbit(::Type{NoteUInt16})   = 0x8000%NoteUInt16
msbit(::Type{NoteUInt32})   = 0x80000000%NoteUInt32
msbit(::Type{NoteUInt64})   = 0x8000000000000000%NoteUInt64
msbit(::Type{NoteUInt128})  = 0x80000000000000000000000000000000%NoteUInt128
msbit(::Type{NoteInt8})     = 0x80%NoteInt8
msbit(::Type{NoteInt16})    = 0x8000%NoteInt16
msbit(::Type{NoteInt32})    = 0x80000000%NoteInt32
msbit(::Type{NoteInt64})    = 0x8000000000000000%NoteInt64
msbit(::Type{NoteInt128})   = 0x80000000000000000000000000000000%NoteInt128

msbits(::Type{UInt8})    = 0xfe      # (-one(Int8))%UInt8 << 1
msbits(::Type{UInt16})   = 0xfffe
msbits(::Type{UInt32})   = 0xfffffffe
msbits(::Type{UInt64})   = 0xfffffffffffffffe
msbits(::Type{UInt128})  = 0xfffffffffffffffffffffffffffffffe
msbits(::Type{Int8})     = 0xfe%Int8
msbits(::Type{Int16})    = 0xfffe%Int16
msbits(::Type{Int32})    = 0xfffffffe%Int32
msbits(::Type{Int64})    = 0xfffffffffffffffe%Int64
msbits(::Type{Int128})   = 0xfffffffffffffffffffffffffffffffe%Int128

msbits(::Type{NoteUInt8})    = 0xfe%NoteUInt8      # (-one(Int8))%UInt8 << 1
msbits(::Type{NoteUInt16})   = 0xfffe%NoteUInt16
msbits(::Type{NoteUInt32})   = 0xfffffffe%NoteUInt32
msbits(::Type{NoteUInt64})   = 0xfffffffffffffffe%NoteUInt64
msbits(::Type{NoteUInt128})  = 0xfffffffffffffffffffffffffffffffe%NoteUInt128
msbits(::Type{NoteInt8})     = 0xfe%NoteInt8
msbits(::Type{NoteInt16})    = 0xfffe%NoteInt16
msbits(::Type{NoteInt32})    = 0xfffffffe%NoteInt32
msbits(::Type{NoteInt64})    = 0xfffffffffffffffe%NoteInt64
msbits(::Type{NoteInt128})   = 0xfffffffffffffffffffffffffffffffe%NoteInt128

for (M,I) in ((:NoteUInt128, :UInt128), (:NoteUInt64, :UInt64),
              (:NoteUInt32, :UInt32), (:NoteUInt16, :UInt16),
              (:NoteUInt8, :UInt8),
              (:NoteInt128, :Int128), (:NoteInt64, :Int64),
              (:NoteInt32, :Int32), (:NoteInt16, :Int16),
              (:NoteInt8, :Int8))
  @eval begin
      bitsof(::Type{$M}) = bitsof($I) - 1
      msbit(::Type{$M})  = reinterpret($M, msbit($I))
      lsbit(::Type{$M})  = reinterpret($M, lsbit($I))
  end
end
