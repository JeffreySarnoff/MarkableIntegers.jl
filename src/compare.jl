ffor OP in (:(==), :(!=), :(<=), :(>=), :(<), :(>))
    @eval begin
        function $OP(a::T, b::T) where {T<:MarkableInteger}
            ia = ityped(a)
            ib = ityped(b)
            return $OP(ia, ib)
        end
        function $OP(a::T1, b::T2) where {T1<:MarkableInteger, T2<:MarkableInteger}
            ia = ityped(a)
            ib = ityped(b)
            return $OP(ia, ib)
        end
        function $OP(a::T1, b::T2) where {T1<:MarkableInteger, T2<:Union{Signed,Unsigned}}
            ia = ityped(a)
            return $OP(ia, b)
        end
        function $OP(a::T1, b::T2) where {T2<:MarkableInteger, T1<:Union{Signed,Unsigned}}
            ib = ityped(b)
            return $OP(a, ib)
        end
    end
end

isless(a::T, b::T)  where{T<:MarkSigned} = signed(a) <  signed(b)
isequal(a::T, b::T) where{T<:MarkSigned} = signed(a) == signed(b)

isless(a::T, b::T)  where{T<:MarkUnsigned} = unsigned(a) <  unsigned(b)
isequal(a::T, b::T) where{T<:MarkUnsigned} = unsigned(a) == unsigned(b)

