# frozen_string_literal: true

require "sequel"
require "json"
require "sinatra/base"
require "sinatra/namespace"
require "sinatra/cross_origin"

require "cure/orchestrator/helpers"
require "cure/orchestrator/routes/init"
require "cure/orchestrator/services/init"


module Cure
  module Orchestrator

    class Server < Sinatra::Base
      register Sinatra::Namespace

      configure do
        enable :cross_origin

        set :app_config, Services::ConfigurationService.new.config_file || {}
        set :database, Helpers.init_database(settings.app_config)

        # Must be loaded after all DB ops done.
        require "cure/orchestrator/models/init"
        require "cure/processor/server"

        Thread.new do
          Cure::Processor::Server.new.start
        end
      end

      before do
        content_type :json
        response.headers["Access-Control-Allow-Methods"] = "OPTIONS, GET, PUT, POST, DELETE"
        response.headers["Access-Control-Allow-Headers"] =
          "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
        response.headers["Access-Control-Allow-Origin"] = "*"
      end

      # Home
      get "/" do
        {success: true, content: "Cure Orchestrator Service API"}.to_json
      end

      namespace "/api/v1/config" do
        # Get configuration file
        get "" do
          Cure::Orchestrator::Routes::GetConfiguration.new(request, params).call.to_json
        end

        # Update configuration file
        put "" do
          Cure::Orchestrator::Routes::PutConfiguration.new(request, params).call.to_json
        end

        # Check Cure configuration is working
        get "/validate" do
          Cure::Orchestrator::Routes::GetConfigurationValidation.new(request, params).call.to_json
        end
      end

      namespace "/api/v1/templates" do
        # Get templates
        get "" do
          Cure::Orchestrator::Routes::GetTemplates.new(request, params).call.to_json
        end

        # Get template file
        get "/:name" do
          Cure::Orchestrator::Routes::GetTemplate.new(request, params).call.to_json
        end
      end

      namespace "/api/v1/jobs" do

        get "" do
          Cure::Orchestrator::Routes::GetJobs.new(request, params).call.to_json
        end

        get "/:id" do
          Cure::Orchestrator::Routes::GetJob.new(request, params).call.to_json
        end

        post "" do
          Cure::Orchestrator::Routes::PostJob.new(request, params).call.to_json
        end
      end

      options "*" do
        response.headers["Access-Control-Allow-Methods"] = "OPTIONS, GET, PUT, POST, DELETE"
        response.headers["Access-Control-Allow-Headers"] =
          "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
        response.headers["Access-Control-Allow-Origin"] = "*"
        halt 200
      end
    end

  end
end
