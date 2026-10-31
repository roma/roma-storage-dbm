# roma-storage-dbm

A GDBM storage for [ROMA](https://github.com/roma/roma), a distributed key-value store.

## Installation

Add this line to the Gemfile of your ROMA server:

```ruby
gem 'roma-storage-dbm'
```

And then run `bundle install`. Or install it yourself:

    $ gem install roma-storage-dbm

The gdbm gem needs the GDBM library, such as `libgdbm-dev` on Debian or Ubuntu, or `brew install gdbm` on macOS (then `gem install gdbm -- --with-gdbm-dir=$(brew --prefix gdbm)`).

## Usage

In the config.rb of ROMA, require the storage and set it to `STORAGE_CLASS`:

```ruby
require 'roma/storage/dbm'

module Roma
  module Config
    # ...
    STORAGE_CLASS = Roma::Storage::DbmStorage
    # ...
  end
end
```

Each node keeps its data in `STORAGE_PATH/<node-id>/<hash-name>/`, divided into `STORAGE_DIVNUM` files named `0.dbm`, `1.dbm` and so on.

## Development

Run `bundle install`, then `bundle exec rake spec` to run the tests.

## License

GPL-3.0. See LICENSE.txt.
