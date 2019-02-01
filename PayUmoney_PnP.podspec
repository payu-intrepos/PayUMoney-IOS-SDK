#
#  Be sure to run `pod spec lint PayUmoney_PnP.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "PayUmoney_PnP"
  s.version      = "2.5.0"
  s.summary      = "Native iOS integration & easy to integrate and use library."
  s.description  = "Provides a ready to use, drop in set of User Screens to enable payments with iOS Apps. Provide an end to end payment experience with all the features offered by the Citrus SDK. Reduces integration friction as merchants do not have to worry about designing the checkout screen, bank assets, or deal with complexity required to handle different payments methods."

  s.homepage     = "https://github.com/payu-intrepos/PayUMoney-IOS-SDK"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Umang Arya" => "umang.arya@payu.in" }
  s.source       = { :git => "https://github.com/payu-intrepos/PayUMoney-IOS-SDK.git", :tag => "PayUmoney_PnP.2.5.0" }

  s.ios.deployment_target = '8.0'
  s.requires_arc     = true

  s.ios.preserve_paths   = '**'
  s.vendored_frameworks  = 'PlugNPlay/PlugNPlay.framework'

  s.dependency 'PayUmoney_CoreSDK'

end
