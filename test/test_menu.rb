require 'helper'

class TestTemplate < JekyllUnitTest
  context "jekyll-menu" do
    setup do
      @site = Site.new(site_configuration)
      @site.read
      @site.generate
      @site.render
    end

    should "do something" do
      expected = true
      actual = true

      assert_equal(expected, actual)
    end

  end
end
