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
--			test_fb_user_minimal
--			test_fb_user_with_all_basic_fields
--			test_fb_user_with_some_basic_fields
--			test_fb_user_friends
--			test_fb_user_friends_with_limits
--			test_fb_user_feed
--			test_fb_user_feed_and_delete
--			test_extended_token
--			test_user_time_line
--			test_fb_user_feed_with_link
			test_fb_user_upload_photo
		end

feature -- Get FB User Details.

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


feature -- Test User Friends

	test_fb_user_friends
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params: FB_USER_PARAMETER
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
		end

	test_fb_user_friends_with_limits
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params: FB_USER_PARAMETER
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
		end

feature -- Test User Feed.

	test_fb_user_feed
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params:FB_USER_FEED_PUBLISHING
			l_id: STRING
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_params.make (1)
			l_params.include_message ("Test form EiffelFB API")
			l_id := l_fb_api.user_feed_publish ("me", l_params)
			if attached l_id then
				print ("fb.com/"+l_id)
			end
		end

	test_fb_user_feed_with_link
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params:FB_USER_FEED_PUBLISHING
			l_id: STRING
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_params.make (1)
			l_params.include_message ("Eiffel community site.")
			l_params.include_link ("https://www.eiffel.org")
			l_id := l_fb_api.user_feed_publish ("me", l_params)
			if attached l_id then
				print ("fb.com/"+l_id)
			end
		end

	test_fb_user_upload_photo
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_file: PATH
			l_id: STRING
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_file.make_from_string ("ewf.jpg")
			l_id :=  l_fb_api.user_feed_publish_photo ("me", l_file)
			if attached l_id then
				print ("fb.com/"+l_id)
			end
		end


	test_fb_user_feed_and_delete
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params:FB_USER_FEED_PUBLISHING
			l_id: STRING
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			create l_params.make (1)
			l_params.include_message ("Test form EiffelFB API and then delete")
			l_id := l_fb_api.user_feed_publish ("me", l_params)
			if attached l_id then
				print (l_id)
				print (l_fb_api.delete_feed (l_id).out)
			end
		end

feature -- Test Extended Token

	test_extended_token
		local
			l_fb_api: FACEBOOK_I
			l_user: FB_USER
			l_retry: BOOLEAN
			l_params:FB_USER_FEED_PUBLISHING
			l_id: STRING
			l_access_token: FB_ACCESS_TOKEN
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			l_access_token := l_fb_api.extended_access_token (app_id, app_secret, access_token)
		end


feature -- Test User TimeLine

	test_user_time_line
		local
			l_fb_api: FACEBOOK_I
			l_post: FB_EDGES [FB_POST]
			l_page: INTEGER
			l_posts: INTEGER
		do
			create {FACEBOOK_JSON} l_fb_api.make (access_token)
			l_post := l_fb_api.user_timeline_posts ("me", Void)
			if attached l_post then
				from
					l_page := 1
					l_posts :=1
				until
					l_post.after
				loop
					across l_post.data as ic loop
						print (ic.item.basic_out)
						l_posts := l_posts + 1
					end
					l_post.forth
					l_page := l_page + 1
				end
				print ("%NNumber of Pages: " + l_page.out)
				print ("%NNumber of Posts: " + l_posts.out)
			end


		end
feature -- Implementation

	access_token: STRING = "EAACEdEose0cBAEVdF1cf1ltwQZB4QQXcAMTZCSsA35Nujua3P4TjlZAEZB2OOBB6lQd5V4dp00ZCN4SsZA2KFvZAbWyhQk7yAJtyQIfyZAZArcfosgJOumj7t89pISFhTZCy25ZB3Eu8IVKseduQVzcydli7szlEUHZA0o5pBDJ0gXK3x0bkP2FxW93Bhwe5JZBnRZBaQZD"
			-- Facebook access user token.

	app_id: STRING = ""
			-- Facebook app client id token.

	app_secret: STRING = ""
			-- Facebook app client secret token.


end
