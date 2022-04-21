%builtins output

from starkware.cairo.common.serialize import serialize_word

# Main is the center of a Cairo programs
func main{output_ptr : felt*}():
    #     ^^^^^^^^^^ implicit argument, to output
    serialize_word(6/3)
    # serialize_word takes argument, assignes [output_ptr] and returnes output_ptr + 1
    serialize_word(7/3)
    # numbers are elements of field, so when dividing 7 by 3, we cannot get 2.33333
    # because we need and integer
    # We get large number x which is in range -P/2 < x < P/2 and that
    # 3 * x = 7, this is possible because overflow hapens
    serialize_word((7/3)*3)
    # here ^ we see that it is 7 again
    return()
end