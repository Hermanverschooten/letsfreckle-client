module Letsfreckle
  module Client
    class NoEntry;end
    class Entry
      attr_reader :invoice, :updated_at, :created_at, :invoiced_at,
        :id, :invoiced, :billable, :tags
      attr_accessor :user_id, :minutes, :description, :project_id,
        :source_url

      def load(hash)
        if user = hash.delete('user')
          @user_id = user['id']
        end
        if project = hash.delete('project')
          @project_id = project['id']
        end
        hash.each do |k,v|
          instance_variable_set("@#{k}".to_sym, v)
        end
      end

      def self.find(id)
        response = Letsfreckle::Client.read("/entries/#{id}")
        if response.success?
          p = Entry.new
          p.load response
          return p
        else
          NoEntry.new
        end
      end

      def self.find_by(options)
        response = Letsfreckle::Client.read("/entries", options)
        if response.success?
          entries = []
          response.each do |resp|
            e = Entry.new
            e.load resp
            entries << e
          end
          return entries
        else
          []
        end
      end

      def project
        @project ||= Project.find(project_id)
      end

      def mark_as_invoiced
        response = Letsfreckle::Client::update("/entries/#{id}/invoiced_outside_of_freckle", date: Date.today.strftime)
        return response.success?
      end

      def save
        response = Letsfreckle::Client::write("/entries", self.to_params)
        if response.success?
          self.load(response)
          return true
        end
        false
      end

      def to_params
        params_hash = {
          user_id: user_id,
          date: Date.today.strftime,
          minutes: minutes,
          description: description,
          project_id: project_id,
        }

        params_hash.merge(source_url: source_url) if source_url
        params_hash
      end
    end
  end
end
