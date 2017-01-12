require "jekyll"

module Jekyll
  module Menu
    class Generator < Jekyll::Generator

      def initialize(config = {})
        @site = false
        @options = {
          "url_path" => "/",
          "class" => "c-menu",
          "item_class" => "c-menu__item"
        }
      end

      def generate(site)
        @site = site
        @site.data["site_menu"] = []
        if @site.data.key?("menus")
          if @site.data["menus"].length
            setup_menus()
          end
        end
      end

      def setup_menus
        menus = @site.data["menus"]
        @site.data["site_menu"] = menus.map { |m|
          title = m[0]
          items = m[1]
          menu = {
            "title" => title
          }

          setup_menu(menu, title, items)
        }
      end

      def setup_menu(menu, title, items)
        new_menu = {}
        if title
          new_menu["title"] = title
        end
        path = menu_path(title)
        new_menu["path"] = path
        new_menu["class"] = @options["class"]
        new_menu["link"] = "#"
        new_menu["items"] = setup_menu_items(items, path)
        new_menu
      end

      def setup_menu_items(items, path)
        path = path ? path : @options["url_path"]
        items.map { |i|
          if i.key?("pages")
            item = setup_menu(item, i["title"], i["pages"])
          else
            item = {}
            item["class"] = @options["item_class"]
            item["title"] = i["title"]
            item["link"] = item_link(i, path)
          end
          item
        }
      end

      def slugify(path)
        path.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      end

      def menu_path(title)
        path = @options["url_path"]
        title = slugify(title)
        "#{path}#{title}"
      end

      def item_link(item, path)
        if item.key?("link")
          item["link"]
        else
          unless path === "/"
            title = item["title"]
            link = slugify(title)
            "#{path}/#{link}"
          else
            path
          end
        end
      end

    end
  end
end
