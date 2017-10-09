#
# Be sure to run `pod lib lint CitrusPay.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = "CitrusPay"
s.version          = "4.1.7"
s.summary          = "CitrusPay iOS SDK."

s.description      = "Enhanced CitrusPay iOS SDK for Superior Native Payments Experience."

s.homepage         = "https://github.com/citruspay/citruspay-ios-sdk"
s.license          = 'MIT'
s.author           = { "Vipin Aggarwal" => "vipin.aggarwal@payu.in" }
s.source           = { :git => "https://github.com/citruspay/citruspay-ios-sdk.git", :tag => s.version.to_s }

s.platform     = :ios, '8.0'
s.requires_arc = true

s.ios.preserve_paths   = '**'
s.vendored_frameworks  = 'Framework/core-sdk/CitrusPay.framework'

s.dependency 'JSONModel'
s.dependency 'CitrusGraphics'

end
