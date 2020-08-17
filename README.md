# DndSchedule

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/dnd_schedule`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dnd_schedule'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install dnd_schedule

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dnd_schedule. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/dnd_schedule/blob/master/CODE_OF_CONDUCT.md).


## Code of Conduct

Everyone interacting in the DndSchedule project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/dnd_schedule/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2020 Mel Riffe. See [MIT License](LICENSE.txt) for further details.

----

Config file: ~/.dnd_schedule
Dir.home + "/.dnd_schedule"

----

games:
    Insanity:
        frequency: "1st Saturday"
    Matsif:
        frequency: "3rd Saturday"
        role: "player"
    Gwynzer:
        frequency: "4th Saturday"
        role: "player"
    Noah:
        frequency: "Every 2 weeks"
        starting: "2020-08-22"
    Kaela
        frequence: "Every 3 weeks"
        starting: "2020-09-06"

defaults:
    occurrences: 12
    role: "dm"

----

config command operatoins:
what do i want to support via a 'config' command?
* generation of an empty config file
* adding entries to the config file (maybe like git)
* opening editor on the config file
* removing entries from the the config file
* support command-line arugment overrides
* support reading from the ENV (need to define order of precendence)

----

display command options:

--game [name] : display schedule for specified game
--month [name] : display schedule for specified month
--upcoming : display schedule for games in the next 2 weeks
--all : display schedule for all games

