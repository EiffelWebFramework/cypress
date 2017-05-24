note
	description: "Summary description for {TWITTER_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=REST API", "src=https://dev.twitter.com/rest/reference", "protocol=uri"

deferred class
	TWITTER_I

feature {NONE} -- Initialization

	make (a_consumer_key: TWITTER_CONSUMER_TOKEN; a_access_key: TWITTER_ACCESS_TOKEN)
		deferred
		end

	make_with_source (a_consumer_key: TWITTER_CONSUMER_TOKEN; a_access_key: TWITTER_ACCESS_TOKEN; a_source: STRING)
		deferred
		end

feature -- Status Report

	last_status_code: INTEGER
			-- Return the HTTP status code from the last request.
		deferred
		end

feature -- Twitter: Account Methods

	verify_credentials (a_params: detachable TWITTER_VERIFY_CREDENTIALS_PARAMS): detachable TWITTER_USER
			--Returns an HTTP 200 OK response code and a representation of the requesting user
			-- if authentication was successful;
			-- returns a 401 status code and an error message if not.
			-- Use this method to test if supplied user credentials are valid.
			-- URL https://api.twitter.com/1.1/account/verify_credentials.json
			-- Response formats	JSON
			-- Requires authentication?	Yes (user context only)
			-- Rate limited?	Yes
			-- Requests / 15-min window (user auth)	75
		note
			EIS: "name=verify credentials", "src=https://dev.twitter.com/rest/reference/get/account/verify_credentials", "protocol=uri"
		deferred
		end

feature -- Twitter: GET - Status Methods

	home_timeline (a_params: detachable TWITTER_HOME_TIMELINE_PARAMS): detachable LIST [TWITTER_TWEETS]
			-- Returns a collection of the most recent Tweets and retweets posted by the authenticating user and the users they follow.
			-- The home timeline is central to how most users interact with the Twitter service.
			-- Up to 800 Tweets are obtainable on the home timeline. It is more volatile for users that follow many users or follow users who Tweet frequently.
			-- URL: https://api.twitter.com/1.1/statuses/home_timeline.json
			-- Response formats	JSON
			-- Requires authentication?	Yes (user context only)
			-- Rate limited?	Yes
			-- Requests / 15-min window (user auth)	15
		note
			EIS: "name=home timeline", "src=https://dev.twitter.com/rest/reference/get/statuses/home_timeline", "protocol=uri"
		deferred
		end

	user_timeline (a_params: detachable TWITTER_USER_TIMELINE_PARAMS): detachable LIST [TWITTER_TWEETS]
			-- Returns a collection of the most recent Tweets posted by the user indicated by the screen_name or user_id parameters.
			-- User timelines belonging to protected users may only be requested when the authenticated user either “owns” the timeline or is an approved follower of the owner.
			-- The timeline returned is the equivalent of the one seen as a user’s profile on twitter.com.
			-- This method can only return up to 3,200 of a user’s most recent Tweets.
			-- Native retweets of other statuses by the user is included in this total, regardless of whether include_rts is set to false when requesting this resource.
			-- URL: https://api.twitter.com/1.1/statuses/user_timeline.json
			-- Response formats	JSON
			-- Requires authentication?	Yes
			-- Rate limited?	Yes
			-- Requests / 15-min window (user auth)	900
			-- Requests / 15-min window (app auth)	1500	
		note
			EIS: "name=user timeline","src=https://dev.twitter.com/rest/reference/get/statuses/user_timeline", "protocol"
		deferred
		end

	mentions_timeline (a_params: detachable TWITTER_MENTIONS_TIMELINE_PARAMS): detachable LIST [TWITTER_TWEETS]
			-- Returns a collection of the most recent Tweets posted by the user indicated by the screen_name or user_id parameters.
			-- User timelines belonging to protected users may only be requested when the authenticated user either “owns” the timeline or is an approved follower of the owner.
			-- The timeline returned is the equivalent of the one seen as a user’s profile on twitter.com.
			-- This method can only return up to 3,200 of a user’s most recent Tweets.
			-- Native retweets of other statuses by the user is included in this total, regardless of whether include_rts is set to false when requesting this resource.
			-- URL: https://api.twitter.com/1.1/statuses/user_timeline.json
			-- Response formats	JSON
			-- Requires authentication?	Yes
			-- Rate limited?	Yes
			-- Requests / 15-min window (user auth)	900
			-- Requests / 15-min window (app auth)	1500	
		note
			EIS: "name=user timeline","src=https://dev.twitter.com/rest/reference/get/statuses/user_timeline", "protocol"
		deferred
		end

	show_tweet (a_params: TWITTER_STATUS_SHOW_PARAMS): detachable TWITTER_TWEETS
			-- Returns a single Tweet, specified by the id parameter. The Tweet’s author will also be embedded within the Tweet.
			-- URL: https://api.twitter.com/1.1/statuses/show.json
			-- Resource information
			-- Response formats	JSON
			-- Requires authentication?	Yes
			-- Rate limited?	Yes
			-- Requests / 15-min window (user auth)	900
			-- Requests / 15-min window (app auth)	900
		note
			EIS: "name=show", "src=https://dev.twitter.com/rest/reference/get/statuses/show/id", "protocol=uri"
		deferred
		end

	retweets_of_me (a_params: detachable TWITTER_RETWEET_OF_ME_PARAMS): detachable LIST [TWITTER_TWEETS]
			-- Returns the most recent Tweets authored by the authenticating user that have been retweeted by others.
			-- This timeline is a subset of the user’s GET statuses / user_timeline.
			-- URL: https://api.twitter.com/1.1/statuses/retweets_of_me.json
			-- Resource Information
			-- Response formats	JSON
			-- Requires authentication?	Yes (user context only)
			-- Rate limited?	Yes
			-- Requests / 15-min window (user auth)	75
		note
			EIS: "name=retweets of me","src=https://dev.twitter.com/rest/reference/get/statuses/retweets_of_me","protocol=uri"
		deferred
		end

feature -- Twitter: POST - Status Methods	

	tweet(a_params: TWITTER_STATUS_UPDATE_PARAMS): detachable TWITTER_TWEETS
			-- Updates the authenticating user’s current status, also known as Tweeting.
			-- For each update attempt, the update text is compared with the authenticating user’s recent Tweets.
			-- Any attempt that would result in duplication will be blocked, resulting in a 403 error.
			-- A user cannot submit the same status twice in a row.
			-- While not rate limited by the API, a user is limited in the number of Tweets they can create at a time.
			-- If the number of updates posted by the user reaches the current allowed limit this method will return an HTTP 403 error.
			-- URL https://api.twitter.com/1.1/statuses/update.json
			-- Response formats	JSON
			-- Requires authentication?	Yes (user context only)
			-- Rate limited?	Yes
		note
			EIS: "name=update","https://dev.twitter.com/rest/reference/post/statuses/update","protocol=uri"
		deferred
		end

end
