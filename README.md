# RemarkableInts

### Signed and Unsigned Integers, individually [un]markable.

##### - all are introduced in the _unmarked_ state
-- elements are marked by attaching a _note_
-- elements are unmarked by removing that _note_


####  Two-state Integers (unmarked state, marked state)

#### Released under the MIT License. &nbsp; &nbsp; &nbsp; &nbsp;Copyright &copy; 2018 by Jeffrey Sarnoff.

> _this package requires Julia v0.7-_


----

## Types

- MInt, MInt8, MInt16, MInt32, MInt64, MInt128
- MUInt, MUInt8, MUInt16, MUInt32, MUInt64, MUInt128


## Examples
```julia
julia> using RemarkableInts

julia> markable5  = MInt(5)
5
julia> !ismarked(markable5)
true

julia> @mark!(markable5)          # markable Ints can be marked
julia> ismarked(markable5)
true
julia> @unmark!(markable5)        # and unmarked
julia> !ismarked(markable5)
true
julia> @mark!(markable5)          # and remarked
julia> ismarked(markable5)
true

julia> markable5  = MUInt(5);
julia> unmarked5  = markable5;

julia> @mark!(markable5)

julia> markable5 == unmarked5   # marked and unmarked vars compare properly
true
```
