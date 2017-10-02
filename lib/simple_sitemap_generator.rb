module SimpleSitemapGenerator
  VERSION = '0.1.0'.freeze

  class Generator
    attr_accessor :host, :default_lastmod, :default_changefreq, :default_priority, :inappropriate_paths, :options, :additional_paths

    def generate_xml
      paths.map { |path| {
          loc: @host + path,
          lastmod: @options[path.to_sym]&.[](:lastmod) || @default_lastmod,
          changefreq: @options[path.to_sym]&.[](:changefreq) || @default_changefreq,
          priority: @options[path.to_sym]&.[](:priority) || @default_priority,
        }.compact }
        .to_xml(root: 'url', skip_types: true)
        .gsub(default_root_start_tag, root_start_tag)
        .gsub(default_root_end_tag, root_end_tag)
    end

    def initialize
      @default_changefreq = 'daily'
      @default_priority = 0.5
      @inappropriate_paths = [
        /:/,  # ignore paths like 'users/:id', 'pages/:page'
        /sitemap\.xml/,
      ]
      @host = ''
      @options = {}
      @additional_paths = []
    end

    private

    def default_root_start_tag
      "\n<url>\n"
    end

    def default_root_end_tag
      "\n</url>\n"
    end

    def inappropriate_path?(path)
      inappropriate_paths.map { |x| path.match(x).present? }.any?
    end

    def paths
      paths = routes.select{ |route| route.verb == 'GET' }
        .reject{ |route| redirect_path?(route) }
        .map { |route| route.path.spec.to_s.gsub('(.:format)', '') }
        .reject{ |path| inappropriate_path?(path) }
        .uniq
      paths + additional_paths
    end

    def redirect_path?(route)
      route.app.app.class.to_s == 'ActionDispatch::Routing::PathRedirect'
    end

    def routes
      Rails.application.routes.routes
    end

    def root_start_tag
      "\n<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n"
    end

    def root_end_tag
      "\n</urlset>\n"
    end
  end

  Sitemap = Generator.new
end
