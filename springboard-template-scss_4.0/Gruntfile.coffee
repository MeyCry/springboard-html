###* Обязательная обёртка ###
module.exports = (grunt) ->
  ###* Задачи ###
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
  # css
    compass:
    # Компиляция scss в CSS
      dist:
        options:
          config: 'config.rb'
          sassDir: 'css'
          cssDir: 'css'
          environment: 'production'

      dev:
        options:
          config: 'config.rb'
          sassDir: 'css'
          cssDir: 'css'

    autoprefixer:
      prefixMe:
        options:
          browsers: ["last 6 version", "> 1%", "ie 8"]

        files:
          'css/style-a.css': ['css/style.css']

    csso:
      compress:
        options:
          report: "min"
        files:
          "css/style.min.css": ["css/style-a.css"]

  # js
    concat:
    # склеиваем все js
      js:
        src: [
          "js/source/lib/jquery-1.10.2.min.js"
          "js/source/lib/jquery.placeholder.min.js"

          "js/source/functions.js"
        ]
        dest: "js/project.js"

    uglify:
    # Минификация
      options:
        mangle: yes,
        compress: no

      js:
        files:
          'js/project.min.js': ['<%= concat.js.dest %>']

    svgmin:
      options:
        plugins: [{
          removeViewBox: no
        }]
      dist:
        files: [{
          expand: yes
          cwd: 'images/svg/svg-no-optimized'
          src: ['**/*.svg']
          dest: 'images/svg/'
          ext: '.min.svg'
        }]

    watch:
      compass:
        files: ['css/**/*.scss'],
        tasks: ['compass', 'autoprefixer', 'csso:compress']
      js:
        files: ['js/source/**/*.js']
        tasks: ['newer:concat:js', 'uglify:js']

  # Загрузка модуля
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-compass')
  grunt.loadNpmTasks("grunt-csso")
  grunt.loadNpmTasks('grunt-autoprefixer')
  grunt.loadNpmTasks('grunt-svgmin')
  grunt.loadNpmTasks('grunt-newer')

  # Объявление тасков
  grunt.registerTask('default', ['compass', 'autoprefixer', 'csso:compress', 'concat:js', 'uglify:js', 'watch'])
  grunt.registerTask('start', ['compass', 'autoprefixer', 'csso:compress', 'concat:js', 'uglify:js'])
  grunt.registerTask('css', ['compass', 'autoprefixer', 'csso:compress', 'watch:compass'])
  grunt.registerTask('js', ['concat:js', 'uglify:js', 'watch:js'])
  grunt.registerTask('svg', ['svgmin'])