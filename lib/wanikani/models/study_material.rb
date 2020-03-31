# -*- encoding : utf-8 -*-
module Wanikani
  module StudyMaterial
    class << self
      def find_by(parameters = {})
        # hidden
        # ids
        # subject_ids
        # subject_types
        # updated_after
        # page_after_id
        # page_before_id

        respond(client.get('study_materials', parameters))
      end

      def find(id)
        respond(client.get("study_materials/#{id}"))
      end

      private

      def respond(json)
        Response.new(json)
      end

      def client
        @client ||= ::Wanikani::ApiV2::Client.new(::Wanikani.config.to_hash)
      end
    end
  end
end