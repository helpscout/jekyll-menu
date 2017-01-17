require 'helper'

class TestTemplate < JekyllUnitTest
  context "jekyll-menu" do
    setup do
      @site = Site.new(site_configuration)
      @site.read
      @site.generate
      @site.render
    end

    should "class: an item has the correct menu class" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu["items"][0]

      class_name = "c-menu__item"

      assert_equal(class_name, item["class"])
    end

    should "class: an active item has the correct menu class" do
      page = @site.pages[1]
      menu = page["menu"]["test-page"]
      item = menu["items"][1]

      class_name = "c-menu__item is-active"

      assert_equal(class_name, item["class"])
    end

    should "link: root / permalinks are untouched" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu["items"][0]

      url = "/"

      assert_equal(url, item["link"])
    end

    should "link: custom http URLs are untouched" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu["items"][2]

      url = "https://www.helpscout.net/"

      assert_equal(url, item["link"])
    end

    should "link: link class is correct" do
      page = @site.pages[1]
      menu = page["menu"]["test-page"]
      item = menu["items"][0]

      class_name = "c-menu__link"

      assert_equal(class_name, item["link_class"])
    end

    should "link: active link class is correct" do
      page = @site.pages[1]
      menu = page["menu"]["test-page"]
      item = menu["items"][1]

      class_name = "c-menu__link is-active"

      assert_equal(class_name, item["link_class"])
    end

  end
end
