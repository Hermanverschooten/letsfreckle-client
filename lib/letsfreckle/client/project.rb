module Letsfreckle
  module Client
    class NoProject;end
    class Project
      attr_reader :expenses_url, :uninvoiced_minutes, :url,
        :expenses, :participants, :updated_at, :entries_url, :entries,
        :created_at, :remaining_minutes, :billable_minutes, :enabled,
        :invoiced_minutes, :minutes, :id, :invoices, :unbillable_minutes,
        :budgeted_minutes, :billing_increment, :group, :color, :billable
      attr_accessor :name

      def load(hash)
        hash.each do |k,v|
          instance_variable_set("@#{k}".to_sym, v)
        end
        self
      end

      def self.find(id)
        response = Letsfreckle::Client.read("/projects/#{id}")
        if response.success?
          p = Project.new
          p.load response
          return p
        else
          NoProject.new
        end
      end

      def self.find_by(options)
        response = Letsfreckle::Client.read("/projects", options)
        if response.success?
          projects = []
          response.each do |proj|
            p = Project.new
            p.load proj
            projects << p
          end
          return projects
        else
          []
        end
      end

      def find_entries(reload = false)
        if reload
          @entries_list = nil
        end
        @entries_list ||= Entry.find_by(project_ids: @id)
      end
    end
  end
end
