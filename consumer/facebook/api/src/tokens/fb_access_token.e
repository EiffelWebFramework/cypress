note
	description: "Summary description for {FB_ACCESS_TOKEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FB_ACCESS_TOKEN

feature -- Access

	access_token: detachable STRING
		-- A long live token generated from a short live token.

	expires_in: INTEGER_64

feature -- Change Element

	set_access_token (a_access_token: like access_token)
			-- Set `access_token' with `a_access_token'.
		do
			access_token := a_access_token
		ensure
			access_token_set: access_token = a_access_token
		end

	set_expires_in (a_val: like expires_in)
		do
			expires_in := a_val
		ensure
			expires_in_set: expires_in = a_val
		end
end
