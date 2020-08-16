# frozen_string_literal: true

require_relative '../command'

module DndSchedule
  module Commands
    class Display < DndSchedule::Command
      attr_reader :options
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        # Command logic goes here ...
        output.puts "OK"

        if options[:all]
          output.puts "DISPLAY ALL"
        end

      end
    end
  end
end
