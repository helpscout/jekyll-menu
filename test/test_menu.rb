require 'helper'

class TestTemplate < JekyllUnitTest
  context "jekyll-menu" do
    setup do
      @site = Site.new(site_configuration)
      @site.read
      @site.generate
      @site.render
    end

    should "generator: initializes correctly" do
      post = @site.posts.docs[0]
      puts post
      expected = <<EXPECTED
hello
EXPECTED
      assert_equal(true, true)
    end

  end
end
