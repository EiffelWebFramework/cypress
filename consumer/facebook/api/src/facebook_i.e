note
	description: "Summary description for {FACEBOOK_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FACEBOOK_I

feature {NONE} -- Initialization

		-- TODO check the different types of
		-- FB access tokens
		-- https://developers.facebook.com/docs/facebook-login/access-tokens
		-- At the moment using https://developers.facebook.com/docs/facebook-login/access-tokens#usertokens
	make (a_access_token: READABLE_STRING_32)
		deferred
		end


feature -- Status Report

	last_status_code: INTEGER
			-- Return the HTTP status code from the last request.
		deferred
		end

feature -- Facebook: Get - User

	show_user (a_user_id: STRING; a_params: detachable FB_USER_PARAMETER): detachable FB_USER
		deferred
		end

end
