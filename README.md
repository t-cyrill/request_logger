# RequestLogger

Rack Middleware; All request logger for web application.

## Installation

Add this line to your application's Gemfile:

    gem 'request_logger', git: 'https://github.com/t-cyrill/request_logger.git'

And then execute:

    $ bundle

## Usage

Write `use RequestLogger::Logger` In your config.ru

ie. Rails4

```config.ru
use RequestLogger::Logger, Logger.new(Rails.root.join('log', 'request.log')), 128, 10
```

Second parameter is required. You must set Logger.

Third parameter is optional. It's size limitation in each parameter and cookies.

ie. Too long post parameter in `foo`, `{foo: "[FILTERED Too large (... bytes)] ....."}`

Forth parameter is also optional. It's view limitation overed size limitation.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
