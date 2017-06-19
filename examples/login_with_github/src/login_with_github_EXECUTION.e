note
	description: "[
				application execution
			]"
	date: "$Date: 2016-10-21 10:45:18 -0700 (Fri, 21 Oct 2016) $"
	revision: "$Revision: 99331 $"

class
	LOGIN_WITH_GITHUB_EXECUTION


inherit

	WSF_FILTERED_ROUTED_EXECUTION

	WSF_URI_HELPER_FOR_ROUTED_EXECUTION

	WSF_URI_TEMPLATE_HELPER_FOR_ROUTED_EXECUTION

	SHARED_DATABASE



create
	make

feature {NONE} -- Initialization



feature -- Filter

	create_filter
			-- Create `filter'
		do
				--| Example using Maintenance filter.
			create {WSF_MAINTENANCE_FILTER} filter
		end

	setup_filter
			-- Setup `filter'
		local
			f: like filter
		do
			create {WSF_CORS_FILTER} f
			f.set_next (create {LOGIN_WITH_GITHUB_FILTER})

				--| Chain more filters like {WSF_CUSTOM_HEADER_FILTER}, ...
				--| and your owns filters.

			filter.append (f)
		end


feature -- Router

	setup_router
			-- Setup `router'
		local
			fhdl: WSF_FILE_SYSTEM_HANDLER
			l_path: PATH
		do

				 -- HTML uri/uri templates.
 			map_uri_agent ("/", agent handle_home_page, router.methods_GET)
 			map_uri_agent ("/about", agent handle_about_page, router.methods_GET)
 			map_uri_agent ("/messages", agent handle_messages_page, router.methods_get_post)
 			map_uri_agent ("/login_with_github", agent handle_login_with_github, router.methods_get)
 			map_uri_agent ("/login_with_github_callback", agent handle_login_with_github_callback, router.methods_get)
 			map_uri_agent ("/logout", agent handle_logout, router.methods_get)
 			map_uri_template_agent ("/messages/{id}", agent handle_item_page, router.methods_get)


					--| Files publisher
			create l_path.make_from_string ("www")
			create fhdl.make_hidden_with_path (l_path)
			fhdl.disable_index
			router.handle ("/", fhdl, router.methods_GET)
		end


feature  -- Handle HTML pages

 	handle_home_page (req: WSF_REQUEST; res: WSF_RESPONSE)
 		local
 			l_hp: HOME_PAGE
 		do
 			if attached req.http_host as l_host then
 				create l_hp.make (req.absolute_script_url (""), req.execution_variable ("user"))
 				if attached l_hp.representation as l_home_page then
 					compute_response_get (req, res, l_home_page)
 				end
 			end
 		end

 	handle_about_page (req: WSF_REQUEST; res: WSF_RESPONSE)
 		local
 			l_ap: ABOUT_PAGE
 		do
 			if attached req.http_host as l_host then
 				create l_ap.make (req.absolute_script_url (""), req.execution_variable ("user"))
 				if attached l_ap.representation as l_about_page then
 					compute_response_get (req, res, l_about_page)
 				end
 			end
  		end

 	handle_messages_page (req: WSF_REQUEST; res: WSF_RESPONSE)
  		local
 			l_lp: LIST_PAGE
 			l_401: UNAUTHORIZED_PAGE
  		do
 			if attached req.http_host as l_host and then
 			   attached {STRING_32} req.execution_variable ("user") as l_user
 			then
 				if req.is_get_request_method then
 					create l_lp.make (req.absolute_script_url (""), db_items (database), l_user)
 					if attached l_lp.representation as l_list_page then
 						compute_response_get (req, res, l_list_page )
 					end
 				elseif req.is_post_request_method then
 					if attached {WSF_VALUE} req.form_parameter ("message") as l_value then
 						db_put (database,l_user, l_value.as_string.value)
 						compute_response_redirect (req, res, req.absolute_script_url ("/messages/"+db_count(database).out ))
 					end

 				else
 					 -- Method not allowed.
 				end
 			else
 				create l_401.make (req.absolute_script_url (""))
 				if attached l_401.representation as l_unauthorized then
 					compute_response_401 (req, res, l_unauthorized )
 				end
 			end
  		end

 	handle_item_page (req: WSF_REQUEST; res: WSF_RESPONSE)
 		local
 			l_ip: ITEM_PAGE
 			l_401: UNAUTHORIZED_PAGE
 		do
 			if
 				attached req.http_host as l_host and then
 			   	attached {STRING_32} req.execution_variable ("user") as l_user and then
 				attached req.path_parameter ("id") as l_id
 			then
 			   	if attached db_exclusive_search (database, l_id.as_string.value.to_integer_64) as l_message then
 			   		create l_ip.make ( req.absolute_script_url (""), l_message, l_user)
 			   		if attached l_ip.representation as l_item then
 			   			compute_response_get (req, res, l_item)
 			   		end
 			   	end
 			else
 				create l_401.make (req.absolute_script_url (""))
 				if attached l_401.representation as l_unauthorized then
 					compute_response_401 (req, res, l_unauthorized )
 				end
 			end
 		end

 	handle_login_with_github (req: WSF_REQUEST; res: WSF_RESPONSE)
 		local
 			l_github_service: LOGIN_WITH_GITHUB_SERVICE
 		do
 			create l_github_service.make
 			if attached l_github_service.authorization_url as l_authorization then
 				compute_response_redirect (req, res, l_authorization)
 			end

 		end

 	handle_login_with_github_callback (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_github_service: LOGIN_WITH_GITHUB_SERVICE
			l_cookie: WSF_COOKIE
	 	do
			if attached {WSF_STRING} req.query_parameter ("code") as l_code then
				create l_github_service.make
				l_github_service.sign_request (l_code.value)
				if
					l_github_service.status = 200 and then
					attached l_github_service.access_token as l_access_token and then
					attached l_github_service.response as l_response and then
					attached l_github_service.user as l_user
				then
					create l_cookie.make ({LOGIN_WITH_GITHUB_CONSTANTS}.oauth_session_token, l_access_token.token)
					if l_access_token.expires_in = 0 then
						l_cookie.set_max_age (3600)
					else
						l_cookie.set_max_age (l_access_token.expires_in)
					end
					l_cookie.set_path ("/")
					res.add_cookie (l_cookie)
					create l_cookie.make ({LOGIN_WITH_GITHUB_CONSTANTS}.oauth_user_login, l_user)
					if l_access_token.expires_in = 0 then
						l_cookie.set_max_age (3600)
					else
						l_cookie.set_max_age (l_access_token.expires_in)
					end
					l_cookie.set_path ("/")
					res.add_cookie (l_cookie)
				else
					-- Add response with login error.
				end
			end
			compute_response_redirect (req, res, req.absolute_script_url (""))
		end

	handle_logout (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_cookie: WSF_COOKIE
		do
			if
				attached {WSF_STRING} req.cookie ({LOGIN_WITH_GITHUB_CONSTANTS}.oauth_session_token) as l_cookie_token
			then
				req.unset_execution_variable ("user")
					-- Logout OAuth
				create l_cookie.make ({LOGIN_WITH_GITHUB_CONSTANTS}.oauth_session_token, l_cookie_token.value)
				l_cookie.set_path ("/")
				l_cookie.set_max_age (0)
				res.add_cookie (l_cookie)

					-- Logout OAuth
				create l_cookie.make ({LOGIN_WITH_GITHUB_CONSTANTS}.oauth_user_login, "Logout")
				l_cookie.set_path ("/")
				l_cookie.set_max_age (0)
				res.add_cookie (l_cookie)

				req.unset_execution_variable ("user")

			end
			compute_response_redirect (req, res, req.absolute_script_url (""))
		end

 feature  -- Response

 	compute_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
 		local
 			h: HTTP_HEADER
 			l_msg: STRING
 			hdate: HTTP_DATE
 		do
 			create h.make
 			create l_msg.make_from_string (output)
 			h.put_content_type_text_html
 			h.put_content_length (l_msg.count)
 			if attached req.request_time as time then
 				create hdate.make_from_date_time (time)
 				h.add_header ("Date:" + hdate.rfc1123_string)
 			end
 			res.set_status_code ({HTTP_STATUS_CODE}.ok)
 			res.put_header_text (h.string)
 			res.put_string (l_msg)
 		end


 	compute_response_401 (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
 		local
 			h: HTTP_HEADER
 			l_msg: STRING
 			hdate: HTTP_DATE
 		do
 			create h.make
 			create l_msg.make_from_string (output)
 			h.put_content_type_text_html
 			h.put_content_length (l_msg.count)
 			if attached req.request_time as time then
 				create hdate.make_from_date_time (time)
 				h.add_header ("Date:" + hdate.rfc1123_string)
 			end
 			res.set_status_code ({HTTP_STATUS_CODE}.unauthorized)
 			res.put_header_text (h.string)
 			res.put_string (l_msg)
 		end

 	compute_response_redirect (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
 		local
 			h: HTTP_HEADER
 			l_msg: STRING
 			hdate: HTTP_DATE
 		do
 			create h.make
 			create l_msg.make_from_string (output)
 			h.put_content_type_text_html
 			if attached req.request_time as time then
 				create hdate.make_from_date_time (time)
 				h.add_header ("Date:" + hdate.rfc1123_string)
 				h.add_header ("Location:" + output)
 			end
 			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
 			res.put_header_text (h.string)
 			res.put_string (l_msg)
 		end

 feature -- Database Access

	db_exclusive_search (a_db: like database; a_id: INTEGER_64): detachable MESSAGES
		do
			if attached a_db.search (a_id) as l_item then
				create Result.make_from_separate (l_item)
			end
		end

	db_items (a_db: like database): LIST [MESSAGES]
		local
			l_msg: MESSAGES
		do
			create {ARRAYED_LIST [MESSAGES]} Result.make (0)
			across a_db.items as ic loop
				create l_msg.make_from_separate (ic.item)
				Result.force (l_msg)
			end
		end

	db_put (a_db: like database; a_user, a_value: separate READABLE_STRING_32)
		do
			a_db.put (a_user,a_value)
		end

	db_count (a_database: like database): INTEGER
		do
			Result := a_database.items.count
		end

end
