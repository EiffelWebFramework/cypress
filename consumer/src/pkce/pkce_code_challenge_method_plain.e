note
	description: "Object Representing code challenge plain"
	date: "$Date$"
	revision: "$Revision$"

class
	PKCE_CODE_CHALLENGE_METHOD_PLAIN

inherit

	PKCE_CODE_CHALLENGE_METHOD


feature -- Access

	transform_code_challenge (a_code_verifier: STRING): STRING
		do
			Result := a_code_verifier
		end


note
	copyright: "2013-2019, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
