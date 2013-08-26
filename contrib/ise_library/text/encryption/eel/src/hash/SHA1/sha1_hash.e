note
	description: "Summary description for {SHA1_HASH}."
	author: ""
	date: "$Date: 2013-08-23 16:06:19 +0200 (ven, 23 aoû 2013) $"
	revision: "$Revision: 92891 $"

class
	SHA1_HASH

inherit
	HASH
		undefine
			is_equal
		end

	SHA1

create
	make,
	make_copy

feature -- Access

	block_size: INTEGER = 64
			-- <Precursor>

	output_size: INTEGER = 20
			-- <Precursor>	

end
