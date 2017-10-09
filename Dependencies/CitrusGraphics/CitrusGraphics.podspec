#
# Be sure to run `pod lib lint CitrusGraphics.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CitrusGraphics'
  s.version          = '1.1.3'
  s.summary          = 'A lightweight, pure-Swift library for downloading and caching images from the web.'

  s.description      = 'Dynamic Assets will be available in a new package which could be consumed by any module for their assets requirements. All the assets will be hosted in cloud and SDK will have both default & low resolution image for it which will be replaced by high resolution image once asset is downloaded and cached based on device specification.'

  s.homepage         = 'https://github.com/citruspay/citruspay-ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Umang Arya' => 'umang.arya@payu.in' }
  s.source           = { :git => "https://github.com/citruspay/citruspay-ios-sdk.git", :tag => "graphics.1.1.3" }

  s.platform         = :ios, '8.0'
  s.requires_arc     = true

  s.ios.preserve_paths   = '**'
  s.vendored_frameworks  = 'Framework/graphics-sdk/CitrusGraphics.framework'

  s.dependency 'Kingfisher'
end
