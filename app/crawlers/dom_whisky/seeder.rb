module DomWhisky
  class Seeder
    URLS = [
      {
        url: "/pol_m_World-Whisky_Whiskey-amerykanska_Bourbon-152.html",
        category: "Bourbon",
        max_counter: 15
      },
      {
        url: "/pol_m_Inne-alkohole_Gin-465.html",
        category: "Gin",
        max_counter: 15
      }
      # {
      #   url: "/pol_m_Inne-alkohole_Rum-467.html",
      #   category: "Rum",
      #   max_counter: 32
      # }
    ]

    def initialize
      @base_vendor_url = Vendor.find_by(sys_name: "dom_whisky").url
    end

    def call
      URLS.each do |category_path|
        (0).upto(category_path[:max_counter]) do |i|
          final_path = i.zero? ? category_path[:url] : category_path[:url] + "&counter=#{i}"
          puts "Fetching from #{final_path}..."
          results = fetch_items(final_path, @base_vendor_url)
          puts "Done!"
          serialized_results = serialize_results(results)

          Items::BulkCreate.call(serialized_results, category_path[:category])
        end
      end
    end

    private

    def fetch_items(category_path, base_vendor_url)
      Wombat.crawl do
        base_url base_vendor_url
        path category_path

        names "css=.product-name", :list
        prices "css=.price", :list
        urls "css=.product-icon", :iterator do
          url({ xpath: './@href' })
        end
      end
    end

    def serialize_results(results)
      [].tap do |arr|
        (0).upto(results["names"].size-1).each do |index|
          arr.push(
            {
              name: results["names"][index],
              price: results["prices"][index]&.gsub(',','.')&.gsub(' ', '')&.to_f,
              url: results["urls"][index]["url"]
            }
          )
        end
      end
    end
  end
end
