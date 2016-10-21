# Forum template

This Ruby on Rails forum template covers the following:

* Tree structure (using the Adjacency List plus Recursive Query approach)
* Language censorship...
* Updates via e-mail...

## Prerequisites

* Ruby 2.3.1 ([Setup using ruby-install + chruby and reasons to avoid RVM](http://ryanbigg.com/2014/10/ubuntu-ruby-ruby-install-chruby-and-you/))
* (Ubuntu only) Install the `libsqlite3-dev` package

## Configuration

* Run `bundle install` to install all dependencies.
* To create and populate the database, run:

```
#!sh
rails db:setup
rails db:seed
```

* Execute `rails s` to start the server.

## Tests

Run `rails test:models`...

