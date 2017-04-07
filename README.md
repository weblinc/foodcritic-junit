# Foodcritic::Junit

Parses foodcritic output (with context) into a JUnit XML file.

## Usage

```bash
$ bundle exec foodcritic -C . | bundle exec foodcritic-junit
=> Wrote test/reports/report.xml
```

![Example JUNIT output](http://i.imgur.com/ZoOI3yk.png?1)

## Install

In your Gemfile: `gem 'foodcritic-junit'` or just `gem install foodcritic-junit`

## Options

Environment Variables

```
COOKBOOK_NAME="my_cookbook"
FOODCRITIC_JUNIT_OUTPUT_DIR="/tmp/"
FOODCRITIC_JUNIT_OUTPUT_FILE="my_junit_report.xml"
```

## Other

Pull requests / bug reports welcome :)

This gem is released and available under the MIT license.

Inspired by [foodcritic-junit-tee](https://github.com/clintoncwolfe/chef-ci-tools/blob/master/bin/foodcritic-junit-tee.rb)
