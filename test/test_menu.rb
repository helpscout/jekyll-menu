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
      item = menu[0]

      class_name = "c-menu__item"

      assert_equal(class_name, item["class"])
    end

    should "class: an active item has the correct menu class" do
      page = @site.pages[1]
      menu = page["menu"]["test-page"]
      item = menu[1]

      class_name = "c-menu__item is-active"

      assert_equal(class_name, item["class"])
    end

    should "link: root / permalinks are untouched" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu[0]

      url = "/"

      assert_equal(url, item["link"])
    end

    should "link: custom http URLs are untouched" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu[2]

      url = "https://www.helpscout.net/"

      assert_equal(url, item["link"])
    end

    should "sub-menu: creates sub-menu items when YAML item has pages attribute" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu[3]

      assert(item["items"], true)
    end

    should "sub-menu: has # a link url" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu[3]

      url = "#"

      assert_equal(url, item["link"])
    end

    should "sub-menu: a sub-menu has the correct class name" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu[4]

      class_name = "c-menu c-menu--sub-menu"

      assert_equal(class_name, item["class"])
    end

    should "sub-menu: an active sub-menu has the correct class name" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu[3]

      class_name = "c-menu c-menu--sub-menu is-active"

      assert_equal(class_name, item["class"])
    end

  end
end
