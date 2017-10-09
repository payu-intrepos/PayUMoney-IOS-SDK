#
# Be sure to run `pod lib lint LazyPay.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LazyPay'
  s.version          = '1.1.0'
  s.summary          = 'LazyPay checkout - Buy now, Pay Later!'
  s.description      = 'Native iOS integration. Simple lightweight integration. Enable seamless payments for low value online purchases. Faster transactions and with higher transaction success rates for merchants'

  s.homepage         = 'https://github.com/citruspay/citruspay-ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mukeshpatil1' => 'mukesh.patil@citruspay.com' }
  s.source           = { :git => 'https://github.com/citruspay/citruspay-ios-sdk.git', :tag => 'lazypay.1.1.0' }

  s.ios.deployment_target = '8.0'
  s.requires_arc     = true

  s.ios.preserve_paths   = '**'
  s.vendored_frameworks  = 'Framework/lazypay-sdk/LazyPay.framework'

  s.dependency 'CitrusPay'
end
