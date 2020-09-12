require 'dnd_schedule/commands/display'

RSpec.describe DndSchedule::Commands::Display do
  xit "executes `display` command successfully" do
    output = StringIO.new
    options = {}
    command = described_class.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
