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
      puts "v#{DndSchedule::VERSION} D&D Schedule 🐲"
    end
    map %w(--version -v) => :version

    desc 'display [OPTIONS]', 'Display D&D Schedule'
    long_desc <<-DESC
      Display D&D Schedule(s). Based on information stored in 'config.yml' this
      command displays the various D&D games and their scheduled dates.

      The default behavior is to display the games scheduled in the next 2
      weeks; the --upcoming flag.

      You can also specify specific games, or specific months with which to
      display schedules.

      The --all command overrides all passed in options.
    DESC
    method_option :all, aliases: '-a',
      type: :boolean, default: false,
      desc: 'Display schedule for all games'
    method_option :upcoming, aliases: '-u',
      type: :boolean, default: true,
      desc: 'Display schedule for games in the next 2 weeks'
    method_option :list, aliases: '-l',
      type: :boolean, default: false,
      desc: 'Display a list of configured games'
    method_option :game, aliases: '-g',
      type: :string,
      desc: 'Display schedule for specified game'
    method_option :exclude, aliases: '-e',
      type: :string, banner: 'GAME',
      desc: 'Exclude schedule for specified game'
    method_option :month, aliases: '-m',
      type: :numeric,
      desc: 'Display schedule for specified month'
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
