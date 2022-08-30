module Forfiter
  class FetchPotentialItems < Kimurai::Base
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
      response.xpath("//*[@id='amasty-shopby-product-list']/div[2]/ol/li").each.with_index do |product, i|
        @@products.push(
          {
            name: response.xpath(
              "//*[@id='amasty-shopby-product-list']/div[2]/ol/li[#{i+1}]/div/div[2]/strong/a"
              )&.text&.strip,
            url: response.xpath(
              "//*[@id='amasty-shopby-product-list']/div[2]/ol/li[#{i+1}]/div/div[2]/strong/a"
              )&.attribute("href")&.value&.split('.pl')&.last,
            category: "Wine"
          }
        )
      end

      PotentialItems::BulkCreate.new(@@products, vendor).call

      @@products = []

      next_page = response.at_xpath("//*[@id='amasty-shopby-product-list']/div[3]/div[3]/ul/li[last()]/a")

      return unless next_page && next_page[:class].include?("next")

      request_to :parse, url: next_page[:href]
    end

    def vendor
      @vendor ||= Vendor.find_by(sys_name: "forfiter")
    end

    def self.urls
      [
        "https://www.forfiterexclusive.pl/wino/?product_list_limit=36",
        "https://www.forfiterexclusive.pl/wino-musujace/?product_list_limit=36",
        "https://www.forfiterexclusive.pl/szampan/?product_list_limit=36",
        "https://www.forfiterexclusive.pl/wino-porto/?product_list_limit=36",
      ]
    end
  end
end