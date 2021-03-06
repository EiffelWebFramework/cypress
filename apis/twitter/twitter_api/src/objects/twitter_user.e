﻿note
	description: "[
		Users can be anyone or anything. They Tweet, follow, create lists, have a home_timeline, can be mentioned, and can be looked up in bulk.
	]"
	author: "Jocelyn Fiat"
	date: "$Date: 2009-03-18 12:43:03 +0100 (Wed, 18 Mar 2009) $"
	revision: "$Revision: 16 $"
	EIS: "name=Object USER", "src=https://dev.twitter.com/overview/api/users", "protocol=uri"

class
	TWITTER_USER

inherit

	REFACTORING_HELPER

feature -- Access: Basic

	id: INTEGER_64
			-- The integer representation of the unique identifier for this User.
			-- This number is greater than 53 bits and some programming languages may have difficulty/silent defects in interpreting it.
			-- Using a signed 64 bit integer for storing this identifier is safe. Use
			-- id_str for fetching the identifier to stay on the safe side. See `Twitter IDs, JSON and
			-- Snowflake </overview/api/twitter-ids-json-and-snowflake>`__ .
			-- Example:
			-- "id":6253282

	name: detachable STRING
			-- full name of a registered user

	screen_name: detachable STRING
			-- display name for a user
			-- Examples: tweetybird, johnd

	description: detachable STRING_32
			-- 160 characters or less of text that describes a user
			-- Examples: empty (Default), I like new shiny things.	

	profile_image_url: detachable STRING
			-- location to a user's avatar file
			-- Examples:  http://static.twitter.com/images/default_profile_normal.png (Default), http://s3.amazonaws.com/twitter_production/profile_images/14198354/sweet_avatar.jpg

	url: detachable STRING
			-- user's homepage
			-- Examples: empty, http://downforeveryoneorjustme.com	

	protected: BOOLEAN
			-- boolean indicating if a user has a protected profile
		note
			EIS: "name=Public and Protected Tweets", "src=https://support.twitter.com/articles/14016-about-public-and-protected-tweets", "protocol=uri"
		attribute
		end

	followers_count: INTEGER
			-- number of users following a user's updates

	status: detachable TWITTER_TWEETS
			-- Latest update status
			-- In some circumstances, this data cannot be provided and this field will be omitted, null, or empty
		note
			EIS: "name=Embedded objects stale or inaccurate", "src=https://dev.twitter.com/docs/faq/basics/why-are-embedded-objects-stale-or-inaccurate", "protocol=uri"
		attribute
		end

feature -- Access: Extended	


	profile_background_color: detachable STRING
			-- hex RGB value for a user's background color
			-- Example: 9ae4e8 (Default)	

	profile_text_color: detachable STRING
			-- hex RGB value for a user's text color
			-- Example: 000000 (Default)

	profile_link_color: detachable STRING
			-- hex RGB value for a user's link color
			-- Example: 0000ff (Default)	

	profile_sidebar_fill_color: detachable STRING
			-- hex RGB value for a user's sidebar color
			-- Example: e0ff92 (Default)	

	profile_sidebar_border_color: detachable STRING
			-- hex RGB value for a user's border color
			-- Example: 87bc44 (Default)

	friends_count: INTEGER
			-- number of users a user is following

	created_at: detachable STRING
			-- timestamp of element creation, either status or user
			-- Example: Sat Jan 24 22:14:29 +0000 2009

	favorites_count: INTEGER
			-- number of statuses a user has marked as favorite

	utc_offset: INTEGER
			-- number of seconds between a user's registered time zone and Coordinated Universal Time
			-- Examples: -21600 (Default), 36000	

	time_zone: detachable STRING
			-- a user's time zone
			-- Examples: Central Time (US & Canada) (Default), Sydney	

	profile_background_image_url: detachable STRING
			-- location of a user's background image
			-- Examples: empty, http://static.twitter.com/images/themes/theme1/bg.gif (Default), http://s3.amazonaws.com/twitter_production/profile_background_images/2752608/super_sweet.jpg	

	profile_background_tile: BOOLEAN
			-- boolean indicating if a user's background is tiled

	following: BOOLEAN
			-- boolean indicating if a user is following a given user

	notifications: BOOLEAN
			-- boolean indicating if a user is receiving device updates for a given user
		obsolete
			"Deprecated by Twitter API"
		attribute
		end

	statuses_count: INTEGER
			-- the total number of status updates performed by a user, excluding direct messages sent.

	contributors_enabled: BOOLEAN
			-- Indicates that the user has an account with  contributor mode  enabled, allowing for Tweets issued by the user to be co-authored by another account.
			-- Rarely `` true`` .
			-- Example:
			-- "contributors_enabled": false

	default_profile: BOOLEAN
			-- `default_profile'
			-- When true, indicates that the user has not altered the theme or background of their user profile.
			-- Example:
			-- "default_profile": false

	default_profile_image: BOOLEAN
			-- When true, indicates that the user has not uploaded their own avatar and a default egg avatar is used instead.
			-- Example:
			-- "default_profile_image": false

	entities: detachable TWITTER_ENTITIES
			-- Entities which have been parsed out of the url or description fields defined by the user. Read more about User Entities.
			-- Example:
			--"entities": {
			--  "url": {
			--    "urls": [
			--      {
			--        "url": "http:\/\/dev.twitter.com",
			--        "expanded_url": null,
			--        "indices": [0, 22]
			--      }
			--    ]
			--  },
			--  "description": {"urls":[] }
			--}
		note
			EIS: "name=Object User Entities", "src=https://dev.twitter.com/overview/api/entities", "protocol=uri"
		attribute
		end

	favourites_count: INTEGER_32
			-- The number of tweets this user has favorited in the account s lifetime.
			-- British spelling used in the field name for historical reasons.
			-- Example:
			-- "favourites_count": 13


--	follow_request_sent: BOOLEAN
--			-- Nullable. Perspectival. When true, indicates that the authenticating user has issued a follow request to this protected user account.
--			-- Example:
--			-- "follow_request_sent":false
--          -- in the spec: TYPE


	geo_enabled: BOOLEAN
			-- When true, indicates that the user has enabled the possibility of geotagging their Tweets.
			-- This field must be true for the current user to attach geographic data when using POST statuses / update .
			-- Example:
			-- "geo_enabled": true

	id_str: detachable STRING
			-- The string representation of the unique identifier for this User.
			-- Implementations should use this rather than the large, possibly un-consumable integer in 'id' .
			-- Example:
			-- "id_str":"6253282"

	is_translator: BOOLEAN
			-- When true, indicates that the user is a participant in Twitter s translator community .
			-- Example:
			-- "is_translator": false

	lang: detachable STRING
			-- The BCP 47 code for the user s self-declared user interface language.
			-- May or may not have anything to do with the content of their Tweets.
			-- Examples:
			-- "lang": "en"
			-- "lang": "msa"
			-- "lang": "zh-cn"
		note
			EIS:"name=BCP_47", "src=http://tools.ietf.org/html/bcp47", "protocol=uri"
		attribute
		end

	listed_count: INTEGER
			-- The number of public lists that this user is a member of.
			-- Example:
			-- "listed_count":9274

	location: detachable STRING
			-- The user-defined location for this account s profile.
			-- Not necessarily a location nor parseable.
			-- This field will occasionally be fuzzily interpreted by the Search service.
			-- Example:
			-- "location":"San Francisco, CA"

	profile_banner_url: detachable STRING
			-- The HTTPS-based URL pointing to the standard web representation of the user s uploaded profile banner.
			-- By adding a final path element of the URL, you can obtain different image sizes optimized for specific displays.
			-- In the future, an API method will be provided to serve these URLs so that you need not modify the original URL.
			-- For size variations, please see User Profile Images and Banners .
			-- Example:
			-- "profile_banner_url": "https://si0.twimg.com/profile_banners/819797/1348102824"
		note
				EIS:"name=Profile Images and Banners", "src=https://dev.twitter.com/basics/user-profile-images-and-banners", "protocol=uri"
		attribute
		end


	profile_background_image_url_https: detachable STRING
			-- A HTTPS-based URL pointing to the background image the user has uploaded for their profile.
			-- Example:
			-- "profile_background_image_url_https":
			-- "https:\/\/si0.twimg.com\/profile_background_images\
			-- /229557229\/twitterapi-bg.png"


	profile_image_url_https: detachable STRING
			-- A HTTP-based URL pointing to the user s avatar image. See User Profile Images and Banners .
			-- Example:
			-- "profile_image_url":
			-- "http:\/\/a2.twimg.com\/profile_images\/1438634086\
			-- /avatar_normal.png"
		note
				EIS:"name=Profile Images and Banners", "src=https://dev.twitter.com/basics/user-profile-images-and-banners", "protocol=uri"
		attribute
		end

	profile_use_background_image: BOOLEAN
			-- When true, indicates the user wants their uploaded background image to be used.
			-- Example:
			-- "profile_use_background_image":true

	show_all_inline_media: BOOLEAN
			-- Indicates that the user would like to see media inline. Somewhat disused.
			-- Example:
			-- "show_all_inline_media": false

	verified: BOOLEAN
			-- When true, indicates that the user has a verified account. See Verified Accounts .
			-- Example:
			-- "verified": false
		note
			EIS: "name=Verified Accounts", "src=https://support.twitter.com/articles/119135-faqs-about-verified-accounts", "protocol=uri"
		attribute
		end

	withheld_in_countries: detachable STRING
			-- When present, indicates a textual representation of the two-letter country codes this user is withheld from.
			-- Example:
			-- "withheld_in_countries": "GR, HK, MY"


	withheld_scope: detachable STRING
			-- When present, indicates whether the content being withheld is the “status” or a “user.”
			-- Example:
			-- "withheld_scope": "user"

feature -- Access

	short_out: STRING
			-- <Precursor>
		local
			n: detachable STRING
		do
			to_implement ("TODO: review the current output")
			create Result.make_from_string ("USER#")
			Result.append_integer_64 (id)

			if attached screen_name as l_screen_name then
				n := l_screen_name.string
			end
			if attached name as l_name then
				if n /= Void and then not n.same_string (l_name) then
					n.prepend_string (l_name + " (")
					n.append_string (")")
				end
			end
			if n /= Void then
				Result.append_string (" %"")
				Result.append_string (n)
				Result.append_string ("%"")
			end
			if protected then
				Result.append_string (" +Protected")
			end
		end

	full_out: STRING
			-- <Precursor>
		local
			l_offset: STRING
		do
			to_implement ("TODO: add missing fields")

			l_offset := "  "

			create Result.make_from_string (short_out)
			Result.append_string ("%N")

			if attached location as l_location then
				Result.append_string (l_offset)
				Result.append_string ("location=")
				Result.append_string (l_location)
				Result.append_string ("%N")
			end
			if attached description as l_description then
				Result.append_string (l_offset)
				Result.append_string ("description=")
				Result.append_string (l_description)
				Result.append_string ("%N")
			end
			if attached url as l_url then
				Result.append_string (l_offset)
				Result.append_string ("url=")
				Result.append_string (l_url)
				Result.append_string ("%N")
			end
			if attached created_at as l_created_at then
				Result.append_string (l_offset)
				Result.append_string ("created_at=")
				Result.append_string (l_created_at)
				Result.append_string ("%N")
			end

			if statuses_count > 0 then
				Result.append_string (l_offset)
				Result.append_string ("statuses_count=")
				Result.append_integer (statuses_count)
				Result.append_string ("%N")
			end
			if followers_count > 0 then
				Result.append_string (l_offset)
				Result.append_string ("followers_count=")
				Result.append_integer (followers_count)
				Result.append_string ("%N")
			end
			if friends_count > 0 then
				Result.append_string (l_offset)
				Result.append_string ("friends_count=")
				Result.append_integer (friends_count)
				Result.append_string ("%N")
			end
			if favorites_count > 0 then
				Result.append_string (l_offset)
				Result.append_string ("favorites_count=")
				Result.append_integer (favorites_count)
				Result.append_string ("%N")
			end

			if following then
				Result.append_string (l_offset)
				Result.append_string ("following=")
				Result.append_boolean (True)
				Result.append_string ("%N")
			end
			if notifications then
				Result.append_string (l_offset)
				Result.append_string ("notifications=")
				Result.append_boolean (True)
				Result.append_string ("%N")
			end

			if attached time_zone as l_time_zone then
				Result.append_string (l_offset)
				Result.append_string ("time_zone=")
				Result.append_string (l_time_zone)
				if utc_offset /= 0 then
					Result.append_string (" (+" + utc_offset.out + " sec.)")
				end
				Result.append_string ("%N")
			end

			if attached status as l_status then
				Result.append_string (l_offset)
				Result.append_string ("status=[")
				Result.append_string (l_status.full_out) -- warning I sould use short_out.
				Result.append_string ("]%N")
			end
		end

feature -- Element change: basic

	set_id (a_id: like id)
			-- Set `id' to `a_id'
		do
			id := a_id
		end

	set_name (a_name: like name)
			-- Set `name' to `a_name'
		do
			name := a_name
		end

	set_screen_name (a_screen_name: like screen_name)
			-- Set `screen_name' to `a_screen_name'
		do
			screen_name := a_screen_name
		end

	set_location (a_location: like location)
			-- Set `location' to `a_location'
		do
			location := a_location
		end

	set_description (a_description: like description)
			-- Set `description' to `a_description'
		do
			description := a_description
		end

	set_profile_image_url (a_profile_image_url: like profile_image_url)
			-- Set `profile_image_url' to `a_profile_image_url'
		do
			profile_image_url := a_profile_image_url
		end

	set_url (a_url: like url)
			-- Set `url' to `a_url'
		do
			url := a_url
		end

	set_protected (a_protected: like protected)
			-- Set `protected' to `a_protected'
		do
			protected := a_protected
		end

	set_followers_count (a_followers_count: like followers_count)
			-- Set `followers_count' to `a_followers_count'
		do
			followers_count := a_followers_count
		end

	set_status (a_status: like status)
			-- Set `status' to `a_status'
		do
			status := a_status
		end


feature -- Element change: Extended	

	set_profile_background_color (a_profile_background_color: like profile_background_color)
			-- Set `profile_background_color' to `a_profile_background_color'
		do
			profile_background_color := a_profile_background_color
		end

	set_profile_text_color (a_profile_text_color: like profile_text_color)
			-- Set `profile_text_color' to `a_profile_text_color'
		do
			profile_text_color := a_profile_text_color
		end

	set_profile_link_color (a_profile_link_color: like profile_link_color)
			-- Set `profile_link_color' to `a_profile_link_color'
		do
			profile_link_color := a_profile_link_color
		end

	set_profile_sidebar_fill_color (a_profile_sidebar_fill_color: like profile_sidebar_fill_color)
			-- Set `profile_sidebar_fill_color' to `a_profile_sidebar_fill_color'
		do
			profile_sidebar_fill_color := a_profile_sidebar_fill_color
		end

	set_profile_sidebar_border_color (a_profile_sidebar_border_color: like profile_sidebar_border_color)
			-- Set `profile_sidebar_border_color' to `a_profile_sidebar_border_color'
		do
			profile_sidebar_border_color := a_profile_sidebar_border_color
		end

	set_friends_count (a_friends_count: like friends_count)
			-- Set `friends_count' to `a_friends_count'
		do
			friends_count := a_friends_count
		end

	set_created_at (a_created_at: like created_at)
			-- Set `created_at' to `a_created_at'
		do
			created_at := a_created_at
		end

	set_favorites_count (a_favorites_count: like favorites_count)
			-- Set `favorites_count' to `a_favorites_count'
		do
			favorites_count := a_favorites_count
		end

	set_utc_offset (a_utc_offset: like utc_offset)
			-- Set `utc_offset' to `a_utc_offset'
		do
			utc_offset := a_utc_offset
		end

	set_time_zone (a_time_zone: like time_zone)
			-- Set `time_zone' to `a_time_zone'
		do
			time_zone := a_time_zone
		end

	set_profile_background_image_url (a_profile_background_image_url: like profile_background_image_url)
			-- Set `profile_background_image_url' to `a_profile_background_image_url'
		do
			profile_background_image_url := a_profile_background_image_url
		end

	set_profile_background_tile (a_profile_background_tile: like profile_background_tile)
			-- Set `profile_background_tile' to `a_profile_background_tile'
		do
			profile_background_tile := a_profile_background_tile
		end

	set_following (a_following: like following)
			-- Set `following' to `a_following'
		do
			following := a_following
		end

	set_notifications (a_notifications: like notifications)
			-- Set `notifications' to `a_notifications'
		do
			notifications := a_notifications
		end

	set_statuses_count (a_statuses_count: like statuses_count)
			-- Set `statuses_count' to `a_statuses_count'
		do
			statuses_count := a_statuses_count
		end

feature -- Element change

	set_withheld_scope (a_withheld_scope: like withheld_scope)
			-- Assign `withheld_scope' with `a_withheld_scope'.
		do
			withheld_scope := a_withheld_scope
		ensure
			withheld_scope_assigned: withheld_scope = a_withheld_scope
		end

	set_withheld_in_countries (a_withheld_in_countries: like withheld_in_countries)
			-- Assign `withheld_in_countries' with `a_withheld_in_countries'.
		do
			withheld_in_countries := a_withheld_in_countries
		ensure
			withheld_in_countries_assigned: withheld_in_countries = a_withheld_in_countries
		end

	set_verified (a_verified: like verified)
			-- Assign `verified' with `a_verified'.
		do
			verified := a_verified
		ensure
			verified_assigned: verified = a_verified
		end

	set_show_all_inline_media (a_show_all_inline_media: like show_all_inline_media)
			-- Assign `show_all_inline_media' with `a_show_all_inline_media'.
		do
			show_all_inline_media := a_show_all_inline_media
		ensure
			show_all_inline_media_assigned: show_all_inline_media = a_show_all_inline_media
		end

	set_profile_use_background_image (a_profile_use_background_image: like profile_use_background_image)
			-- Assign `profile_use_background_image' with `a_profile_use_background_image'.
		do
			profile_use_background_image := a_profile_use_background_image
		ensure
			profile_use_background_image_assigned: profile_use_background_image = a_profile_use_background_image
		end

	set_profile_image_url_https (a_profile_image_url_https: like profile_image_url_https)
			-- Assign `profile_image_url_https' with `a_profile_image_url_https'.
		do
			profile_image_url_https := a_profile_image_url_https
		ensure
			profile_image_url_https_assigned: profile_image_url_https = a_profile_image_url_https
		end

	set_profile_background_image_url_https (a_profile_background_image_url_https: like profile_background_image_url_https)
			-- Assign `profile_background_image_url_https' with `a_profile_background_image_url_https'.
		do
			profile_background_image_url_https := a_profile_background_image_url_https
		ensure
			profile_background_image_url_https_assigned: profile_background_image_url_https = a_profile_background_image_url_https
		end

	set_profile_banner_url (a_profile_banner_url: like profile_banner_url)
			-- Assign `profile_banner_url' with `a_profile_banner_url'.
		do
			profile_banner_url := a_profile_banner_url
		ensure
			profile_banner_url_assigned: profile_banner_url = a_profile_banner_url
		end

	set_listed_count (a_listed_count: like listed_count)
			-- Assign `listed_count' with `a_listed_count'.
		do
			listed_count := a_listed_count
		ensure
			listed_count_assigned: listed_count = a_listed_count
		end

	set_lang (a_lang: like lang)
			-- Assign `lang' with `a_lang'.
		do
			lang := a_lang
		ensure
			lang_assigned: lang = a_lang
		end

	set_is_translator (an_is_translator: like is_translator)
			-- Assign `is_translator' with `an_is_translator'.
		do
			is_translator := an_is_translator
		ensure
			is_translator_assigned: is_translator = an_is_translator
		end

	set_id_str (an_id_str: like id_str)
			-- Assign `id_str' with `an_id_str'.
		do
			id_str := an_id_str
		ensure
			id_str_assigned: id_str = an_id_str
		end

	set_geo_enabled (a_geo_enabled: like geo_enabled)
			-- Assign `geo_enabled' with `a_geo_enabled'.
		do
			geo_enabled := a_geo_enabled
		ensure
			geo_enabled_assigned: geo_enabled = a_geo_enabled
		end

	set_favourites_count (a_favourites_count: like favourites_count)
			-- Assign `favourites_count' with `a_favourites_count'.
		do
			favourites_count := a_favourites_count
		ensure
			favourites_count_assigned: favourites_count = a_favourites_count
		end

	set_entities (an_entities: like entities)
			-- Assign `entities' with `an_entities'.
		do
			entities := an_entities
		ensure
			entities_assigned: entities = an_entities
		end

	set_default_profile_image (a_default_profile_image: like default_profile_image)
			-- Assign `default_profile_image' with `a_default_profile_image'.
		do
			default_profile_image := a_default_profile_image
		ensure
			default_profile_image_assigned: default_profile_image = a_default_profile_image
		end

	set_default_profile (a_default_profile: like default_profile)
			-- Assign `default_profile' with `a_default_profile'.
		do
			default_profile := a_default_profile
		ensure
			default_profile_assigned: default_profile = a_default_profile
		end

	set_contributors_enabled (a_contributors_enabled: like contributors_enabled)
			-- Assign `contributors_enabled' with `a_contributors_enabled'.
		do
			contributors_enabled := a_contributors_enabled
		ensure
			contributors_enabled_assigned: contributors_enabled = a_contributors_enabled
		end


invariant
	valid_description: attached description as d implies d.count <= 160

note
	copyright: "Copyright (c) 2003-2009, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
