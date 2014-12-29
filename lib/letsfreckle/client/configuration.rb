module Letsfreckle
  module Client
    class Configuration
      attr_accessor :token
      attr_accessor :name

      def valid?
        name_present? && token_present?
      end

      def token(*args)
        if args.any?
          @token = args.first
        else
          @token
        end
      end

      def name(*args)
        if args.any?
          @name = args.first
        else
          @name
        end
      end

      private

      def name_present?
        !(name.nil? || name.empty?)
      end
      def token_present?
        !(token.nil? || token.empty?)
      end
    end
  end
end
