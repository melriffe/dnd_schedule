require 'dnd_schedule'
require 'dnd_schedule/configuration'
require 'dnd_schedule/game'
require 'dnd_schedule/schedule'
require 'dnd_schedule/session'
require 'dnd_schedule/version'

require 'tty-logger'

require 'pry-byebug'
require 'amazing_print'

module DndSchedule
  class Error < StandardError; end

  class << self
    def configuration
      @configuration ||= DndSchedule::Configuration.new
    end

    def logger
      @logger ||= TTY::Logger.new
    end

    def configure
      yield configuration
    end
  end
end
