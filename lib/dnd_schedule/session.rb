require 'ostruct'

module DndSchedule
  class Session < OpenStruct

    def <=> other
      return name <=> other.name if (date <=> other.date).zero?
      date <=> other.date
    end
  end
end
