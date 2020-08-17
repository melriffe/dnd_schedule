require 'dnd_schedule/commands/display'

RSpec.describe DndSchedule::Commands::Display do
  it "executes `display` command successfully" do
    output = StringIO.new
    options = {}
    command = DndSchedule::Commands::Display.new(options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
