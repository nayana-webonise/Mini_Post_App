Rails.application.config.middleware.use OmniAuth::Builder do
 # provider :developer unless Rails.env.production?
  provider :facebook, '434277789963565' , '57f32627336bb116989ce62e0df0e759'
 #:scope => 'email,user_birthday,read_stream', :display => 'popup'
end
