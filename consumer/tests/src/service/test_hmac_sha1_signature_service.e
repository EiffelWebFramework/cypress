note
	description: "Summary description for {TEST_HMAC_SHA1_SIGNATURE_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_HMAC_SHA1_SIGNATURE_SERVICE

inherit

	EQA_TEST_SET

feature -- Tests

	test_return_signature
		local
			l_service : HMAC_SHA1_SIGNATURE_SERVICE
			l_expected: STRING
		do
			l_expected := "uGymw2KHOTWI699YEaoi5xyLT50="
			create l_service
			assert("Expected:uGymw2KHOTWI699YEaoi5xyLT50==", l_service.signature ("base string", "api secret", "token secret").is_equal (l_expected))
		end
end
