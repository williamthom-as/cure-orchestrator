# frozen_string_literal: true

RSpec.describe Cure::Orchestrator::Routes::GetConfigurationValidation do
  let(:config_service) { Cure::Orchestrator::Services::ConfigurationService.new }
  let(:request) { double("request") }
  let(:params) { double("params") }

  before do
    allow(config_service).to receive(:config_file).and_return(
      {input_directory: "a", template_directory: "b", database_file_location: "c"}
    )
    allow(request).to receive(:env).and_return({"sinatra.route" => "/api/v1/templates"})
  end

  it "should return true for valid config" do
    controller = described_class.new(request, params, config_service: config_service)
    result = controller.call
    expect(result.dig(:content, :message)).to eq("Configuration validation complete.")
  end
end
