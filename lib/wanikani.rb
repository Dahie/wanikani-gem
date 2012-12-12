require 'rest_client'
require 'multi_json'

require 'wanikani/user'
require 'wanikani/study_queue'
require 'wanikani/level'
require 'wanikani/srs'
require 'wanikani/recent_unlocks'

module Wanikani
  API_ENDPOINT = "http://www.wanikani.com/api/user"

  def self.api_key=(api_key)
    @@api_key = api_key
  end

  def self.api_key
    @@api_key
  end

  def self.api_response(resource, optional_arg = nil)
    raise ArgumentError, "You must define a resource to query Wanikani" if resource.nil? || resource.empty?

    begin
      response = RestClient.get("#{Wanikani::API_ENDPOINT}/#{Wanikani.api_key}/#{resource}/#{optional_arg}")
      parsed_response = MultiJson.load(response)
      
      if parsed_response.has_key?("error")
        self.raise_exception(parsed_response["error"]["message"])
      else
        return parsed_response
      end
    rescue => error
      self.raise_exception(error.message)
    end
  end

  private

  def self.raise_exception(message)
    raise Exception, "There was an error fetching the data from Wanikani (#{message})"
  end
end
