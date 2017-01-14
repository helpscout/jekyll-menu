require "jekyll"

module Jekyll
  module Menu
    @site = false
    @data = {}
    @options = {
      "url_path" => "/",
      "class" => "c-menu",
      "item_class" => "c-menu__item",
      "item_active_class" => "is-active",
    }

    def self.initialize(data)
      @data = data ? data : {}
      @site.data["site_menu"] = []
      if @site.data.key?("menus")
        if @site.data["menus"].length
          self.setup_menus()
        end
      end
    end

    def self.setup_menus
      menus = @site.data["menus"].map { |m|
        title = m[0]
        items = m[1]
        m[1] = self.setup_menu(items, title)["items"]
        m
      }
      @site.data["site_menu"] = Hash[*menus.flatten(1)]
    end

    def self.setup_menu(items, title)
      new_menu = {}
      if title
        new_menu["title"] = title
      end
      path = menu_path(title)
      new_menu["path"] = path
      new_menu["class"] = @options["class"]
      new_menu["link"] = "#"
      new_menu["items"] = self.setup_menu_items(items, path)
      new_menu
    end

    def self.setup_menu_items(items, path)
      path = path ? path : @options["url_path"]
      items.map { |i|
        if i.key?("pages")
          item = self.setup_menu(i["pages"], i["title"])
        else
          item = {}
          item["title"] = i["title"]
          item["link"] = self.item_link(i, path)
          item["class"] = self.item_class(item["link"])
          item["active"] = self.item_is_active(item["link"])
        end
        item
      }
    end

    def self.liquify(input)
        output = Liquid::Template.parse(input)
        output.render(@data)
    end

    def self.slugify(path)
      path.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def self.menu_path(title)
      path = @options["url_path"]
      title = self.slugify(title)
      "#{path}#{title}"
    end

    def self.item_link(item, path)
      if item.key?("link")
        item["link"]
      else
        unless path === "/"
          title = item["title"]
          link = self.slugify(title)
          "#{path}/#{link}"
        else
          path
        end
      end
    end

    def self.item_is_active(path)
      unless path === "/"
        path = path.gsub(/\/$/, "")
      end
      @data.url === path
    end

    def self.item_class(path)
      class_name = @options["item_class"]
      if self.item_is_active(path)
        class_name = "#{class_name} #{@options['item_active_class']}"
      end
      class_name
    end

    # Sets the Site class for jekyll-menu
    Jekyll::Hooks.register :site, :pre_render do |site|
      @site = site
    end

    # Generates and evaluates data for posts
    Jekyll::Hooks.register :posts, :pre_render do |post|
      self.initialize(post)
    end

    # Generates and evaluates data for pages
    Jekyll::Hooks.register :pages, :pre_render do |page|
      self.initialize(page)
    end
  end
end
