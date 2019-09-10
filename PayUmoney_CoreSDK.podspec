#
#  Be sure to run `pod spec lint PayUmoney_CoreSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "PayUmoney_CoreSDK"
  s.version      = "3.8"
  s.summary      = "PayUmoney iOS SDK"
  s.description  = "This is a native SDK to integrate PayUmoney services with iOS apps"

  s.homepage     = "https://github.com/payu-intrepos/PayUMoney-IOS-SDK"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Umang Arya" => "umang.arya@payu.in" }
  s.source       = { :git => "https://github.com/payu-intrepos/PayUMoney-IOS-SDK.git", :tag => "PayUmoney_CoreSDK.3.8" }

  s.ios.deployment_target = '8.0'
  s.requires_arc     = true

  s.ios.preserve_paths   = '**'
  s.vendored_frameworks  = 'CoreSDK/PayUMoneyCoreSDK.framework'

  s.dependency 'PayUIndia-Custom-Browser', '~> 5.8.1'

end
