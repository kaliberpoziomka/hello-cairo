from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.squash_dict import squash_dict

struct KeyValue:
    member key: felt,
    member value: felt
end


# Builds a DictAccess list for the computation of the cumulative sum for each key
func build_dict(list: KeyValue*, size, dict: DictAccess*) -> (
    dict
):
    if size == 0:
        return(dict = dict)
    end

    %{
        # Populate ids.dict.prev_value using cumulative_sums..
        # Add list.value to cumulative_sums[list.key]..
    %}
    # Copy list.key to dict key..
    # Verify that dict.new_value = dict.prev_value + list.value...
    # Call recursively to build_dict()...
end

# Verifies that the initial values were 0 and writes the final values to result
func verify_and_output_squashed_dict(
    squashed_dict: DictAccess*,
    squashed_dict_end: DictAccess*,
    result: KeyValue*
) -> (result):
    tempvar diff = squashed_dict_end - squash_dict
    if diff == 0:
        return (result = result)
    end

    # Verify prev_value is 0...
    # Copy key to result.key..
    # Copy new_value to result.value..
    # Call recursively to verify_and_output_squashed_dict..
end

# Given a list of KeyValue, sums the values, grouped by key,
# and returns a list of pairs (key, sum_of_values)
func sum_by_key{range_check_ptr}(list: KeyValue*, size) -> (
    result, result_size
):
    