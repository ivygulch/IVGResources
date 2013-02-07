Pod::Spec.new do |s|
  s.name         = "IVGResources"
  s.version      = "0.0.1"
  s.summary      = "Manager multiple versions of same resources"
  s.homepage     = "http://github.com/ivygulch/IVGResources"
  s.license      = { :type => 'tbd', :file => 'LICENSE'}
  s.author       = { "dwsjoquist" => "dwsjoquist@sunetos.com"}
  s.source       = { :git => "git@github.com:ivygulch/IVGResources.git" }
  s.platform     = :ios, '5.0'
  s.source_files = 'IVGResources/source/**/*.*'
  s.frameworks   = 'Foundation', 'UIKit', 'CoreGraphics'
  s.requires_arc = true
end

