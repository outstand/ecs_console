# ecs_console
Run a remote console on ECS

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ecs_console'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ecs_console

## Usage

TODO: Write usage instructions here

## Development

- `./build_dev.sh`
- `docker run -it --rm -v $(pwd):/ecs_console outstand/ecs_console:dev rspec spec` to run specs

To release a new version:
- Update the version number in `version.rb` and `Dockerfile.release` and commit the result.
- `./build_dev.sh`
- `docker run -it --rm -v ~/.gitconfig:/root/.gitconfig -v ~/.gitconfig.user:/root/.gitconfig.user -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -v ~/.gem:/root/.gem -w /ecs_console outstand/ecs_console:dev rake release`
- `docker build -t outstand/ecs_console:VERSION -f Dockerfile.release .`
- `docker push outstand/ecs_console:VERSION`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/outstand/ecs_console.


## License

The gem is available as open source under the terms of the [Apache-2.0 License](https://opensource.org/licenses/Apache-2.0).
