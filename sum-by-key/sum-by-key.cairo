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