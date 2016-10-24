# Forum template

This Ruby on Rails forum template covers the following:

* Tree structure (Path Enumeration)
* Language censorship...
* Updates via e-mail...
* Pagination...

## Prerequisites

* Ruby 2.3.1 ([Setup using ruby-install + chruby and reasons to avoid RVM](http://ryanbigg.com/2014/10/ubuntu-ruby-ruby-install-chruby-and-you/))
* (Ubuntu only) Install the `libsqlite3-dev` package

## Configuration

* Run `bundle install --without production` to install all dependencies.
* To create and populate the database, run:

```
#!sh
rails db:setup
rails db:seed
```

* Execute `rails s` to start the server.

## Tests

Run `rails test:models` to test models and `rails test:integration` to test controller methods.

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
#!json
{
  "discussion": {
    "title": "Root discussion",
    "body": "Content",
    "user_id": 1,
    "parent_id": 1 optional
  }
}
```

## References

* Recursive data (tree) structures: the Adjacency List approach combined with a recursive query *has been replaced* by the Path Enumeration approach which resulted in better performance and eliminated database limitations
    * http://www.gmarik.info/blog/2012/recursive-data-structures-with-rails/
    * https://www.leighhalliday.com/tree-structures-in-your-rails-models
    * https://chaione.com/blog/modeling-a-tree-of-data-in-rails/
    * https://hashrocket.com/blog/posts/recursive-sql-in-activerecord
    * http://stackoverflow.com/questions/192220/what-is-the-most-efficient-elegant-way-to-parse-a-flat-table-into-a-tree/192462#192462
* [Learn Web Development with Rails](https://www.railstutorial.org/book/) by Michael Hartl
