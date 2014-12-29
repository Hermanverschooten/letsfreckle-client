require "letsfreckle/client/version"
require "letsfreckle/client/configuration"
require "letsfreckle/client/project"
require "letsfreckle/client/entry"
require "httparty"

module Letsfreckle
  module Client
    extend self
    include HTTParty

    debug_output $stderr

    attr_reader :configuration

    base_uri 'https://api.letsfreckle.com/v2'

    def configure(&block)
      raise 'configuration block required' unless block
      @configuration = Configuration.new
      configuration.instance_eval(&block)
    end

    def read(command, options={})
      response = get(
        command,
        query: options,
        headers: {
          'User-Agent'  => configuration.name,
          'X-FreckleToken'  => configuration.token
        }
      )
    end
    def write(command, body, options={})
      response = post(
        command,
        body: body.to_json,
        query: options,
        headers: {
          'User-Agent'  => configuration.name,
          'X-FreckleToken'  => configuration.token,
          'Content-Type' => 'application/json'
        }
      )
    end
    def update(command, body, options={})
      response = put(
        command,
        body: body.to_json,
        query: options,
        headers: {
          'User-Agent'  => configuration.name,
          'X-FreckleToken'  => configuration.token,
          'Content-Type' => 'application/json'
        }
      )
    end
  end
end
