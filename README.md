# Forum template

This Ruby on Rails forum template covers the following:

* Tree structure (using the Adjacency List plus Recursive Query approach)
* Language censorship...
* Updates via e-mail...
* Pagination...

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

## References

* Recursive data (tree) structures: by comparison, the Adjacency List approach combined with a recursive query is a simple and efficient solution for reading and writing within a tree structure
    * http://www.gmarik.info/blog/2012/recursive-data-structures-with-rails/
    * https://www.leighhalliday.com/tree-structures-in-your-rails-models
    * https://chaione.com/blog/modeling-a-tree-of-data-in-rails/
    * https://hashrocket.com/blog/posts/recursive-sql-in-activerecord (chosen solution)
    * http://stackoverflow.com/questions/192220/what-is-the-most-efficient-elegant-way-to-parse-a-flat-table-into-a-tree/192462#192462

