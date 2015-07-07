Router.configure
	layoutTemplate: 'layout'

Router.plugin 'ensureSignedIn',
	only: ['direct', 'profile']


Router.route '/', ->
	if Meteor.userId()
		@redirect '/channel/general'
	else
		@redirect '/signin'

Router.route '/channel/:_channel', ->
	channel = @params._channel
	@render 'messages',
		data:
			type: 'channel'
			target: channel
,
	name: 'channel'

Router.route '/direct/:_username', ->
	username = @params._username
	@render 'messages',
		data:
			type: 'direct'
			target: username
,
	name: 'direct'

Router.route '/profile', ->
	@render 'profile'
,
	name: 'profile'

Router.route '/signin', ->
	@render 'signin'
,
	name: 'signin'
