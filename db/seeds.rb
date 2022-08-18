values = [
  {
    name: 'Dom Whisky',
    sys_name: 'dom_whisky',
    url: "https://sklep-domwhisky.pl/",
    price_xpath: "/html/body/div[1]/div/div/form/div[4]/div[1]/div[2]/div/strong"
  },
  {
    name: 'Fire & Ice',
    sys_name: 'fire_ice',
    url: "https://alkoholeswiata24.pl/",
    price_xpath: "/html/body/div[2]/div/div[5]/div/div/div[1]/div/div/div[1]/div[2]/form/div[2]/div[3]/div[1]/table/tbody/tr/td[2]/span/text()"
  },
  {
    name: 'Grand Prix',
    sys_name: 'grand_prix',
    url: "https://www.alkoholeswiata.com/",
    price_xpath: "/html/body/div[1]/div/main/div/div/div[2]/article/div[2]/div[3]/p[1]/span/bdi/text()"
  },
  {
    name: 'Świat Alkoholi',
    sys_name: 'swiat_alkoholi',
    url: "https://www.amarone.pl/",
    price_xpath: "/html/body/div[3]/div[1]/div/section[3]/div/div/div/section/div/div[2]/div[2]/div[2]/div[2]/div/div[3]/div/div/span[2]/text()"
  },
  {
    name: 'Outlet Alkoholowy',
    sys_name: 'outlet_alkoholowy',
    url: "https://outletalkoholowy.pl/",
    price_xpath: "/html/body/div[2]/div[2]/div/div[4]/div/div/div/div[3]/form/div/div[1]/div[2]/p[1]/span[1]"
  },
  {
    name: "Forfiter",
    sys_name: 'forfiter',
    url: "https://www.forfiterexclusive.pl/",
    price_xpath: "/html/body/div[1]/main/div[2]/div/div[2]/div[4]/div[1]/span/span/span"
  }
]

# Importing without model validations
Vendor.import values