note
	description: "test application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			test_fb_user_minimal
			test_fb_user_with_all_basic_fields
			test_fb_user_with_some_basic_fields
		end

	test_fb_user_minimal
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			l_user := l_fb_api.show_user ("me", Void)
			if attached l_user then
				print (l_user.basic_out)
			end
		end

	test_fb_user_with_all_basic_fields
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params: FB_USER_PARAMETER
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_params
			l_params.include_all_basic
			l_user := l_fb_api.show_user ("me", l_params)
			if attached l_user then
				print (l_user.basic_out)
			end
		end

	test_fb_user_with_some_basic_fields
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params: FB_USER_PARAMETER
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_params
			l_params.include_birthday
			l_params.include_email
			l_user := l_fb_api.show_user ("me", l_params)
			if attached l_user then
				print (l_user.basic_out)
			end
		end


feature -- Implementation

	access_token: STRING = ""
			-- Facebook access user token.


end
