note
	description: "[
		Object that represent a code challenge
		
		The client then creates a code challenge derived from the code
  		verifier by using one of the following transformations on the code
  		verifier
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Code Challenge", "src=https://tools.ietf.org/html/rfc7636#section-4.2", "protocol=URI"

deferred class
	PKCE_CODE_CHALLENGE_METHOD

feature -- Access

	transform_code_challenge (a_code_verifier: STRING): STRING
		deferred
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
