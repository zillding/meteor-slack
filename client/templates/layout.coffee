Template.layout.events
	'click .sidebar-trigger': ->
		Template.instance().$('.ui.sidebar').sidebar 'toggle'

Template.layout.onCreated ->
	# hide sidebar when window resizes
	$(window).on 'resize', =>
		@$('.ui.sidebar').sidebar 'hide' if @$('.ui.sidebar').sidebar 'is visible'

	Meteor.users.find
		'status.online': true
	.observe
		added: (user) ->
			_addNotification
				type: 'default'
				header: "#{user.username}"
				message: 'is online!'
		removed: (user) ->
			_addNotification
				type: 'default'
				header: "#{user.username}"
				message: 'is offline...'

Template.layout.onRendered ->
	@$('.ui.sidebar').sidebar 'setting', 'transition', 'overlay'
	# put the following class configuration here because meteor does not allow
	# duplicate class names
	@$('.sidebar-container').attr 'class', 'three wide computer four wide tablet only column flex-container flex-column-container'
	@$('.main-container').attr 'class', 'thirteen wide computer twelve wide tablet sixteen wide mobile column flex-container flex-column-container'

Template.layout.onDestroyed ->
	$(window).off 'resize'
