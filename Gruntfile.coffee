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
    # init 
    "initialize.js"

    # model
    "model/machine.js"
    "model/line.js"
    "model/contact.js"

    # mixin
    "mixin/verifyForm.js"

    # view
    "view/verifyInput.js"

    # controller
    "controller/application.js"
    "controller/index.js"
    "controller/lines.js"
    "controller/machine.js"
    "controller/contact.js"
    # Concat navigation to the last controller
    # b/c we setup our router here
    "controller/navigation.js"
    # Concat ember handlebars last
    "hbs/emberHbs.js"
  ]

  karma: {
    unit: [
      # 'lodash/dist/lodash.js'
      'lib/jquery/jquery.js'
      # 'moment/moment.js'
      'lib/bootstrap/dist/js/bootstrap.js'
      'lib/handlebars/handlebars.js'
      'lib/ember/ember.js'
      # 'ember-data/ember-data.js'
      'js/app.js'
      'test/unit/*.js'
    ]
    integration: [
      # 'lodash/dist/lodash.js'
      'lib/jquery/jquery.js'
      # 'moment/moment.js'
      'lib/bootstrap/dist/js/bootstrap.js'
      'lib/handlebars/handlebars.js'
      'lib/ember/ember.js'
      # 'ember-data/ember-data.js'
      'js/app.js'
      'test/integration/*.js'
    ]
  }
}

# web spider variables
keywords = "Facial tissue making machine, Paper napkin making machine, Single fold hand towel machine, Multifold hand towel machine, C-fold paper hand towel machine, Facial tissue log saw, Facial tissue interfolder Napkin folder, Luncheon napkin folder Beverage napkin folder, "

description = "Ocean Associate is a leading Paper napkin making machine and Facial tissue making machine manufacturer specialized in Facial tissue making machine, Single fold hand towel machine, Multifold hand towel machine, Paper napkin making machine, Facial tissue log saw, C-fold paper hand towel machine, Napkin folder, Facial tissue interfolder, Beverage napkin folder, and Luncheon napkin folder."

module.exports = (grunt)->

  # Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    less:
      dev:
        options: {
          sourceMap: true
          sourceMapFilename: 'less/less.map'
          sourceMapURL: '../less/less.map'
          sourceMapRootpath: '../'
        }
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
          src: ['src/**/*.coffee', 'server/**/*.coffee', 'test/**/*.coffee']
          ext: '.js'
        ]

    'compile-handlebars':
      dev:
        template: 'src/hbs/index.html.hbs'
        templateData:
          production: false
          appCss: 'css/app.css'
          libScripts: scripts.lib.dev
          appScript: "app.js"
          keywords: keywords
          description: description
        output: 'index.html'

      production:
        template: 'src/hbs/index.html.hbs'
        templateData:
          production: true
          appCss: 'css/app.min.css'
          libScripts: scripts.lib.prod
          appScript: "app.min.js"
          keywords: keywords
          description: description
        output: 'index.html'

    "emberTemplates":
      default:
        options:
          templateBasePath: /src\/hbs\//
        files:
          'src/hbs/emberHbs.js': 'src/hbs/**/*.hbs'

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

    karma: {
      options: {
        browsers: ['PhantomJS']
        frameworks: ['mocha', 'chai']
        reporters: ['mocha']
        singleRun: true
      },
      unit: {
        options: {
          files: scripts.karma.unit
        }
      },
      integration: {
        options: {
          files: scripts.karma.integration
        }
      }
    }

    watch: {
      options: {
        livereload: true
      }
      src: {
        files: ['src/**/*.coffee']
        tasks: ['coffee', 'concat:app']
      }
      less: {
        files: ['less/*.less']
        tasks: ['less:dev']
      }
      hbs: {
        files: ['src/hbs/*.hbs']
        tasks: ['emberTemplates', 'concat:app', 'compile-handlebars:dev']
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
  grunt.loadNpmTasks('grunt-karma')
  grunt.loadNpmTasks('grunt-contrib-watch')

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

  grunt.registerTask('test', ['dev', 'karma'])

