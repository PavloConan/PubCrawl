values = [
  { name: 'Dom Whisky', sys_name: 'dom_whisky', url: "https://sklep-domwhisky.pl/" },
  { name: 'Fire & Ice', sys_name: 'fire_ice', url: "https://alkoholeswiata24.pl/" },
  { name: 'Grand Prix', sys_name: 'grand_prix', url: "https://www.alkoholeswiata.com/" },
  { name: 'Świat Alkoholi', sys_name: 'swiat_alkoholi', url: "https://www.amarone.pl/" },
  { name: 'Outlet Alkoholowy', sys_name: 'outlet_alkoholowy', url: "https://outletalkoholowy.pl/" }
]

# Importing without model validations
Vendor.import valuesAdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?