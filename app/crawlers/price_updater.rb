class PriceUpdater < Kimurai::Base
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    before_request: { delay: 0.5 }
  }

  def self.call(item_price)
    return if item_price.url.blank? || item_price.manual_update

    @@item_price = item_price
    @start_urls = [@@item_price.absolute_url]
    self.crawl!
  rescue RuntimeError => e
    @@item_price.update!(page_not_found: true) if e.message.include?("404")
    return
  end

  def parse(response, url:, data: {})
    price = response.xpath(@@item_price.vendor.price_xpath).inner_text

    if price.blank?
      @@item_price.update!(faulty_xpath: true)
    else
      @@item_price.update!(price: parse_price(price), faulty_xpath: false)
    end
  end

  def parse_price(price)
    price.strip.match(/((\d+\s)?\d+\,\d+)/).to_s.gsub(' ','').gsub(',','.').to_f
  end
end
