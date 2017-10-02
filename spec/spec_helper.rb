require 'simple_sitemap_generator'
require 'active_support'
require 'active_support/core_ext'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  class DispatcherMock
    attr_reader :app
  end

  class PathMock
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def spec
      path
    end
  end

  class RouteMock
    attr_reader :verb, :path, :app

    def initialize(verb, path)
      @verb = verb
      @path = PathMock.new(path)
      @app = DispatcherMock.new
    end
  end

  class RouteSetMock
    def routes
      [{
        verb: 'GET',
        path: '/'
      }].map { |x| RouteMock.new(x[:verb], x[:path]) }
    end
  end

  class RailsApplicationMock
    def routes
      RouteSetMock.new
    end
  end

  module Rails
    def self.application
      RailsApplicationMock.new
    end
  end
end
