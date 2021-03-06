module Jekyll
  class CategoryPage < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'archive.html')
      self.data['category'] = category
      self.data['posts'] = site.categories[category]

      category_title_prefix = site.config['category_title_prefix'] || 'Posts filed under: '
      self.data['title'] = "#{category_title_prefix}#{category}"
    end
  end

  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'archive'
        dir = site.config['category_dir'] || 'category'
        site.categories.keys.each do |category|
          site.pages << CategoryPage.new(site, site.source, File.join(dir, category.gsub(/[^0-9a-zA-Z]+/, '-')), category)
        end
      end
    end
  end
end
