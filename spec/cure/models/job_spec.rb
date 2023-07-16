# frozen_string_literal: true

RSpec.describe Cure::Orchestrator::Models::Job do
  it "should create and save a valid job" do
    job = described_class.create(
      name: "TestJob",
      template_file: "/some/dir",
      input_file: "/some/other/dir",
      status: "pending"
    )

    expect(job.id).to_not eq(nil)
    expect(job.created_at).to_not eq(nil)
    expect(job.error_count).to eq(0)
    expect(job.status).to eq("pending")
  end
end

