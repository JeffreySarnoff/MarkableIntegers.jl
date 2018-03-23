using RemarkableInts
using Test

ordinary5  = 5
@test !ismarked(ordinary5)       # with ordinary Ints (UInts)
@unmark!(ordinary5)            # @mark!, @unmark! are allowed
@mark!(ordinary5)              # (to simplify mixed use)
@test !ismarked(ordinary5)       # they do nothing

markable5  = MInt(5)
@test !ismarked(markable5)
@mark!(markable5)              # markable Ints can be marked
@test ismarked(markable5)        # 
@unmark!(markable5)            # and unmarked
@test !ismarked(markable5)       # 
@mark!(markable5)              # and remarked
@test ismarked(markable5)        # 


# marked and unmarked vars of equal value measure equal

markable5  = MUInt(5)
unmarked5  = markable5
@mark!(markable5)
@test ismarked(markable5)
@test !ismarked(unmarked5)
@test markable5 == unmarked5

# indexing   1  2  3  4  5  6   7   8   9
vec = MInt.([1, 3, 5, 7, 3, 9, 11, 11, 15])
@test !any(ismarked, vec)

@mark!(vec[5]); @mark!(vec[7]); @mark!(vec[8])
#                                   \  \   \
@test findall(ismarked, vec)    == [5,  7,  8]
#                                   |   |   |
@test vec[ map(ismarked, vec) ] == [3, 11, 11]


