# Markable&thinsp;Integers

### Signed and Unsigned Integers, individually [un]markable.

##### - all are introduced in the _unmarked_ state
-- elements are marked by attaching a _note_
-- elements are unmarked by removing that _note_


####  Two-state Integers (unmarked state, marked state)

#### Released under the MIT License. &nbsp; &nbsp; &nbsp; &nbsp;Copyright &copy; 2018 by Jeffrey Sarnoff.

> _this package requires Julia v0.7-_

----
## Purpose

MarkableIntegers allow elements (integer values) of a sequence, mesh, voxel image, or time series to be distinguished. Any one or more of the constituent numbers may be noted with a mark (a re-find-able tag).  Marking one value does not mean that all other occurances of that value become marked.  You may choose to mark some, all or none of the other occurances of that value.

You may be seeking to identify regions within the dataform or datastream that are of some greater interest.  Often this requires preliminary identification, contextual refinement, and revisiting.  There are well-know methods to manage this sort of incremental refinement.  All lean on ancillary data structures and dynamic update.

MarkableIntegers bring the ability to provide and refine algorithmic focus into the data per se.  For some applications, this suffices.  For others, intelligent use of ancillary data structures and dynamic update therewith in concert with markable integers is the right complement.


----
## Introduction

There are `Markable` versions of each `Signed` (`Int8`, `Int16`, `Int32`, `Int64`, `Int128`) and each `Unsigned` (`UInt8`, `UInt16`, `UInt32` ,`UInt64`, `UInt128`) type.  The `Markable` types are prefixed with `Mark` (`MarkInt32`, `MarkUInt64`).

For most uses, you do not need to be that specific.  Variables that hold markable integers are initialized with (constructed from) some `Signed` or `Unsigned` value (or with e.g. `zero(MarkInt)`, `one(MarkInt16)`).

You can use `Unmarked` or `Marked` with any legitimate initializer and forget about the specific type names. `ismarked` and `isunmarked` are provided to ascertain markedness following computation.

```julia
julia> an_unmarked_value = Unmarked(10)
10
julia> a_marked_value = Marked(16)
16

julia> isunmarked(an_unmarked_value), ismarked(an_unmarked_value)
true, false

julia> isunmarked(a_marked_value), ismarked(a_marked_value)
false, true
```

There are two ways of marking an unmarked value or unmarking a marked value.
The first way uses the same form as is used with initialization. The result must be assigned to some value to be of use. The second uses macros to change values in place.  The macros reassign the variable given.

```julia
julia> ten = Unmarked(10)
10
julia> sixteen = Marked(16)
16

julia> isunmarked(ten)
true
julia> ten = Marked(ten)
10
julia> isunmarked(ten)
false

julia> ismarked(sixteen)
true
julia> sixteen = Unmarked(sixteen)
16
julia> ismarked(sixteen)
false
```

```julia
julia> ten = Unmarked(10);
julia> sixteen = Marked(16);
julia> @mark!(ten)
10
julia> @unmark!(sixteen)
16
julia> ismarked(ten), isunmarked(sixteen)
true, true

julia> @unmark!(ten);
julia> @mark!(sixteen);
julia> isunmarked(ten), ismarked(sixteen)
true, true
```
MarkableSigned integers readily convert to Signed and MarkableUnsigned integers readily convert to Unsigned.  `Signed` and `Unsigned` provide these conversions.

```julia

julia> markable_two = Unmarked(Int64(2));
julia> markable_three = Marked(UInt16(3));

julia> typeof(markable_two), typeof(markable_three)
(MarkInt64, MarkUInt16)

julia> two = Signed(markable_two);
julia> three = Unsigned(markable_three);

julia> typeof(two), typeof(three)
(Int64, UInt16)
```

You can obtain the indices of all marked and all unmarked constituents with `find_marked`, `find_unmarked`. You can obtain the values of all marked and of all unmarked constituents with `all_marked`, `all_unmarked`.

```julia
julia> seq = [Marked(1), Unmarked(20), Unmarked(300), Marked(4000), Unmarked(1)];
julia> find_marked(seq)
2-element Array{Int64,1}:
 1
 4
julia> all_marked(seq)
2-element Array{MarkInt64,1}:
    1
 4000
julia> find_unmarked(seq)
3-element Array{Int64,1}:
 2
 3
 5
julia> all_unmarked(seq)
3-element Array{MarkInt64,1}:
  20
 300
   1
```

----

## Exports

#### Constructors
- Unmarked, Marked
- Signed, Unsigned

#### Abstract and Collective Types
- `MarkableInteger`, `MarkableSigned`, `MarkableUnsigned`

#### Concrete Types
- `MarkInt`, `MarkInt8`, `MarkInt16`, `MarkInt32`, `MarkInt64`, `MarkInt128`
- `MarkUInt`, `MarkUInt8`, `MarkUInt16`, `MarkUInt32`, `MarkUInt64`, `MarkUInt128`

#### Predicates
 - `ismarked`, `isunmarked`

#### Collectors
 - `find_marked`, `find_unmarked`
 - `all_marked`, `all_unmarked`
 
#### Comparatives
  - `==`, `!=`, `<=`, `<`, `>=`, `>`
  - `isless`, `isequal`

#### Bitwise Primitives (wip)
  - `leading_zeros`, `trailing_zeros`, `leading_ones`, `trailing_ones`
  - `count_zeros`, `count_ones`

#### Bitwise Logic
- `~`, `&`, `|`, `⊻`
  
#### Math
  - `abs`, `signbit`, `sign`
  - `+`, `-`, `*`, `div`, `fld`, `cld`, `rem`, `mod`
  - `/`
  

