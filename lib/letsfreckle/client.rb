require "letsfreckle/client/version"
require "letsfreckle/client/configuration"
require 'pry'

module Letsfreckle
  module Client
    extend self
    attr_reader :configuration

    def self.configure(&block)
      raise 'configuration block required' unless block
      @configuration = Configuration.new
      configuration.instance_eval(&block)
    end
  end
end
