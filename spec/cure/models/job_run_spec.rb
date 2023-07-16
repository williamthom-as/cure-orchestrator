# frozen_string_literal: true

RSpec.describe Cure::Orchestrator::Models::JobRun do

  before :all do
    @job = Cure::Orchestrator::Models::Job.create(
      name: "TestJob",
      template_file: "/some/dir",
      input_file: "/some/other/dir",
      status: "pending"
    )
  end

  it "should create and save a valid job run with job association" do
    job_run = described_class.create(
      job: @job,
      status: "pending"
    )

    expect(job_run.id).to_not eq(nil)
    expect(job_run.created_at).to_not eq(nil)
    expect(job_run.job.name).to eq("TestJob")
  end
end
