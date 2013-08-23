note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"
	EIS : "name:HMAC-SHA1 test", "src=http://tools.ietf.org/html/rfc2202", "protocol=uri"

class
	TEST_HMAC_SHA1_SET

inherit
	EQA_TEST_SET

feature -- Test routines


	test_rfc2202_1
		local
			hmac: HMAC_SHA1
			expected: INTEGER_X
		do
			create hmac.make (create {INTEGER_X}.make_from_hex_string ("0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b"))
			hmac.sink_string ("Hi There")
			hmac.finish
			create expected.make_from_hex_string ("b617318655057264e28bc0b6fb378c8ef146be00")
			assert ("test_rfc2202_1", hmac.hmac.is_equal (expected))
		end


	test_rfc2202_2
		local
			hmac: HMAC_SHA1
			expected: INTEGER_X
		do
			create hmac.make_ascii_key ("Jefe")
			hmac.sink_string ("what do ya want for nothing?")
			hmac.finish
			create expected.make_from_hex_string ("effcdf6ae5eb2fa2d27416d5f184df9c259a7c79")
			assert ("test_rfc2202_2", hmac.hmac.is_equal (expected))
		end


	test_rfc2202_5
		local
			hmac: HMAC_SHA1
			expected: INTEGER_X
			hexa_data : INTEGER_X
		do
			create hmac.make(create {INTEGER_X}.make_from_hex_string ("0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c0c"))
			hmac.sink_string ("Test With Truncation")
			hmac.finish
			create expected.make_from_hex_string ("4c1a03424b55e07fe7f27be1d58bb9324a9a5a04")
			assert ("test_rfc2202_5", hmac.hmac.is_equal (expected))
		end


end


