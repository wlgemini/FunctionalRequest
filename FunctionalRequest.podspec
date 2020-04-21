Pod::Spec.new do |s|
  s.name                    = 'FunctionalRequest'
  s.version                 = '5.1.0'
  s.license                 = 'MIT'
  s.summary                 = 'Using HTTP Networking request as a function call'
  s.homepage                = 'https://github.com/wlgemini/FunctionalRequest'
  s.author                  = { 'wlgemini' => 'wangluguang@live.com' }
  s.source                  = { :git => 'https://github.com/wlgemini/FunctionalRequest.git', :tag => s.version }
  
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'
  
  s.swift_version           = ['5.1', '5.2']
  s.source_files            = 'Source/*.swift'
  
  s.dependency              'Alamofire', '~> 5.1.0'
  
end
