require 'helper'

class TestTemplate < JekyllUnitTest
  context "jekyll-menu" do
    setup do
      @site = Site.new(site_configuration)
      @site.read
      @site.generate
      @site.render
    end

    should "sub-menu: creates sub-menu items when YAML item has pages attribute" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu["items"][3]["menu"]

      assert(item, true)
    end

    should "sub-menu: sub-menu has items" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu["items"][3]["menu"]

      assert(item["items"], true)
    end

    should "sub-menu: parent item has # a link url" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu["items"][3]

      url = "#"

      assert_equal(url, item["link"])
    end

    should "sub-menu: parent item has the correct class name" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu["items"][3]

      class_name = "c-menu__item has-sub-menu"

      assert_equal(class_name, item["class"])
    end

    should "sub-menu: a sub-menu has the correct class name" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu["items"][4]["menu"]

      class_name = "c-menu c-menu--sub-menu"

      assert_equal(class_name, item["class"])
    end

    should "sub-menu: an active sub-menu has the correct class name" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu["items"][3]["menu"]

      class_name = "c-menu c-menu--sub-menu is-active"

      assert_equal(class_name, item["class"])
    end

    should "sub-menu: the first item of a sub-menu has the correct class name" do
      page = @site.pages[0]
      menu = page["menu"]["test-page"]
      item = menu["items"][3]["menu"]["items"][0]

      class_name = "c-menu__item"

      assert_equal(class_name, item["class"])
    end

  end
end
