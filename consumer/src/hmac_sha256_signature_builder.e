note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	HMAC_SHA256_SIGNATURE_BUILDER

inherit
	SIGNATURE_BUILDER

create
	make

feature -- Access

	signed_string (s: STRING_8; a_signing_key: READABLE_STRING_8): STRING_8
		local
			h: HMAC_SHA256
		do
			create h.make_ascii_key (a_signing_key)
			h.sink_string (s)
			h.finish
			Result := h.hmac.out_hex
		end

	signature_method: STRING_8 = "HMAC-SHA256"


end
