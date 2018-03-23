for OP in (:(==), :(!=), :(<=), :(>=), :(<), :(>))
    @eval begin
        $OP(a::T, b::T) where {T<:MarkSigned}   = $OP(signed(a), signed(b))
        $OP(a::T, b::T) where {T<:MarkUnsigned} = $OP(unsigned(a), unsigned(b))
    end
end

isless(a::T, b::T)  where{T<:MarkSigned} = signed(a) <  signed(b)
isequal(a::T, b::T) where{T<:MarkSigned} = signed(a) == signed(b)

isless(a::T, b::T)  where{T<:MarkUnsigned} = unsigned(a) <  unsigned(b)
isequal(a::T, b::T) where{T<:MarkUnsigned} = unsigned(a) == unsigned(b)

