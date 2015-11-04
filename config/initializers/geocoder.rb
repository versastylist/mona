Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'latitude'     => 30,
      'longitude'    => 30,
      'address'      => '1 Congress St',
      'state'        => 'Massachusetts',
      'state_code'   => 'MA',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)
