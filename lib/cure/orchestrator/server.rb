# frozen_string_literal: true

require "json"
require "sinatra/base"
require "sinatra/namespace"
require 'sinatra/cross_origin'

require "cure/orchestrator/routes"

module Cure
  module Orchestrator
    class Server < Sinatra::Base
      register Sinatra::Namespace

      configure do
        enable :cross_origin
      end

      before do
        content_type :json
        response.headers['Access-Control-Allow-Origin'] = '*'
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

      options "*" do
        response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
        response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
        response.headers["Access-Control-Allow-Origin"] = "*"
      end
    end
  end
end
