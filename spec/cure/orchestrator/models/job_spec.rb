# frozen_string_literal: true

require "spec_helper"

RSpec.describe Cure::Orchestrator::Models::Job do
  it "should create and save a valid job" do
    job = described_class.create(
      name: "TestJob",
      job_args: "{}",
      job_type: "Test",
      status: "pending"
    )

    expect(job.id).to_not eq(nil)
    expect(job.created_at).to_not eq(nil)
    expect(job.error_count).to eq(0)
    expect(job.status).to eq("pending")
  end

  it "should get the most recent pending job" do
    described_class.create(
      name: "TestJob",
      job_args: "{}",
      job_type: "Test",
      status: "pending"
    )

    described_class.create(
      name: "TestJob2",
      job_args: "{}",
      job_type: "Test",
      status: "pending"
    )

    job = described_class.next_pending_job
    expect(job.name).to eq("TestJob")
  end
end

