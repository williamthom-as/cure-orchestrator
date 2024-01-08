# Cure Orchestrator

![run tests](https://github.com/williamthom-as/cure-orchestrator/actions/workflows/main.yml/badge.svg)

Cure Orchestrator is a web app and low-dependency processing server for [Cure](https://github.com/williamthom-as/cure).

The project has three components; a REST API for managing and scheduling Cure jobs, an independent processing server for
running jobs and simple SPA for interacting with the API.

It is functional, but very limited in capability. This is not likely to change any time soon.

![screenshot](https://github.com/williamthom-as/cure-orchestrator/assets/8381190/91d437bb-1b2e-406d-a8bc-3219597e6a2a)

## Installation

### Requirements

- Ruby 3.2 or above
- SQLite3

Install it yourself as:

    $ gem install cure-orchestrator

## Usage

Run Rack and background processing server.

    bundle exec rackup -p 3000

Run frontend

    cd client && npm start

## Development


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/williamthom-as/cure-orchestrator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/cure/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Cure project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/cure-orchestrator/blob/master/CODE_OF_CONDUCT.md).