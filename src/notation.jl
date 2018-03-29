
"""
```julia
three = 3
3
markable_three = Unmarked(three)
3
isunmarked(markable_three)
true
@mark!(markable_three)
3
ismarked(markable_three)
true
```
"""
macro mark!(x)
    quote
        $(esc(x)) = reinterpret(typeof($(esc(x))), lsbit(typeof($(esc(x)))) | ($(esc(x))))
    end
end


"""
```julia
three = 3
3
markable_three = Unmarked(three)
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
"""
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
    @inline ismarked(x::$M) = isodd(reinterpret($I, x))
    @inline isunmarked(x::$M) = iseven(reinterpret($I, x))
    @inline ismarked(x::$I) = false
    @inline isunmarked(x::$I) = true
    @inline mark(x::$M) = ismarked(x) ? x : reinterpret($M, reinterpret($I,x) | lsbit($I))
    @inline unmark(x::$M) = isumarked(x) ? x : reinterpret($M, reinterpret($I,x) & msbits($I))
    @inline mark(x::$I) = Marked(x)
    @inline unmark(x::$I) = Unmarked(x)
    
    @inline mtype(::Type{$I}) = $M
    @inline mtype(::Type{$M}) = $M
    @inline itype(::Type{$I}) = $I
    @inline itype(::Type{$M}) = $I
    @inline mtype(x::$I) = reinterpret($M,x)
    @inline mtype(x::$M) = x
    @inline itype(x::$I) = x
    @inline itype(x::$M) = reinterpret($I,x)
    @inline mtyped(x::$I) = $M(x)
    @inline mtyped(x::$M) = x
    @inline ityped(x::$M) = $I(x)
    @inline ityped(x::$I) = x
  end
end

findall(x::Vector{T}) where {T<:MarkableInteger}  = findall(map(ismarked, x))
findallnot(x) = map((!),findall(x))
allmarked(x::Vector{T}) where {T<:MarkableInteger}   = x[findall(x)]
allunmarked(x::Vector{T}) where {T<:MarkableInteger} = x[findallnot(x)]
