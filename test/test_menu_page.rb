require 'helper'

class TestTemplate < JekyllUnitTest
  context "jekyll-menu" do
    setup do
      @site = Site.new(site_configuration)
      @site.read
      @site.generate
      @site.render
    end

    should "page: active item class is added to current page" do
      page = @site.pages[1]
      menu = page["menu"]["test-page"]
      item = menu["items"][1]

      assert_equal(true, item["active"])
    end

  end
end
