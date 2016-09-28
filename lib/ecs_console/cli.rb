require 'thor'
require 'ecs_console'

module EcsConsole
  class CLI < Thor
    desc 'version', 'Print out the version string'
    def version
      require 'ecs_console/version'
      say EcsConsole::VERSION.to_s
    end
  end
end
