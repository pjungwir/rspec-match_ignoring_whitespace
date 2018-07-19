rspec-match_ignoring_whitespace
===============================

[![Build Status](https://travis-ci.org/pjungwir/rspec-match_ignoring_whitespace.svg?branch=master)](https://travis-ci.org/pjungwir/rspec-match_ignoring_whitespace)

RSpec matcher to compare strings ignoring (most) whitespace.

First we convert all adjacent whitespace to a single space, including tabs, newlines, form feeds, non-breaking spaces, etc.
Then we also strip whitespace from the beginning and end.
Finally we compare the results for equality.

This gem borrows almost everything from [`rspec-match_fuzzy`](https://github.com/winebarrel/rspec-match_fuzzy/),
except the comparison algorithm is just a bit different.


Installation
------------

Add this line to your application's Gemfile:

```ruby
gem 'rspec-match_ignoring_whitespace'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-match_ignoring_whitespace


Usage
-----

```ruby
s1 = "πόλλ΄ οἶδ΄ ἀλώπηξ, ἀλλ΄ ἐχῖνος ἓν μέγα."
s2 = <<-EOF
  πόλλ΄ οἶδ΄ ἀλώπηξ,
  ἀλλ΄ ἐχῖνος ἓν μέγα.
EOF
expect(s1).to match_ignoring_whitespace(s2)
```


TODO
----

I can imagine a few variations of our comparison algorithm being useful:

  - Instead of replacing whitespace with a single space, just remove it completely.
  - Don't strip off the leading/trailing space.

If anyone out there wants those features, let me know! :-)


Tests
-----

Say `rake` to run rspec tests plus Rubocop,
or `rspec spec` to run just the tests.


Contributing
------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone hasn't already requested and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make be sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, that is fine, but please isolate that change to its own commit so I can cherry-pick around it.

Commands for building/releasing/installing:

* `rake build`
* `rake install`
* `rake release`

Copyright
---------

Copyright (c) 2018 Paul A. Jungwirth.
See LICENSE.txt for further details.
