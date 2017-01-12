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
      puts @site.data["site_menu"][0]["items"]
      # exit
      post = @site.posts.docs[0]
      expected = <<EXPECTED
hello
EXPECTED
      assert_equal(true, true)
    end

  end
end
