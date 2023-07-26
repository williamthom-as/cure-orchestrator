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
  end
end
