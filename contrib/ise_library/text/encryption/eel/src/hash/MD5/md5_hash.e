note
	description: "Summary description for {MD5_HASH}."
	author: ""
	date: "$Date: 2013-08-23 16:06:19 +0200 (ven, 23 aoû 2013) $"
	revision: "$Revision: 92891 $"

class
	MD5_HASH

inherit
	HASH
		undefine
			is_equal
		end

	MD5

create
	make,
	make_copy

feature -- Access

	block_size: INTEGER = 64
			-- <Precursor>	

	output_size: INTEGER = 16
			-- <Precursor>

end
