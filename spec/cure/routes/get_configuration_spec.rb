require "spec_helper"

RSpec.describe Cure::Orchestrator::Routes::GetConfiguration do
  let(:config_service) { double("config_service") }
  let(:request) { double("request") }
  let(:params) { double("params") }

  before do
    allow(config_service).to receive(:config_file).and_return({a: "b", c: "d"})
    allow(request).to receive(:env).and_return({"sinatra.route" => "/api/v1/templates"})
  end

  it "should return config" do
    controller = described_class.new(request, params, config_service: config_service)
    expect(controller.call).to eq(
      {
        content: {
          config_file: {a: "b", c: "d"},
          message: "Configuration is valid."
        },
        route: "/api/v1/templates",
        success: true
      }
    )
  end
end
