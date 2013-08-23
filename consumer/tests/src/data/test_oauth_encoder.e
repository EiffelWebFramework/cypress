note
	description: "Summary description for {TEST_OAUTH_ENCODER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_OAUTH_ENCODER

inherit

	EQA_TEST_SET

feature -- Test

	test_encoder
		local
			encoder : OAUTH_ENCODER
			expected: STRING_32
		do
			expected := "[
				D0FY%2FSv%2B59DsEOVkTbIvBV1Kepc%3D
			]"
			expected.left_adjust
			expected.right_adjust
			create encoder
			assert("Expected equals",encoder.encoded_string ("D0FY/Sv+59DsEOVkTbIvBV1Kepc=").is_equal (expected))

		end

end
