# frozen_string_literal: true

require "cure/processor/server"
require "cure/orchestrator/models/job"

RSpec.describe Cure::Processor::Server do

  before do
    Cure::Orchestrator::Models::Job.create(
      name: "SimpleJob",
      job_args: "{}",
      status: "pending"
    )

    Cure::Orchestrator::Models::Job.create(
      name: "SimpleJob2",
      job_args: "{}",
      status: "pending"
    )
  end

  def within_timeout(seconds)
    Timeout.timeout(seconds) do
      yield
    end
  rescue Timeout::Error
    # Ignored
  end

  it "should process jobs" do
    server = described_class.new
    within_timeout(10) do
      expect { server.start }.not_to raise_error
    end

    Cure::Orchestrator::Models::Job.all.each do |job|
      expect(job.status).to eq("complete")
    end
  end
end
