macro mark!(x)
    quote
        $(esc(x)) = reinterpret(typeof($(esc(x))), 
                                lsbit(typeof($(esc(x)))) | ($(esc(x))))
    end
end

macro unmark!(x)
    quote
        $(esc(x)) = reinterpret(typeof($(esc(x))), msbitsof($(esc(x))))
    end
end

for (M,I) in ((:MarkInt128, :Int128), (:MarkInt64, :Int64), 
              (:MarkInt32, :Int32), (:MarkInt16, :Int16), (:MarkInt8, :Int8),
              (:MarkUInt128, :UInt128), (:MarkUInt64, :UInt64), 
              (:MarkUInt32, :UInt32), (:MarkUInt16, :UInt16), (:MarkUInt8, :UInt8))
  @eval begin
    ismarked(x::$M) = isodd(reinterpret($I, x))
    isunmarked(x::$M) = iseven(reinterpret($I, x))
    ismarked(x::$I) = false
    isunmarked(x::$I) = true
    mark(x::$M) = reinterpret($M, reinterpret($I,x) | lsbit($I))
    unmark(x::$M) = reinterpret($M, reinterpret($I,x) & msbits($I))
    mark(x::$I) = Marked(x)
    unmark(x::$I) = Unmarked(x)
  end
end

findall(x::Vector{T}) where {T<:MarkedIntegers}  = findall(map(ismarked, x))
findallnot(x) = map((!),findall(x))
allmarked(x::Vector{T}) where {T<:MarkedIntegers}   = x[findall(x)]
allunmarked(x::Vector{T}) where {T<:MarkkedIntegers} = x[findallnot(x)]
