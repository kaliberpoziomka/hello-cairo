struct Location:
    member row: felt
    member col: felt
end

# Verification that a location is valid
func verify_valid_location(loc: Location*):
    # Check that row is in the range 0-3
    tempvar row = loc.row
    assert row * (row - 1) * (row - 2) * (row - 3) = 0

    # Check that col is in the range 0-3
    tempvar col = loc.col
    assert col * (col - 1) * (col - 2) * (col - 3) = 0

    return()
end

# Verify that two locations are adjacent
func verify_adjacent_locations(
    loc0: Location*, loc1: Location*
):
    # difference between two adjacent location must be on of:
    # (0, 1), (0, -1), (1, 0), (-1, 0)


    # Allocate memory required for the local variables
    alloc_locals
    local row_diff = loc0.row - loc1.row
    local col_diff = loc0.col - loc1.col

    if row_diff == 0:
        # The row coordinate is the same. Make suer the difference in col is 1 or -1
        assert col_diff * col_diff = 1
        return()
    else:
        # Verify that the difference in row is 1 or -1
        assert row_diff * row_diff = 1
        # Verify that the col coordinate is the same
        assert col_diff = 0
        return()
    end
end

# Veryfying the list of locations
func verify_location_list(loc_list: Location*, n_steps):
    # Always verify the location is valid, even if n_steps = 0
    # becouse there is alawys one more location than steps
    verify_valid_location(loc = loc_list)

    if n_steps == 0:
        return()
    end

    verify_adjacent_locations(
        loc0=loc_list, loc1=loc_list + Location.SIZE
    )

    # Call verify_location_list recursively
    verify_location_list(
        loc_list = loc_list + Location.SIZE, n_steps=n_steps - 1
    )

    return ()

end


from starkware.cairo.common.registers import get_fp_and_pc

func main():
    alloc_locals

    local loc_tuple: (Location, Location, Location, Location, Location) = (
        Location(row=0, col=2),
        Location(row=1, col=2),
        Location(row=1, col=3),
        Location(row=2, col=3),
        Location(row=3, col=3),
    )

    # Get the value of the frame pointer register (fp) so that we can
    # use the address of loc_tuple
    let (__fp__, _) = get_fp_and_pc()
    # Since the tuple elements are next to each other we can use the 
    # address of loc_tuple as a pointer to the 5 locations
    verify_location_list(
        loc_list=cast(&loc_tuple, Location*), n_steps=4
    )
    return()
end
