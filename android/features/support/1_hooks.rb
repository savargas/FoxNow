$LOAD_PATH.unshift *Dir.glob(File.expand_path('features'))

require 'testmunk/calabash/android/application'
require_relative 'app.rb'

Before do
  @app = Testmunk::Android::Application.new(self)
end

