# frozen_string_literal: true

Dir[File.join(File.dirname(__FILE__), "**/*.rb")].each do |file_path|
  require file_path
end
