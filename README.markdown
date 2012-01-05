This project is still under serious development, so check back soon.

Guard::NUnit [![Build Status](https://secure.travis-ci.org/markglenn/guard-nunit.png)](http://travis-ci.org/markglenn/guard-nunit)
=============

NUnit guard allows to automatically run NUnit tests when projects are rebuilt.

Requirements
------------

* Ruby 1.8.7+
* Guard
* Mono and NUnit (.NET coming soon)

Installation
------------

Install ruby on your machine.  

Add a file named _Gemfile_ in the root of your project with the following contents

``` ruby
source "http://rubygems.org"

gem 'guard'
gem 'guard-nunit'
```
