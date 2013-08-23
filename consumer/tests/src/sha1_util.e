note
	description: "Summary description for {SHA1_UTIL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHA1_UTIL

inherit
	ARRAY_FACILITIES

feature

	sha1_digest (a_string: STRING): INTEGER_X
			-- SHA-1 produces a 160-bit (20-byte) hash value. A SHA-1 hash value is typically expressed as a hexadecimal number, 40 digits long.
		local
			r: STRING
			sha1: SHA1
		do
			create sha1.make
			sha1.sink_string (a_string)
			create r.make (40)
			r.append (sha1.current_out)
			r.remove_head (2)
			create Result.make_from_hex_string (r)
		end

	bytestring (i: READABLE_INTEGER_X): STRING
		do
			Result := i.out_base (16).as_lower
		end

--	sha1_digest (a_string: STRING): STRING
--			-- SHA-1 produces a 160-bit (20-byte) hash value. A SHA-1 hash value is typically expressed as a hexadecimal number, 40 digits long.
--		local
--			sha1: SHA1
--			output: SPECIAL [NATURAL_8]
--		do
--			create sha1.make
--			create output.make_filled (0, 20)
--			sha1.sink_string (a_string)
--			sha1.do_final (output, 0)
--			Result := as_natural_32_be (output, 0).to_hex_string
--			Result.append (as_natural_32_be (output, 4).to_hex_string)
--			Result.append (as_natural_32_be (output, 8).to_hex_string)
--			Result.append (as_natural_32_be (output, 12).to_hex_string)
--			Result.append (as_natural_32_be (output, 16).to_hex_string)
--		end

	hmac_sha1 (key: STRING; msg: STRING): STRING
		local
			l_key: STRING
			reduced_key: READABLE_INTEGER_X
			ipad: SPECIAL [NATURAL_8]
			opad: SPECIAL [NATURAL_8]
			i_key_pad: INTEGER_X
			o_key_pad: INTEGER_X
		do
			create l_key.make_filled ('%U', 64)
			if key.count > 64 then
				l_key := bytestring(sha1_digest (key))
			else
				l_key.prepend_string_general (key)
				l_key := l_key.substring (1, 64)
			end
			reduced_key := build_bytes (l_key)
			ipad := (reduced_key.bit_xor_value (create {INTEGER_X}.make_from_hex_string ("36363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636363636"))).as_fixed_width_byte_array (64)
			opad := (reduced_key.bit_xor_value (create {INTEGER_X}.make_from_hex_string ("5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c5c"))).as_fixed_width_byte_array (64)
			create i_key_pad.make_from_bytes (ipad, 0, 63)
			create o_key_pad.make_from_bytes (opad, 0, 63)
			Result := bytestring (sha1_digest (bytestring(o_key_pad) + bytestring(sha1_digest (bytestring(i_key_pad) + msg))))
		end

	build_bytes (key_a: READABLE_STRING_8): INTEGER_X
		local
			key_bytes: SPECIAL [NATURAL_8]
			i: INTEGER
		do
			create key_bytes.make_filled (0, key_a.count)
			from
				i := 1
			until
				i > key_a.count
			loop
				key_bytes [i - 1] := key_a [i].code.to_natural_8
				i := i + 1
			end
			create Result.make_from_bytes (key_bytes, 0, key_bytes.count - 1)
		end

end
