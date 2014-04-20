GlobalView = require '../build/GlobalView'
UserView = require '../build/UserView'

describe 'UserView', ->

	beforeEach ->

		items = [
			@pendulum = { artist: "Pendulum", title: "Witchcraft" }
			@rusko = { artist: "Rusko", title: "Everyday (Netsky Remix)" }
			@benny = { artist: "Benny Benassi & Public Enemy", title: "Bring The Noise" }
			@britney = { artist: "Britney Spears", title: "BlaBlaBla" }
			@rage = { artist: "Rage Against The Machine", title: "Killing In The Name Of" }
		]

		@globalView = new GlobalView items

		@users = [
			@viewMichael = @globalView.getViewOf "Michael"
			@viewEmilija = @globalView.getViewOf "Emilija"
			@viewChristina = @globalView.getViewOf "Christina"
			@viewYann = @globalView.getViewOf "Yann"
		]


	it 'should have the same initial view for each user', ->

		# Tedious user to user compare
		for currentView in @users
			for otherView in @users
				continue if currentView == otherView #ignore currentUser

				expect(currentView.getVisibleElements())
				.toEqual otherView.getVisibleElements()

		# Simple use of the common view
		expect(@globalView.getVisibleElements().length)
		.toEqual @globalView.items.length

	it 'should hide some elements for specific users', ->


		@viewChristina.hide [ @pendulum, @britney ]
		@expect(@globalView.findItemWithObject(@pendulum).hiddenFor.get()).toContain @viewChristina.name
		expect(@globalView.findItemWithObject(@britney).hiddenFor.get()).toContain @viewChristina.name
		expect(@viewChristina.getHiddenElements()).toContain @pendulum
		expect(@viewChristina.getHiddenElements()).toContain @britney

		@viewEmilija.hide @britney
		expect(@globalView.findItemWithObject(@britney).hiddenFor.get()).toContain @viewEmilija.name
		expect(@viewEmilija.getHiddenElements()).toContain @britney

		@viewMichael.hide @britney
		expect(@viewMichael.getHiddenElements()).toContain @britney

		@viewYann.hide [@pendulum, @rusko, @benny, @britney]
		expect(@viewYann.getVisibleElements()).toContain @rage

		expect(@globalView.getVisibleElements()).toContain @rage
		expect(@globalView.getHiddenElements()).toContain @britney

	xit 'should show newly added items in all user-views', ->

	xit 'should remove items in all user-views', ->
