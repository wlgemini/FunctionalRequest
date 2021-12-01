Pod::Spec.new do |s|
  s.name             = 'FunctionalRequest'
  s.version          = '5.4.1'
  s.summary          = 'Make request like a function call.'
  s.homepage         = 'https://github.com/wlgemini/FunctionalRequest.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wlgemini' => 'wangluguang@live.com' }
  s.source           = { :git => 'https://github.com/wlgemini/FunctionalRequest.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.swift_versions = ['5.1', '5.2', '5.3']

  s.source_files = 'Source/**/*.swift'

  s.dependency 'Alamofire', '~> 5.4'
end
