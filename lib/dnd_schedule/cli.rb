# frozen_string_literal: true

require 'thor'

module DndSchedule
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    class_option :debug, type: :boolean, default: false, desc: 'Run in debug mode'

    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'D&D Schedule version'
    def version
      require_relative 'version'
      puts "v#{DndSchedule::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'display [OPTIONS]', 'Display D&D Schedule'
    long_desc <<-DESC
      Display D&D Schedule(s). The default behavior is to display all defined
      game session schedules.

    DESC
    method_option :all, aliases: '-a',
      type: :boolean, default: true,
      desc: 'Display all configured schedules'
    method_option :help, aliases: '-h',
      type: :boolean,
      desc: 'Display usage information'
    def display(*)
      if options[:help]
        invoke :help, ['display']
      else
        require_relative 'commands/display'
        DndSchedule::Commands::Display.new(options).execute
      end
    end
  end
end
