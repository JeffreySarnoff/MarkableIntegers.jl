for OP in (:(==), :(!=), :(<=), :(>=), :(<), :(>))
    @eval begin
        $OP(a::T, b::T) where {T<:NoteSigned}   = $OP(signed(a), signed(b))
        $OP(a::T, b::T) where {T<:NoteUnsigned} = $OP(unsigned(a), unsigned(b))
    end
end

isless(a::T, b::T)  where{T<:NoteSigned} = signed(a) <  signed(b)
isequal(a::T, b::T) where{T<:NoteSigned} = signed(a) == signed(b)

isless(a::T, b::T)  where{T<:NoteUnsigned} = unsigned(a) <  unsigned(b)
isequal(a::T, b::T) where{T<:NoteUnsigned} = unsigned(a) == unsigned(b)
