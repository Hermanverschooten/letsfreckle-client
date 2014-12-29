# Letsfreckle::Client

I needed a way to easiliy access the new V2 api of Letsfreckle.com.
There are some projects that cover v1 partly.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'letsfreckle-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install letsfreckle-client

## Usage

Before using any of the API functions you need to set up the configuration

```ruby
Letsfreckle::Client.configure do
  token 'your v2 api token from letsfreckle'
  name 'this will be sent as the user-agent'
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/letsfreckle-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
