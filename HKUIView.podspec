# Podspec for HKUIView
#   Created by Harrison Kong on 2020/01/18

Pod::Spec.new do |s|

  platform                = :ios
  s.ios.deployment_target = '11.0'

  s.name          = 'HKUIView'
  s.summary       = 'HK UIView Enhancementments'
  s.requires_arc  = false
  s.version       = '1.0.0'
  s.license       = { :type => 'MIT' }
  s.author        = { 'Harrison Kong' => 'harrisonkong@skyroute66.com' }
  s.homepage      = 'https://github.com/harrisonkong/HKUIView'
  s.source        = { :git => 'https://github.com/harrisonkong/HKUIView.git',
                      :tag => '1.0.0' }
  s.dependency      'HKUIViewLengthCalculationBasis', '~> 1.0.0'
  s.dependency      'HKUIViewAutoCornerExtension', '~> 1.0.0'
  s.framework     = 'UIKit'
  s.source_files  = 'HKUIView/**/*.swift'
  s.swift_version = '4.0'

end
