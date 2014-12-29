require "letsfreckle/client/version"
require "letsfreckle/client/configuration"
require "letsfreckle/client/project"
require "httparty"

module Letsfreckle
  module Client
    extend self
    include HTTParty

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
    def write(command, options={})
      response = post(
        command,
        query: options,
        headers: {
          'User-Agent'  => configuration.name,
          'X-FreckleToken'  => configuration.token
        }
      )
    end
  end
end
