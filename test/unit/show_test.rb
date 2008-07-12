require File.dirname(__FILE__) + '/../test_helper'

class ShowTest < Test::Unit::TestCase
  fixtures :shows
  
  def test_next_episode_order_first
    assert 1, shows(:first).next_episode_order
  end

  def test_next_episode_order_first
    show = shows(:first)

    order = 234
    show.episodes.create(:title => "Test", :slug => "test", :order => order)
    assert_equal order + 1, show.next_episode_order
  end
  
end
