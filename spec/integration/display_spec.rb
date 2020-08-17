RSpec.describe "`dnd_schedule display` command", type: :cli do
  it "executes `dnd_schedule help display` command successfully" do
    output = `dnd_schedule help display`
    expected_output = <<-OUT
Usage:
  dnd_schedule display

Options:
  -h, [--help], [--no-help]  # Display usage information

Display D&D Schedule
    OUT

    expect(output).to eq(expected_output)
  end
end
