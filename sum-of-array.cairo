%builtins output

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word

# Computes the sum of the memory elements at address:
# arr + 0, arr + 1, ... arr + (size - 1)

func array_sum(arr: felt*, size) -> (sum):
    if size == 0:
        return (sum=0)
    end

    #size is not zero
    let (sum_of_rest) = array_sum(arr = arr + 1, size = size - 1)
    # in Cairo we use recusrion instead of loops, because memory is immutable
    return (sum = [arr] + sum_of_rest)
end

# Main is needed in every Cairo program to run
func main{output_ptr: felt*}():
    const ARRAY_SIZE = 3

    # Allocate an array
    let (ptr) = alloc()

    # Populate some values in the array
    assert [ptr] = 9
    assert [ptr + 1] = 16
    assert [ptr + 2] = 25

    # Call array_sum to comupte the sum of the elements
    let (sum) = array_sum(arr = ptr, size = ARRAY_SIZE)

    # Write the sum to the program output
    serialize_word(sum)

    return()
end