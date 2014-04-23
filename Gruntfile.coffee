module.exports = (grunt) ->

	coffeeFiles = ["*.coffee", "**/*.coffee"]
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
					cwd: "src/"
					src: ["**/*.sass", "**/*.scss"]
					dest: buildDir
					ext: ".css"
				]

		bowerInstall:
			build:
				src:[ "#{buildDir}**/*.html"]
				dependencies: true

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
			html:
				files:[
					expand: true
					cwd: "src"
					src: "**/*.html"
					dest: buildDir
				]
			css:
				files:[
					expand: true
					cwd: "src"
					src: "**/*.css"
					dest: buildDir
				]
			images:
				src: "images/**"
				dest: buildDir+"site"

		watch:
			scripts:
				files: coffeeFiles
				tasks: [ "coffeelint", "coffee", "jasmine_node" ]
				# options:
				# 	livereload: true
			bower:
				files: [ "bower.json" ]
				tasks: [ "bowerInstall"]
			stylesheets:
				files: [ "**/*.sass", "src/**/*.css" ]
				tasks: [ "sass", "copy:css" ]
				# options:
				# 	livereload: true
			html:
				files: [ "src/**/*.html" ]
				tasks: [ "copy:html", "bowerInstall" ]
			images:
				files: ["images/*", "images/**/*"]
				tasks: ["copy:images"]
			livereload:
				files: [ buildDir+"**/*", buildDir+"*" ]
				options:
					livereload: true

		jasmine_node:
			options:
				extensions: "coffee"
			all: [ "specs/"]

	# Load the plugin that provides the "uglify" task.
	grunt.loadNpmTasks "grunt-bower-install-simple"
	grunt.loadNpmTasks "grunt-bower-install"
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-contrib-sass"
	grunt.loadNpmTasks "grunt-contrib-clean"
	grunt.loadNpmTasks "grunt-contrib-copy"
	grunt.loadNpmTasks "grunt-jasmine-node"
	grunt.loadNpmTasks "grunt-coffeelint"

	# Default task(s).
	grunt.registerTask "default", [ "clean", "build", "test"]
	grunt.registerTask "bower", [ "bower-install-simple", "bowerInstall"]
	grunt.registerTask "build", ["coffee", "sass", "copy", "bower"]
	grunt.registerTask "test", [ "coffeelint", "jasmine_node"]
