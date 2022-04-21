%builtins output

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word

# EXCERCISE

# Assuming that array will allway have even number of elements
func array_product(arr: felt*, size) -> (prod):
    if size == 0:
        return (prod=1)
    end
    # size is not zero
    let (prod_of_rest) = array_product(arr = arr + 2, size = size - 2)
    return (prod = [arr] * prod_of_rest)
end

func main{output_ptr: felt*}():
    const ARRAY_SIZE=4

    let (ptr) = alloc()

    # when allocating elements to an array, we need to assert (it allocates or checks)
    assert [ptr] = 2
    assert [ptr + 1] = 4
    assert [ptr + 2] = 10
    assert [ptr + 3] = 20

    let (prod) = array_product(arr = ptr, size = ARRAY_SIZE)

    serialize_word(prod)

    return()
end
