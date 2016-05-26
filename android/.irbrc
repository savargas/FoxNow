ENV['MAIN_ACTIVITY']='com.fox.now.tv.activity.SplashActivity'
ENV['APP_PATH']='FOXNOW-Android-productionDebug-2.6_debug_2016-03-10.4965.apk'
ENV['TEST_APP_PATH']='test_servers/f0ec76fb9b26c004fc801d6fcebb62ac_0.6.0.apk'

require 'awesome_print'
AwesomePrint.irb!

require 'calabash-android/operations'
extend Calabash::Android::Operations

require 'testmunk/calabash/utils/query'
extend Testmunk::Utils::Query

require 'testmunk/calabash/android/screens/views/views'
extend Testmunk::Android::Views

require_relative 'features/support/app.rb'
require 'testmunk/calabash/android/application'
@app = Testmunk::Android::Application.new(self)
