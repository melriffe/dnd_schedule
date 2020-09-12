require 'date'

module DndSchedule
  class Schedule

    def initialize options
      self.frequency = options['frequency']
      self.starting = options.fetch('starting') { Date.today.to_s }
      self.occurrences = options.fetch('occurrences') { 1 }
      initialize_scheduler
    end

    def sessions
      sessions = []
      occurrences.times do
        sessions << DndSchedule::Session.new(date: scheduler.next)
      end
      sessions
    end

    private

    attr_accessor :name, :occurrences, :frequency, :starting, :scheduler

    def initialize_scheduler
      self.scheduler = DndSchedule::Scheduler.new frequency, starting
    end

  end

  ##
  # Responsible for computing the 'next' date based on the specified
  # frequency and starting date.
  #
  class Scheduler
    attr_accessor :frequency, :starting

    def initialize frequency, starting
      self.frequency = frequency
      self.starting = Date.parse starting

      self.monthly = false
      self.weekly = false
      parse_frequency
    end

    def next
      calculate_next_date.to_s
    end

    private

    attr_accessor :day_of_week, :first_occurrence, :how_often, :monthly, :next_occurrence, :ordinal, :weekly

    ##
    # Expected phrases:
    #  * <ordinal> <day_of_week>
    #  * Every <count> weeks
    #
    # For example:
    #   4th Saturday
    #   Every 3 weeks
    #
    # TODO: Add frequency string validation: ordinal number, day of week,
    # frequency scope (days, weeks, months, etc).
    #
    def parse_frequency
      frequency_parts = frequency.split(' ')
      if frequency_parts.size == 2
        self.monthly = true
        self.ordinal = frequency_parts[0]
        self.day_of_week = frequency_parts[1]
      elsif frequency_parts.size == 3
        self.weekly = true
        self.how_often = frequency_parts[1]
      else
        raise DndSchedule::Error, "Frequency Parse Error: '#{frequency}' unknown format."
      end
    end

    def calculate_next_date
      if monthly

        if next_occurrence.nil?
          calculate_next_monthly_date starting
        else
          calculate_next_monthly_date next_occurrence.next_month
        end

      elsif weekly

        if next_occurrence.nil?
          if starting < Date.today
            self.next_occurrence = starting + (7 * how_often.to_i)
          else
            self.next_occurrence = starting
          end
        else
          self.next_occurrence = next_occurrence + (7 * how_often.to_i)
        end

      else
        raise DndSchedule::Error, "ERROR Calculating Next Date!"
      end

      next_occurrence
    end

    def target_wday
      @target_wday ||= Date::DAYNAMES.index day_of_week
    end

    def first_of_the_month date
      Date.parse "#{date.year}-#{date.month}-1"
    end

    def calculate_first_occurrence date
      start_here = first_of_the_month date
      until start_here.wday == target_wday
        start_here = start_here.next_day
      end

      start_here = start_here + (7 * (ordinal.to_i - 1))
    end

    def calculate_next_monthly_date date
      self.first_occurrence = calculate_first_occurrence date
      if first_occurrence < starting
        calculate_next_monthly_date starting.next_month
      else
        self.next_occurrence = first_occurrence
      end
    end

  end
end
