# frozen_string_literal: true

require "json"
require "sinatra/base"
require "sinatra/namespace"

require "cure/orchestrator/routes"

module Cure
  module Orchestrator
    class Server < Sinatra::Base
      register Sinatra::Namespace

      before do
        content_type :json
      end

      # Home
      get "/" do
        {success: true, content: "Cure Orchestrator Service API"}.to_json
      end

      namespace "/api/v1" do
        get "/config" do
          Cure::Orchestrator::Routes::GetConfiguration.new(request).call.to_json
        end
      end
    end
  end
end
