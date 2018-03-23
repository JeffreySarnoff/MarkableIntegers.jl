using RemarkableIntegers
using Test

ivalue1 = 5
ivalue2 = 9999
inote1  = NoteInt(ivalue1)
inote2  = NoteInt(2)

@test isnoted(ivalue1)  == false
@test isnoted(ivalue2)  == false
@test isnoted(inote1)  == false
@test isnoted(inote2)  == false
