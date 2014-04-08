note
	description: "Summary description for {OAUTH_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_CONFIG

create
	make_default, make

feature {NONE} -- Initializaton

	make (a_key: like api_key; a_secret: like api_secret; a_callback: like callback; a_signature: like signature_type; a_scope: like scope; a_stream: like debug_stream)
		do
			api_key := a_key
			api_secret := a_secret
			callback := a_callback
			signature_type := a_signature
			scope := a_scope
			debug_stream := a_stream
		ensure
			key_set: api_key = a_key
			secret_Set: api_secret = a_secret
			callback_set: attached callback as l_callback implies l_callback = a_callback
			signature_type_set: attached signature_type as l_signature implies l_signature = a_signature
			scope_set: attached scope implies has_scope
			debug_stream_set: attached debug_stream as l_debug_stream implies l_debug_stream = a_stream
		end

	make_default (a_key: like api_key; a_secret: like api_secret)
		do
			make (a_key, a_secret, Void, Void, Void, Void)
		ensure
			key_set: api_key = a_key
			secret_Set: api_secret = a_secret
		end

feature -- Access

	api_key: READABLE_STRING_GENERAL

	api_secret: READABLE_STRING_GENERAL

	callback: detachable READABLE_STRING_GENERAL

	signature_type: detachable OAUTH_SIGNATURE_TYPE

	scope: detachable READABLE_STRING_GENERAL

	debug_stream: detachable STRING

	grant_type: detachable STRING

	state: detachable STRING

feature -- Status Report

	has_scope: BOOLEAN
		do
			Result := attached scope
		end

feature -- Change Element

	set_callback (a_callback: like callback)
			-- Set callback with `a_callback'
		do
			callback := a_callback
		ensure
			callback_set: attached callback as l_callback implies l_callback = a_callback
		end

	set_scope (a_scope: READABLE_STRING_GENERAL)
			-- Set scope with `a_scope'
		do
			scope := a_scope
		ensure
			scope_set: attached scope as l_scope implies l_scope = a_scope
		end

	set_grant_type (a_type: READABLE_STRING_GENERAL)
			-- Set grant_type with `a_type'
		do
			grant_type := a_type.as_string_32
		ensure
			grant_type_set: attached grant_type as l_grant_type implies l_grant_type = a_type
		end

	set_signature_type (a_signature: OAUTH_SIGNATURE_TYPE)
			-- Set signature_type with `a_signature'
		do
			signature_type := a_signature
		ensure
			signature_type_set: attached signature_type as l_signature_type implies l_signature_type = a_signature
		end

	set_state (a_state: READABLE_STRING_GENERAL)
			-- Set `state' with `a_state'
		do
			state := a_state.as_string_32
		ensure
			state_set: attached state as l_state implies l_state = a_state
		end

note
	copyright: "2013-2014, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
