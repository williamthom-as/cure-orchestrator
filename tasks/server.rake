require "cure/orchestrator"

desc "Start Cure Orchestration"
task :start do
  Cure::Orchestrator.start
end
