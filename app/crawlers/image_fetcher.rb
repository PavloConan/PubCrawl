class ImageFetcher < Kimurai::Base
  @config = {
    user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
    before_request: { delay: 0.5 }
  }

  VENDOR_XPATHS = {
    "dom_whisky" => "//*[@id='projector_image_1']",
    "forfiter" => "/html/body/div[1]/main/div[2]/div/div[1]/div[2]/img"
  }

  def self.call(item)
    @@item = item
    @@xpath = nil
    @@base_url = nil
    @@attribute = nil
    @start_urls = fetch_url
    self.crawl!
  end

  def parse(response, url:, data: {})
    image_url = response.xpath(@@xpath).attribute(@@attribute)&.value

    if image_url.blank?
      Alert.create!(description: "Failed to fetch image", item_id: @@item.id)
      return
    end

    final_url = image_url.include?("http") ? image_url : @@base_url + image_url

    @@item.update!(image_url: final_url)
  end

  def self.fetch_url
    vendor = Vendor.dom_whisky
    dom_whisky_item_price = @@item.item_prices.found.find_by(vendor_id: vendor.id)
    if dom_whisky_item_price
      @@xpath = VENDOR_XPATHS["dom_whisky"]
      @@base_url = vendor.url
      @@attribute = "href"
      return [dom_whisky_item_price.absolute_url]
    end

    vendor = Vendor.forfiter
    forfiter_item_price = @@item.item_prices.found.find_by(vendor_id: vendor.id)
    if forfiter_item_price
      @@xpath = VENDOR_XPATHS["forfiter"]
      @@attribute = "src"
      return [forfiter_item_price.absolute_url]
    end
  end
end