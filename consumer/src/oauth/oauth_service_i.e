note
	description: "Summary description for {OAUTH_SERVICE_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OAUTH_SERVICE_I

feature -- Access

	request_token: detachable OAUTH_TOKEN
			-- retrieve the request token
		deferred
		end

	access_token_get (a_request_token: detachable OAUTH_TOKEN; verifier: OAUTH_VERIFIER): detachable OAUTH_TOKEN
			-- retrive an access token using a request token using GET
			-- (obtained previously)
		deferred
		end

	access_token_post (a_request_token: detachable OAUTH_TOKEN; verifier: detachable OAUTH_VERIFIER): detachable OAUTH_TOKEN
			-- retrive an access token using a request token using POST
			-- (obtained previously)
		deferred
		end

	sign_request (an_access_token: OAUTH_TOKEN; a_req: OAUTH_REQUEST)
			-- Signs an OAuth request using an access token (obtained previously)
		deferred
		end

	version: READABLE_STRING_GENERAL
			-- OAuth version of the service

	authorization_url (a_request_token: detachable OAUTH_TOKEN): detachable READABLE_STRING_GENERAL
			-- URL where you should redirect your users to authenticate
			-- your application.
			-- a request token needed to authorize
		deferred
		end

end
