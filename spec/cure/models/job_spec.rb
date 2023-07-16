# frozen_string_literal: true

RSpec.describe Cure::Orchestrator::Models::Job do
  it "should create and save a valid job" do
    job = described_class.new(
      name: "TestJob",
      template_file: "/some/dir",
      input_file: "/some/other/dir",
      status: "pending"
    )

    job.save

    expect(job.id).to_not eq(nil)
  end
end

