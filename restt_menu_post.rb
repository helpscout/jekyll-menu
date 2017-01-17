require 'helper'

class TestTemplate < JekyllUnitTest
  context "jekyll-menu" do
    setup do
      @site = Site.new(site_configuration)
      @site.read
      @site.generate
      @site.render
    end

    should "post: active item class is added to current post" do
      post = @site.posts[0]
      menu = post["menu"]["test-post"]
      item = menu[1]

      assert_equal(true, item["active"])
    end

  end
end
