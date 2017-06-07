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

feature --Facebook Access Token

	extended_access_token (a_app_id: STRING; a_app_secret: STRING; a_short_token: STRING): detachable FB_ACCESS_TOKEN
		deferred
		end

feature --Get - User

	show_user (a_user_id: STRING; a_params: detachable FB_USER_PARAMETER): detachable FB_USER
			-- Show a single user node `a_user_id', with optional parameters. `a_params'.
			-- GET /{a_user_id}
		note
			EIS: "name=User", "src=https://developers.facebook.com/docs/graph-api/reference/user", "protocol=uri"
		deferred
		end

	user_timeline_posts (a_user_id: STRING; a_params: detachable FB_POST_PARAMETER): detachable FB_EDGES [FB_POST]
			-- The feed of posts (including status updates) and links published by this person.
			-- GET /{a_user_id}/feed
		note
			EIS: "name=Feed", "src=https://developers.facebook.com/docs/graph-api/reference/user/feed", "protocol=uri"
		deferred
		end

	user_friends (a_user_id: STRING; a_params: detachable FB_USER_PARAMETER): detachable FB_EDGES [FB_USER]
			-- A person's friends.
		note
			EIS: "name=Friends", "src=https://developers.facebook.com/docs/graph-api/reference/user/friends", "protocol=uri"
		deferred
		end

feature	-- Post

	show_post (a_post_id: READABLE_STRING_32; a_params: detachable FB_POST_PARAMETER): detachable FB_POST
		deferred
		end

feature -- Feed: Publish, Delete

	user_feed_publish (a_user_id: STRING; a_params: detachable FB_USER_FEED_PUBLISHING): detachable STRING
		deferred
		end

	delete_feed (a_post_id: STRING): BOOLEAN
		deferred
		end



end
