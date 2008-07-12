require File.dirname(__FILE__) + '/../test_helper'

class SlugTest < Test::Unit::TestCase

  # Replace this with your real tests.
  def test_slugify_empty
    assert_equal "", Slug.slugify(nil)
    assert_equal "", Slug.slugify("")
    assert_equal "", Slug.slugify("  ")
  end
  
  def test_slugify_simple
    assert_equal "abc", Slug.slugify("abc")
    assert_equal "ab-c", Slug.slugify("ab-c")
  end
  
  def test_slugify_simple_specials
    assert_equal "eeauc", Slug.slugify("éèêàùç")
  end

  def test_slugify_unsupported
    assert_equal "ma-fourche-dans-ta-g", Slug.slugify("Ma fourche, dans ta g... !")
    assert_equal "aa-12-a", Slug.slugify("Aa*12!$ëa ! ")
  end
  
  def test_slugify_length
    assert_equal 30, Slug.slugify("Je suis vraiment vraiment vraiment trop long").size
  end

end
