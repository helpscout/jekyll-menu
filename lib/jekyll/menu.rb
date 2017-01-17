require "jekyll"

module Jekyll
  module Menu
    @site = false
    @data = {}
    @options = {
      "url_path" => "/",
      "menu_class" => "c-menu",
      "menu_sub_class" => "c-menu--sub-menu",
      "menu_active_class" => "is-active",
      "item_class" => "c-menu__item",
      "item_active_class" => "is-active",
      "item_sub_class" => "has-sub-menu",
      "link_class" => "c-menu__link",
    }

    def self.initialize(data)
      @data = data ? data : {}
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
        sub = false
        m[1] = self.setup_menu(items, title, sub)
        m
      }
      @data.data["menu"] = Hash[*menus.flatten(1)]
    end

    def self.setup_menu(items, title, sub = true)
      new_menu = {}
      if title
        new_menu["title"] = title
      end
      path = menu_path(title)
      new_menu["path"] = path
      new_menu["items"] = self.setup_menu_items(items, path)
      new_menu["link"] = "#"
      new_menu["class"] = self.menu_class(sub, new_menu["items"])
      new_menu
    end

    def self.setup_menu_items(items, path)
      path = path ? path : @options["url_path"]
      items.map { |i|
        item = {}
        item["title"] = i["title"]
        item["link"] = self.item_link(i, path)
        item["class"] = self.item_class(item["link"], i.key?("items"))
        item["link_class"] = self.link_class(item["link"])
        item["active"] = self.item_is_active(item["link"])
        if i.key?("items")
          item["menu"] = self.setup_menu(i["items"], i["title"], true)
          item["link"] = "#"
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

    def self.menu_class(sub = false, items = [])
      class_name = @options["menu_class"]
      if sub
        class_name = "#{class_name} #{@options['menu_sub_class']}"
        if self.menu_has_active_item(items)
          class_name = "#{class_name} #{@options['menu_active_class']}"
        end
      end
      class_name
    end

    def self.menu_has_active_item(items = [], has_active = false)
      unless has_active
        items.each do |item|
          if item["items"]
            self.menu_has_active_item(item["items"], has_active)
          end
          if item["active"]
            has_active = true
            break
          end
        end
      end
      has_active
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
      url = @data.url
      unless path === "/"
        path = path.gsub(/\/$/, "")
      end
      unless url === "/"
        url = url.gsub(/\/$/, "")
      end
      url === path
    end

    def self.item_class(path, has_items = false)
      class_name = @options["item_class"]
      if self.item_is_active(path)
        class_name = "#{class_name} #{@options['item_active_class']}"
      end
      if has_items
        class_name = "#{class_name} #{@options['item_sub_class']}"
      end
      class_name
    end

    def self.link_class(path)
      class_name = @options["link_class"]
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
    Jekyll::Hooks.register :posts, :pre_render do |post, payload|
      self.initialize(post)
      payload["page"]["menu"] = @data["menu"]
    end

    # Generates and evaluates data for pages
    Jekyll::Hooks.register :pages, :pre_render do |page, payload|
      self.initialize(page)
      payload["page"]["menu"] = @data["menu"]
    end
  end
end
