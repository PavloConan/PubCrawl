class PriceFinder < Kimurai::Base

  def self.call(url, xpath)
    @start_urls = [url]
    @@xpath = xpath
    self.crawl!
  end

  def parse(response, url:, data: {})
    price = response.xpath(@@xpath).inner_text
    return if price.blank?

    parse_price(price)
  end

  def parse_price(price)
    price.strip.gsub(',','.').to_f
  end
end
