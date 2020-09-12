# frozen_string_literal: true

require 'date'

require 'dnd_schedule'
require 'tty-font'
require 'tty-table'

require_relative '../command'

module DndSchedule
  module Commands
    class Display < DndSchedule::Command
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        output.print cursor.clear_screen
        output.print cursor.move_to

        font = TTY::Font.new(:standard)
        output.puts font.write('D&D Schedule')

        configuration = DndSchedule.configuration
        configuration.validate!

        # TODO: Make this part cleaner. The idea is to grab the active
        # configurations first.
        # TODO: Support --list --all
        #
        game_keys = configuration.games
        game_configs = game_keys.collect { |key| configuration.game key }
        game_keys = (game_configs.collect { |config| config['name'] if config['active' ]}).compact

        if options[:list]

          output.puts
          output.puts game_keys
          output.puts
          output.puts "Configured Games: #{game_keys.size}"

        else

          game_configs = filtered_game_keys(game_keys).collect { |key| configuration.game key }

          upcoming_sessions = []
          game_configs.each do |game_config|
            game = DndSchedule::Game.new game_config
            upcoming_sessions << filtered_game_sessions(game.sessions)
          end

          table = TTY::Table.new table_headers, table_data(upcoming_sessions)
          output.puts table.render(:unicode)
          output.puts
          output.puts "#{upcoming_sessions.length} Games scheduled."
        end

      end

      private

      def filtered_game_keys game_keys
        return game_keys if options[:exclude].nil? && options[:game].nil?
        filtered_keys = game_keys.reject { |key| key == options[:exclude] } unless options[:exclude].nil?
        filtered_keys = game_keys.select { |key| key == options[:game] } unless options[:game].nil?
        filtered_keys
      end

      def filtered_game_sessions game_sessions
        if options[:month]
          unless options[:all]
            game_sessions.select { |session| session.date[5,2].to_i == options[:month] }
          else
            game_sessions
          end
        else
          unless options[:all]
            game_sessions.select { |session| session.date <= upcoming_date }
          else
            game_sessions
          end
        end
      end

      def upcoming_date
        (Date.today + 14).to_s
      end

      def table_headers
        ['Date', 'Game', 'Role']
      end

      def table_data upcoming_sessions
        upcoming_sessions.flatten!.sort!
        data = []
        upcoming_sessions.each do |session|
          data << [session.date, session.name, session.role]
        end
        data
      end

    end
  end
end
