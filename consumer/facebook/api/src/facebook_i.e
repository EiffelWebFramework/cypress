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

	user_feed_publish (a_user_id: STRING; a_params: detachable FB_USER_FEED_PUBLISHING): detachable STRING
		deferred
		end

	delete_feed (a_post_id: STRING): BOOLEAN
		deferred
		end

feature -- User Friends Pagination.

		--|TODO check how to add a FB_CONNECTION/FB_EDGE
		--|The interface will be usable for FB Edges types.
		--|Implementing a CURSOR, so no need for this features.
		--|FB_USER_FRIENDS
	next_user_friends (a_uri: READABLE_STRING_8): detachable FB_USER_FRIENDS
		deferred
		end

	previous_user_friends (a_uri: READABLE_STRING_8): detachable FB_USER_FRIENDS
		deferred
		end


end
