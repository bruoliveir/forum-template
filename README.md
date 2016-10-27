# Forum template

This Ruby on Rails forum template covers the following:

* Tree data structure using Path Enumeration (sorting resolved through base 36 enconding)
* Language censorship based upon [profanity_filter](https://github.com/intridea/profanity_filter)
* Updates via e-mail...
* Pagination

## Prerequisites

* Ruby 2.3.1
    * [Ubuntu, Ruby, ruby-install, chruby, Rails and You](http://ryanbigg.com/2014/10/ubuntu-ruby-ruby-install-chruby-and-you/): setup using ruby-install + chruby and reasons to avoid RVM
* (Ubuntu only) Install the `libsqlite3-dev` package

## Configuration

* Run `bundle install --without production` to install all dependencies.
* To create and populate the database, run `rails db:setup`.
* Execute `rails s` to start the server.

## Tests

Run `rails test:models` to test models and `rails test:integration` to test controller methods.

To test everything, including lib modules, run `rails test`.

## API

### /discussions

* Method: GET
* Response: array of discussion objects ordered by last updated

### /discussions/:id

* Method: GET
* Response: discussion object including all descendents

### /discussions

* Method: POST
* Response: newly created discussion object or error messages
* Request body (application/json):
```
#!js
{
  "discussion": {
    "title": "Title",
    "body": "Body",
    "user_id": 1,
    "path": 11 // optional, MUST be base 36 encoded

  }
}
```

## References

* Recursive data (tree) structures: the Adjacency List approach combined with a recursive query *has been replaced* by the Path Enumeration approach combined with which resulted in better performance and eliminated database limitations
    * [Storing hierarchical data: Materialized Path](https://bojanz.wordpress.com/2014/04/25/storing-hierarchical-data-materialized-path/)
    * [Recursive data structures with Rails](http://www.gmarik.info/blog/2012/recursive-data-structures-with-rails/)
    * [Tree Structures in your Rails models](https://www.leighhalliday.com/tree-structures-in-your-rails-models)
    * [Modeling a Tree of Data in Rails](https://chaione.com/blog/modeling-a-tree-of-data-in-rails/)
    * [Using Recursive SQL with ActiveRecord trees](https://hashrocket.com/blog/posts/recursive-sql-in-activerecord)
    * [What is the most efficient/elegant way to parse a flat table into a tree?](http://stackoverflow.com/questions/192220/what-is-the-most-efficient-elegant-way-to-parse-a-flat-table-into-a-tree/192462#192462)
* Language censorship
    * [How can I gsub an array in ruby?](https://www.quora.com/How-can-I-gsub-an-array-in-ruby)
    * [profanity_filter](https://github.com/intridea/profanity_filter)
    * [List of Dirty, Naughty, Obscene, and Otherwise Bad Words](https://github.com/LDNOOBW/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words)
* [Learn Web Development with Rails](https://www.railstutorial.org/book/) by Michael Hartl
