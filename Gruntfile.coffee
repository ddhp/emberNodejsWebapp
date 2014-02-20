scripts = {
  lib: {
    dev: [
      # 'lodash/dist/lodash.js'
      'jquery/jquery.js'
      # 'moment/moment.js'
      'bootstrap/dist/js/bootstrap.js'
      'handlebars/handlebars.js'
      'ember/ember.js'
      # 'ember-data/ember-data.js'
    ]

    prod: [ # get minified js files
      # 'lodash/dist/lodash.min.js'
      'jquery/jquery.min.js'
      # 'moment/min/moment.min.js'
      'bootstrap/dist/js/bootstrap.min.js'
      'handlebars/handlebars.runtime.min.js'
      'ember/ember.min.js'
      # 'ember-data/ember-data.min.js'
    ]
  }

  app: [
    "emberHbs.js"
    "init.js"
    "application.js"
  ]
}

module.exports = (grunt)->

  # Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    coffee:
      default:
        files: [
          expand: true
          cwd: './'
          src: ['src/**/*.coffee', 'server/**/*.coffee']
          ext: '.js'
        ]

    'compile-handlebars':
      dev:
        template: 'hbs/index.html.hbs'
        templateData:
          production: false
          mainCss: 'css/main.css'
          libScripts: scripts.lib.dev
          appScript: "app.js"
        output: 'index.html'

      production:
        template: 'hbs/index.html.hbs'
        templateData:
          production: true
          mainCss: 'css/main.css'
          libScripts: scripts.lib.prod
          appScript: "app.min.js"
        output: 'index.html'

    "emberTemplates":
      default:
        options:
          templateBasePath: /hbs\//
        files:
          'src/emberHbs.js': 'hbs/**/*.hbs'

    exec:
      server:
        cmd: 'node server/server.js'

    concat:
      app:
        src: scripts.app.map (script)->
          return "src/#{script}"
        dest: 'js/app.js'

    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      },
      build: {
        src: 'js/app.js',
        dest: 'js/app.min.js'
      }
    }
  })

  # Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-exec')
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('grunt-compile-handlebars')
  grunt.loadNpmTasks('grunt-ember-templates')

  # Default task(s).
  grunt.registerTask('default', ['coffee'])
  grunt.registerTask('server', ['exec:server'])
  grunt.registerTask('dev', [
    'coffee',
    'emberTemplates',
    'concat:app',
    'compile-handlebars:dev'
  ])
  grunt.registerTask('prod', [
    'coffee',
    'emberTemplates'
    'concat:app',
    'uglify',
    'compile-handlebars:production'
  ])

