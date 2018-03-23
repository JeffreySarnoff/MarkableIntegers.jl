using RemarkableIntegers
using Test

ordinary5  = 5
@test !marked(ordinary5)       # with ordinary Ints (UInts)
@unmark!(ordinary5)            # @mark!, @unmark! are allowed
@mark!(ordinary5)              # (to simplify mixed use)
@test !marked(ordinary5)       # they do nothing

markable5  = MInt(5)
@test !marked(markable5)
@mark!(markable5)              # markable Ints can be marked
@test marked(markable5)        # 
@unmark!(markable5)            # and unmarked
@test !marked(markable5)       # 
@mark!(markable5)              # and remarked
@test marked(markable5)        # 


# marked and unmarked vars of equal value measure equal

markable5  = MUInt(5)
unmarked5  = markable5
@mark!(markable5)
@test marked(markable5)
@test !marked(unmarked5)
@test markable5 == unmarked5

# indexing       1  2  3  4  5  6   7   8   9
vec = Markable.([1, 3, 5, 7, 3, 9, 11, 11, 15])
@test !any(marked, vec)

@mark!(vec[5])
@mark!(vec[7])
@mark!(vec[8])

@test any(marked, vec)
@test findall(marked, vec) = [3, 7, 8]
@test map(marked, vec) = [5, 11, 11]


