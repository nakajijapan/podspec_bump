[![Gem Version](https://badge.fury.io/rb/podspec_bump.svg)](http://badge.fury.io/rb/podspec_bump)
[![Build Status](https://travis-ci.org/nakajijapan/podspec_bump.svg)](https://travis-ci.org/nakajijapan/podspec_bump)

# PodspecBump

A command line tools to bump podspec version for CocoaPods.
Inspired [Bump](https://github.com/gregorym/bump)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'podspec_bump'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install podspec_bump

## Usage

Curent version

```
podspec_bump current
```

Bump (major, minor, patch, pre)

```
podspec_bump patch
```

## Contributing

1. Fork it ( https://github.com/nakajijapan/podspec_bump/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
