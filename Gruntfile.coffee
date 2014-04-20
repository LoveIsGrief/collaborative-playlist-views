module.exports = (grunt) ->

	coffeeFiles = ["*.coffee"]
	buildDir = "build/"

	# Project configuration.
	grunt.initConfig
		pkg: grunt.file.readJSON("package.json")

		clean:
			build:
				files:
					src: buildDir
		sass:
			compile:
				files:[
					expand: true
					cwd: "src/stylesheets"
					src: ["*.sass", "*.scss"]
					dest: buildDir
					ext: ".css"
				]

		coffee:
			compile:
				options:
					bare:true
				files:[
					{
						expand: true
						cwd: "src"
						src: coffeeFiles
						dest: buildDir
						ext: ".js"
					}
					# {
					# 	expand: true
					# 	cwd: "extras"
					# 	src: ["**/*.coffee"]
					# 	dest: "extras"
					# 	ext: ".js"
					# }
				]
		coffeelint:
			lint:
				options:
					max_line_length:
						level: "ignore"
					no_tabs:
						level: "ignore"
					indentation:
						level: "ignore"
					missing_fat_arrows:
						level: "warn"
				files:[
					expand: true
					cwd: "src"
					src: coffeeFiles
				]

		copy:
			templates:
				files:[
					expand: true
					cwd: "src/templates"
					src: "*.html"
					dest: buildDir
				]
			images:
				src: "images/**"
				dest: buildDir

		watch:
			scripts:
				files: [ "src/*.coffee", "specs/*.coffee" ]
				tasks: [ "coffeelint", "coffee", "jasmine_node" ]
				# options:
				# 	livereload: true
			# stylesheets:
			# 	files: [ "**/*.sass" ]
			# 	tasks: [ "sass" ]
			# 	# options:
			# 	# 	livereload: true
			# templates:
			# 	files: [ "src/**/*.html" ]
			# 	tasks: [ "copy:templates" ]
			# images:
			# 	files: ["images/*", "images/**/*"]
			# 	tasks: ["copy:images"]
			# livereload:
			# 	files: [ buildDir+"**/*", buildDir+"*" ]
			# 	options:
			# 		livereload: true

		jasmine_node:
			options:
				extensions: "coffee"
			all: [ "specs/"]

	# Load the plugin that provides the "uglify" task.
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-contrib-sass"
	grunt.loadNpmTasks "grunt-contrib-clean"
	grunt.loadNpmTasks "grunt-contrib-copy"
	grunt.loadNpmTasks "grunt-jasmine-node"
	grunt.loadNpmTasks "grunt-coffeelint"

	# Default task(s).
	grunt.registerTask "default", [ "coffee", "jasmine_node"]
	# grunt.registerTask "default", [ "clean", "build", "test", "phantomjs"]
	# grunt.registerTask "build", ["coffee", "sass", "copy"]
	# grunt.registerTask "test", ["coffeelint"]
