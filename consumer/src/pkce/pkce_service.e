note
	description: "Object implementing PKCE service by OAuth Client"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name", "src=https://tools.ietf.org/html/rfc7636#section-4.1", "protocol=URI"

class
	PKCE_SERVICE

inherit

	SHARED_BASE64

create
	make

feature {NONE} -- Initialization

	make (a_octets: INTEGER)
			-- Create a random number generator using `a_number_of_octects`.
			-- it recommended to use 32-octects.
			--|   NOTE: The code verifier SHOULD have enough entropy to make it
			--|   impractical to guess the value.  It is RECOMMENDED that the output of
			--|   a suitable random number generator be used to create a 32-octet
			--|   sequence.  The octet sequence is then base64url-encoded to produce a
			--|   43-octet URL safe string to use as the code verifier.	
		do
			octet_length := a_octets
		ensure
			octet_length_set: octet_length = a_octets
		end

feature -- Access

	octet_length: INTEGER
			-- octect length.


feature -- Generate PKCE

	generate_pkce_sha256: PKCE
		local
			random: SALT_XOR_SHIFT_64_GENERATOR
		do
			create random.make (octet_length)
			Result := generate_pkce_sha256_with_data (random.new_sequence)
		end

	generate_pkce_plain: PKCE
		local
			random: SALT_XOR_SHIFT_64_GENERATOR
		do
			create random.make (octet_length)
			Result := generate_pkce_plain_with_data (random.new_sequence)
		end


	generate_pkce_sha256_with_data (a_bytes: ARRAY [NATURAL_8]): PKCE
		local
			code_verifier: STRING
		do
			code_verifier := bytes_encoded_string (a_bytes)
			create Result.make_sha256
			Result.set_code_verifier (code_verifier)
			Result.set_code_challenge (Result.code_challenge_method.transform_code_challenge (code_verifier))
		end

	generate_pkce_plain_with_data (a_bytes: ARRAY [NATURAL_8]): PKCE
		local
			code_verifier: STRING
		do
			code_verifier := bytes_encoded_string (a_bytes)
			create Result.make_plain
			Result.set_code_verifier (code_verifier)
			Result.set_code_challenge (Result.code_challenge_method.transform_code_challenge (code_verifier))
		end


feature {NONE} -- Base64 implementation

	bytes_encoded_string (a_bytes: READABLE_INDEXABLE [NATURAL_8]): STRING_8
			-- base64 encoded value of `a_bytes'.
		local
			i,n: INTEGER
			i1,i2,i3: INTEGER
			l_map: READABLE_STRING_8
		do
			l_map := character_map
			n := 4 * ((a_bytes.upper - a_bytes.lower + 1 + 2) // 3)

			from
				i := a_bytes.lower
				create Result.make (n)
				n := a_bytes.upper
			until
				i > n
			loop
				i1 := a_bytes[i].as_integer_32
				if i < n then
					i := i + 1
					i2 := a_bytes[i].as_integer_32
					if i < n then
						i := i + 1
						i3 := a_bytes[i].as_integer_32
					else
						i3 := -1
					end
				else
					i2 := -1
				end

				append_triple_encoded_to (i1, i2, i3, l_map, Result)
				i := i + 1
			end

				--base64url
				--https://tools.ietf.org/html/rfc7636#appendix-A
			Result.replace_substring_all ("+", "-")
			Result.replace_substring_all ("/", "_")
			Result.prune_all_trailing ('=')
		end

	append_triple_encoded_to (i1,i2,i3: INTEGER; a_map: READABLE_STRING_8; a_output: STRING)
		do
			--| [ 'f'  ][ 'o'  ][ 'o'  ]
			--| [ 102  ][ 111  ][ 111  ]
			--| 011001100110111101101111
			--| 011001100110111101101111
			--| [ 25 ][ 38 ][ 61 ][ 47 ]
			--| [  Z ][  m ][  9 ][  v ]
			a_output.extend (a_map.item (1 + i1 |>> 2))
			if i2 >= 0 then
				a_output.extend (a_map.item (1 + (i1 |<< 4 & 0b111111) + (i2 |>> 4 & 0b111111) ))
				if i3 >= 0 then
					a_output.extend (a_map.item (1 + (i2 |<< 2 & 0b111111) + (i3 |>> 6 & 0b111111) ))
					a_output.extend (a_map.item (1 + (i3 & 0b111111) ))
				else
					a_output.extend (a_map.item (1 + (i2 |<< 2 & 0b111111) ))
					a_output.append_character ('=')
				end
			else
				a_output.extend (a_map.item (1 + (i1 |<< 4) & 0b111111))
				a_output.append_character ('=')
				a_output.append_character ('=')
			end
		end


	character_map: STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
			--|              0123456789012345678901234567890123456789012345678901234567890123
			--|              0         1         2         3         4         5         6
			--| pad= '='



;note
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
