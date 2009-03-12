require File.dirname(__FILE__) + '/../test_helper'

class MediawikiFilterTest < Test::Unit::TestCase

  def test_filter_name
    assert_equal 'Mediawiki', MediawikiFilter.filter_name
  end

  def test_filter
    assert_equal '<p><strong>strong</strong></p>', MediawikiFilter.filter('**strong**')
  end
  
 end
