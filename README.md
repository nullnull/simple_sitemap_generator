# SimpleSitemapGenerator

SimpleSitemapGenerator is a gem for Ruby on Rails to generate sitemap.xml.

## Features

* Generates `sitemap.xml` **dynamically** by using `config/routes.rb`.
* Enable to respond **without static file** (eg. `public/sitemap.xml`).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_sitemap_generator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_sitemap_generator

## Usage
All you have to do is following.

##### config/routes.rb
```ruby
get '/sitemap.xml', action: :sitemap, controller: :sitemap
```

##### app/controllers/sitemap_controller.rb
```ruby
class SitemapController < BaseController
  def sitemap
    send_data(SimpleSitemapGenerator::Sitemap.generate_xml, type: 'text/xml')
  end
end
```

##### config/initializers/sitemap.rb
```ruby
# Set the host name for URL creation
SimpleSitemapGenerator::Sitemap.host = 'https://www.example.com'

# [optional] Set default parameter
SimpleSitemapGenerator::Sitemap.default_lastmod = Time.current
SimpleSitemapGenerator::Sitemap.default_priority = 0.5
SimpleSitemapGenerator::Sitemap.default_changefreq = 'daily'

# [optional] Set inappropriate paths for sitemap.xml by regular expression
SimpleSitemapGenerator::Sitemap.inappropriate_paths += [
  /^\/admin/,
  /^\/mypage/,
]

# [optional] Set parameter to specific path if you want
SimpleSitemapGenerator::Sitemap.options = {
  '/': {
    priority: 1.0,
    changefreq: 'daily',
  },
}
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nullnull/simple_sitemap_generator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SimpleSitemapGenerator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/simple_sitemap_generator/blob/master/CODE_OF_CONDUCT.md).
