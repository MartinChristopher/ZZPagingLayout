Pod::Spec.new do |s|
  s.name             = 'ZZPagingLayout'
  s.version          = '0.0.1'
  s.summary          = 'A short description of ZZPagingLayout.'
  s.homepage         = 'https://github.com/Ramsey/ZZPagingLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { "Ramsey" => "1264137205@gmail.com" }
  s.source           = { :git => 'https://github.com/Ramsey/ZZPagingLayout.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.swift_version = '5.0'
  s.ios.deployment_target = '11.0'
  
  s.source_files = 'Sources/**/*.{swift}'
  # s.resources = "Sources/**/*.{bundle,strings,xcassets}"
  
  # s.dependency "RxSwift", "6.5.0"
  # s.dependency "RxCocoa", "6.5.0"
  # s.dependency "NSObject+Rx", "5.2.2"
end
