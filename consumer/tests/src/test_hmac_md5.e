note
	description: "Summary description for {TEST_HMAC_MD5}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HMAC_MD5

inherit

	EQA_TEST_SET

feature -- Tests

	test_hmac_md5
		local
			hmac: HMAC_MD5
			expected: INTEGER_X
		do
			create hmac.make_ascii_key ("key")
			hmac.sink_string ("The quick brown fox jumps over the lazy dog")
			hmac.finish
			create expected.make_from_hex_string ("80070713463e7749b90c2dc24911e275")
			assert ("Expected", hmac.hmac.is_equal(expected))
		end


	test_rfc2202_1
		local
			hmac: HMAC_MD5
			expected: INTEGER_X
		do
			create hmac.make (create {INTEGER_X}.make_from_hex_string ("0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b"))
			hmac.sink_string ("Hi There")
			hmac.finish
			create expected.make_from_hex_string ("9294727a3638bb1c13f48ef8158bfc9d")
			assert ("test_rfc2202_1", hmac.hmac.is_equal (expected))
		end


	test_rfc2202_2
		local
			hmac: HMAC_MD5
			expected: INTEGER_X
		do
			create hmac.make_ascii_key ("Jefe")
			hmac.sink_string ("what do ya want for nothing?")
			hmac.finish
			create expected.make_from_hex_string ("750c783e6ab0b503eaa86e310a5db738")
			assert ("test_rfc2202_2", hmac.hmac.is_equal (expected))
		end


	test_rfc2202_5
		local
			hmac: HMAC_MD5
			expected: INTEGER_X
			hexa_data : INTEGER_X
		do
			create hmac.make(create {INTEGER_X}.make_from_hex_string ("c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c"))
			hmac.sink_string ("Test With Truncation")
			hmac.finish
			create expected.make_from_hex_string ("56461ef2342edc00f9bab995690efd4c")
			assert ("test_rfc2202_5", hmac.hmac.is_equal (expected))
		end


end
