#
# Be sure to run `pod lib lint PlugNPlay.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PlugNPlay'
  s.version          = '1.1.2'
  s.summary          = 'Native iOS integration & easy to integrate and use library.'
  s.description      = 'Provides a ready to use, drop in set of User Screens to enable payments with iOS Apps. Provide an end to end payment experience with all the features offered by the Citrus SDK. Reduces integration friction as merchants do not have to worry about designing the checkout screen, bank assets, or deal with complexity required to handle different payments methods.'

  s.homepage         = 'https://github.com/citruspay/citruspay-ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Umang Arya' => 'umang.arya@payu.in' }
  s.source           = { :git => 'https://github.com/citruspay/citruspay-ios-sdk.git', :tag => "plug-n-play.1.1.2" }

  s.ios.deployment_target = '8.0'
  s.requires_arc     = true

  s.ios.preserve_paths   = '**'
  s.vendored_frameworks  = 'Framework/plugnplay-sdk/PlugNPlay.framework'

  s.dependency 'CitrusPay'
end
