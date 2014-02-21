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

    less:
      dev:
        files:
          "css/app.css": "less/app.less"
      prod:
        options:
          compress: true
          cleancss: true
        files:
          "css/app.min.css": "less/app.less"

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
          appCss: 'css/app.css'
          libScripts: scripts.lib.dev
          appScript: "app.js"
        output: 'index.html'

      production:
        template: 'hbs/index.html.hbs'
        templateData:
          production: true
          appCss: 'css/app.min.css'
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
  grunt.loadNpmTasks('grunt-contrib-less')

  # Default task(s).
  grunt.registerTask('default', ['coffee'])
  grunt.registerTask('server', ['exec:server'])
  grunt.registerTask('dev', [
    'coffee',
    'less:dev',
    'emberTemplates',
    'concat:app',
    'compile-handlebars:dev'
  ])
  grunt.registerTask('prod', [
    'coffee',
    'less:prod',
    'emberTemplates'
    'concat:app',
    'uglify',
    'compile-handlebars:production'
  ])

