# frozen_string_literal: true
require 'date'
require 'tty-table'
require 'pry-byebug'
require_relative '../command'

module DndSchedule
  module Commands
    class Display < DndSchedule::Command
      attr_reader :options
      def initialize(options)
        @options = options
      end

      def execute(input: $stdin, output: $stdout)

        data = rows
        if options[:all]
          output.puts "\e[H\e[2J" # cls

          table = TTY::Table.new headers, data

          output.puts table.render(:unicode)
        end

        output.puts "#{data.length} Games scheduled."

      end

      private

      def headers
        ['Date', 'Game']
      end

      def year_of_games
        @yog ||= Hash.new { |hash, key| hash[key] = [] }
      end

      def rows
        populate_insanity_games
        populate_matsif_games
        populate_gwynzer_games
        populate_kaela_games
        populate_noah_games

        data = []

        year_of_games.sort.collect do |game|
          game_date = game[0]
          game_id = game[1]
          multipe = game_id.length > 1

          if Date.parse( game_date ) >= Date.today && Date.parse( game_date ).year == Date.today.year
            if multipe
              game_id.length.times do |index|
                data << [game_date, game_id[index]]
              end
            else
              data << [game_date, game_id[0]]
            end
          end

        end

        data
      end

      def kaela_game_start_date
        @kstart_date = '2020-09-06'
      end

      def noah_game_start_date
        @nstat_date = '2020-08-22'
      end

      def year_of_games
        @yog ||= Hash.new { |hash, key| hash[key] = [] }
      end

      def start_date
        date = Date.today
        @year = date.year
        return Date.parse "#{date.year}-#{date.month}-1"
      end

      def first_saturday_of_month date
        new_month_date = first_of_month date
        if new_month_date < start_date
          new_month_date = advance_date new_month_date
        end
        until new_month_date.wday == 6
          new_month_date += 1
        end
        new_month_date
      end

      def second_saturday_of_month date
        first_saturday_of_month( date ) + 7
      end

      def third_saturday_of_month date
        second_saturday_of_month( date ) + 7
      end

      def fourth_saturday_of_month date
        third_saturday_of_month( date ) + 7
      end

      def first_of_month date
        Date.parse "#{date.year}-#{date.month}-1"
      end

      def advance_date date
        year = date.year
        month = date.month

        if @year.nil? || @year < year
          @year = year
        end

        if year == date.year && 12 == date.month
          year += 1
          month = 1
        else
          month += 1
        end

        Date.parse "#{year}-#{month}-1"
      end

      # First Saturday of the month
      # 2019-06-08 12:00PM
      def populate_insanity_games

        game_date = first_saturday_of_month start_date
        year_of_games[ game_date.to_s ] << 'Insanity'

        5.times do
          game_date = first_saturday_of_month advance_date game_date
          year_of_games[ game_date.to_s ] << 'Insanity'
        end

      end

      # Third Saturday of the month
      # 2020-02-15 12:00PM
      def populate_matsif_games

        game_date = third_saturday_of_month start_date
        year_of_games[ game_date.to_s ] << 'Matsif'

        5.times do
          game_date = third_saturday_of_month advance_date game_date
          year_of_games[ game_date.to_s ] << 'Matsif'
        end

      end

      # Fourth Saturday of the month
      def populate_gwynzer_games

        game_date = fourth_saturday_of_month start_date
        year_of_games[ game_date.to_s ] << 'Gwynzer'

        5.times do
          game_date = fourth_saturday_of_month advance_date game_date
          year_of_games[ game_date.to_s ] << 'Gwynzer'
        end

      end

      # Every three weeks
      def populate_kaela_games

        game_date = Date.parse kaela_game_start_date
        year_of_games[ game_date.to_s ] << 'Kaela'

        11.times do
          game_date += 21
          year_of_games[ game_date.to_s ] << 'Kaela'
        end

      end

      # Every two weeks
      def populate_noah_games

        game_date = Date.parse noah_game_start_date
        year_of_games[ game_date.to_s ] << 'Noah'

        11.times do
          game_date += 14
          year_of_games[ game_date.to_s ] << 'Noah'
        end

      end

    end
  end
end
