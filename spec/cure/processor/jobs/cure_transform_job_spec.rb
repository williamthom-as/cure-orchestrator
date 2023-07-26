# frozen_string_literal: true

require "cure/processor/server"
require "cure/orchestrator/models/job"

RSpec.describe Cure::Processor::CureTransformJob do

  before do
    @job = Cure::Orchestrator::Models::Job.create(
      name: "SimpleJob",
      job_type: "CureTransformJob",
      job_args: '''
        {
          "input_file":"spec/cure/processor/jobs/test_files/test_csv.csv",
          "template_file":"spec/cure/processor/jobs/test_files/test_csv_template.rb"
        }
      ''',
      status: "pending"
    )
  end

  it "should process jobs" do
    handler = described_class.new
    handler.perform(@job)
    expect(@job.status).to eq("complete")
    expect(@job.error_count).to eq(0)
    expect(@job.job_runs.size).to eq(1)

    job_run = @job.job_runs.first
    expect(job_run.status).to eq("complete")
    expect(job_run.error_message).to eq(nil)
  end
end
