RSpec.describe "`dnd_schedule display` command", type: :cli do
  it "executes `dnd_schedule help display` command successfully" do
    output = `dnd_schedule help display`
    expected_output = <<-OUT
Usage:
  dnd_schedule display [OPTIONS]

Options:
  -a, [--all], [--no-all]            # Display schedule for all games
  -u, [--upcoming], [--no-upcoming]  # Display schedule for games in the next 2 weeks
                                     # Default: true
  -l, [--list], [--no-list]          # Display a list of configured games
  -g, [--game=GAME]                  # Display schedule for specified game
  -e, [--exclude=GAME]               # Exclude schedule for specified game
  -m, [--month=N]                    # Display schedule for specified month
  -h, [--help], [--no-help]          # Display usage information
      [--debug], [--no-debug]        # Run in debug mode

Description:
  Display D&D Schedule(s). Based on information stored in 'config.yml' this command displays the various D&D games and their scheduled dates.

  The default behavior is to display the games scheduled in the next 2 weeks; the --upcoming flag.

  You can also specify specific games, or specific months with which to display schedules.

  The --all command overrides all passed in options.
    OUT

    expect(output).to eq(expected_output)
  end
end
