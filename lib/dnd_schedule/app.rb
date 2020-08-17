require 'tty-config'

module DndSchedule
  class App
    attr_reader :config

    def self.config
      new.config
    end

    def initialize
      @config = TTY::Config.new
      @config.filename = 'config'
      @config.append_path Dir.pwd
      @config.append_path Dir.home
    end
  end
end
