# frozen_string_literal: true

require 'tty-config'

module DndSchedule
  class Configuration
    attr_reader :config

    def initialize
      self.config = TTY::Config.new
      config.append_path Dir.pwd  # look in current working directory
      config.append_path Dir.home # look in user home directory
      config.filename = File.basename configuration_filename, '.*'
    end

    def validate!
      load_configuration!
    end

    def games
      config.fetch(:games).keys.sort
    end

    def game key
      merge_with_defaults configured_game key
    end

    private

    attr_accessor :game_defaults
    attr_writer :config

    def configuration_filename
      'config.yml'
    end

    def load_configuration!
      unless config.exist?
        raise DndSchedule::Error, "D&D Schedule configuration file, '#{configuration_filename}' does not exist."
      end

      config.read
      self.game_defaults = config.fetch :defaults, default: {}
    end

    def merge_with_defaults hash
      game_defaults.merge hash
    end

    def configured_game key
      (config.fetch "games.#{key}", default: {}).merge( { 'name' => key } )
    end

  end
end
