#
# Be sure to run `pod lib lint LTModalViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

  s.name         = "LTModalViewController"
  s.version      = "2.0.1"
  s.summary      = "LTModalViewController - A easy way to display modal style controller -- (Swift & Objc)"
  s.homepage     = "https://futao.me/"
  s.license      = 'MIT'
  s.author       = "Ftkey"
  s.requires_arc = true
  s.source       = {:git => 'https://github.com/Ftkey/LTModalViewController.git', :tag => s.version.to_s }
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '4.0',
  }
  s.ios.deployment_target = '8.0'

  s.frameworks  = "Foundation"
  s.source_files = 'Sources/**/*.{swift}'

end


