class PriceUpdater < Kimurai::Base
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    before_request: { delay: 0.5 }
  }

  def self.call(item_price, difference_alert: false)
    return if item_price.url.blank? || item_price.manual_update

    @@item_price = item_price
    @@difference_alert = difference_alert
    @start_urls = [@@item_price.absolute_url]
    self.crawl!
  rescue RuntimeError => e
    if e.message.include?("404")
      @@item_price.update!(page_not_found: true) if e.message.include?("404")
      Alert.create!(
        description: "Page not found",
        item_price_url: @@item_price.absolute_url,
        item_price_id: @@item_price.id
      )
    end
    return
  end

  def parse(response, url:, data: {})
    price = response.xpath(@@item_price.vendor.price_xpath).inner_text

    if price.blank?
      Alert.create!(
        description: "Couldn't fetch the price",
        item_price_url: @@item_price.absolute_url,
        item_price_id: @@item_price.id
      )
      @@item_price.update!(faulty_xpath: true)
      return
    end

    parsed_price = parse_price(price)

    puts "PARSED PRICE: #{parsed_price}"

    if @@difference_alert && @@item_price.price && (parsed_price - @@item_price.price).abs > 100
      Alert.create!(
        description: "Suspiciously big price difference",
        item_price_url: @@item_price.absolute_url,
        item_price_id: @@item_price.id
      )
    else
      @@item_price.update!(price: parse_price(price), faulty_xpath: false)
    end
  end

  def parse_price(price)
    price.gsub(/[[:space:]]/, '').match(/((\d+\s)?\d+\,\d+)/).to_s.to_f
  end
end
