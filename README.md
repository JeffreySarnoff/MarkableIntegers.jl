# MarkableIntegers

### Signed and Unsigned Integers, individually [un]markable.

##### - all are introduced in the _unmarked_ state
-- elements are marked by attaching a _note_
-- elements are unmarked by removing that _note_


####  Two-state Integers (unmarked state, marked state)

#### Released under the MIT License. &nbsp; &nbsp; &nbsp; &nbsp;Copyright &copy; 2018 by Jeffrey Sarnoff.

> _this package requires Julia v0.7-_


----

## Types

#### abstract and collective
- MarkableInteger, MarkableSigned, MarkableUnsigned

#### concrete
- MarkInt, MarkInt8, MarkInt16, MarkInt32, MarkInt64, MarkInt128
- MarkUInt, MarkUInt8, MarkUInt16, MarkUInt32, MarkUInt64, MarkUInt128


## Examples
```julia
julia> using MarkableIntegers

julia> markable5  = MarkInt(5)
5
julia> !ismarked(markable5)
true

julia> @mark!(markable5)          # markable Ints can be marked
julia> ismarked(markable5)
true
julia> @unmark!(markable5)        # and unmarked
5
julia> ismarked(markable5)
true
julia> @mark!(markable5)          # and remarked
5
julia> ismarked(markable5)
true

julia> markable5  = MarkUInt(5);
julia> unmarked5  = markable5;

julia> @mark!(markable5)
5
julia> markable5 == unmarked5   # marked and unmarked vars compare properly
true
```
