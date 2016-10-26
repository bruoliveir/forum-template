require 'test_helper'

class ProfanityFilterTest < ActiveSupport::TestCase
  include ProfanityFilter

  def setup
    @user = users(:example)
    @discussion = Discussion.create(:title => "1. fuck", :body => "fucking body", :user => @user)
  end

  test "should not clean before save" do
    assert_equal '1. fuck', @discussion.title
    assert_equal 'fucking body', @discussion.body
  end

  test "should clean after find" do
    profane_discussion = Discussion.find(@discussion.id)
    assert_equal '1. ****', profane_discussion.title
    assert_equal '******* body', profane_discussion.body
  end

  test "should not modify clean words" do
    assert_equal 'happy', clean('happy')
  end
  
  test "should not modify whitespace" do
    assert_equal 'hello  world', clean('hello  world')
    assert_equal "hello \t world", clean("hello \t world")
    assert_equal "hello \n world", clean("hello \n world")
  end
  
  test "should not modify special characters" do
    assert_equal 'happy  ****', clean('happy  fuck')
    assert_equal 'happy\'s', clean('happy\'s')
    assert_equal '****\'s', clean('fuck\'s')
    assert_equal '****?!', clean('fuck?!')
  end
  
  test "should replace banned words" do
    assert_equal '****', clean('fuck')
  end
  
  test "should replace punctuation spaced banned words" do
    assert_equal '****', clean('f-u-c-k')
    assert_equal '****', clean('f.u.c.k')
    assert_equal 'happy-****', clean('happy-fuck')
  end
end
