note
	description: "Summary description for {TEST_PKCE_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_PKCE_SERVICE

inherit

	EQA_TEST_SET

feature -- Tests


	test_generate_pkce
		note
			eis: "name=S256 code_challenge_method", "src=https://tools.ietf.org/html/rfc7636#appendix-B", "protocol=uri"
		local
			pkce_service: PKCE_SERVICE
			pkce: PKCE
		do
			create pkce_service.make (32)
			pkce := pkce_service.generate_pkce_sha256_with_data (bytes)

			assert ("Expected Challenge Method: Sha256", pkce.is_sha256)
			assert ("code_verifier", pkce.code_verifier.same_string ("dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk"))
			assert ("code_challenge", pkce.code_challenge.same_string ("E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM"))
		end

	bytes: ARRAY [NATURAL_8]
		do
			Result := <<116, 24, 223, 180, 151, 153, 224, 37, 79, 250, 96, 125, 216, 173,
      					187, 186, 22, 212, 37, 77, 105, 214, 191, 240, 91, 88, 5, 88, 83,
      					132, 141, 121>>
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
