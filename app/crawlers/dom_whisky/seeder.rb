module DomWhisky
  class Seeder < Kimurai::Base
    @engine = :selenium_firefox
    @config = {
      user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
      before_request: { delay: 2 }
    }

    def self.call
      @start_urls = urls
      @@products = []
      self.crawl!
    end

    def parse(response, url:, data: {})

      response.xpath("//*[@id='search']/div/div").each.with_index(1) do |_, i|
        response.xpath("//*[@id='search']/div/div[#{i}]/div").each.with_index(1) do |_, j|
          @@products.push(
            {
              name: response.xpath("//*[@id='search']/div/div[#{i}]/div[#{j}]/div/a[3]")&.text&.strip,
              url: response.xpath("//*[@id='search']/div/div[#{i}]/div[#{j}]/div/a[3]")&.attribute("href")&.value,
              price: response.xpath("//*[@id='search']/div/div[#{i}]/div[#{j}]/div/div[3]/span")&.text&.strip
            }
          )
        end
      end

      Items::BulkCreate.new(@@products, "Whisky").call

      @@products = []

      next_page = response.at_xpath("//*[@id='search_paging_bottom']/li[last()]/a")

      return unless next_page && next_page[:class].include?("next")

      request_to :parse, url: absolute_url(next_page[:href], base: "https://sklep-domwhisky.pl")
    end

    def self.urls
      [
        "https://sklep-domwhisky.pl/pol_m_World-Whisky_Whiskey-amerykanska_Single-malt-whisky-515.html",
        "https://sklep-domwhisky.pl/pol_m_World-Whisky_Whiskey-amerykanska_Tennessee-whiskey-166.html",
        "https://sklep-domwhisky.pl/pol_m_World-Whisky_Whiskey-irlandzka_Blended-whiskey-203.html",
        "https://sklep-domwhisky.pl/pol_m_World-Whisky_Whiskey-irlandzka_Grain-whiskey-196.html",
        "https://sklep-domwhisky.pl/pol_m_World-Whisky_Whiskey-irlandzka_Single-malt-whiskey-201.html",
        "https://sklep-domwhisky.pl/pol_m_World-Whisky_Whisky-japonska_Blended-malt-whisky-184.html",
        "https://sklep-domwhisky.pl/pol_m_World-Whisky_Whisky-japonska_Blended-whisky-182.html",
        "https://sklep-domwhisky.pl/pol_m_World-Whisky_Whisky-japonska_Single-malt-whisky-180.html"
      ]
    end
  end
end
