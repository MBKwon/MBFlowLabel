Pod::Spec.new do |s|  
  s.name 	= 'MBFlowLabel'
  s.version = '0.9'
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.license = 'Naver License'
  s.homepage = 'https://oss.navercorp.com/iOS/NCVoiceAnimation'
  s.authors = {'MB Kyle' => 'mb.kyle@navercorp.com'}
  s.summary  = 'GreenDot VUI SDK'
  s.source   = {:git => 'https://oss.navercorp.com/iOS/NCVoiceAnimation', :tag => '2.0.1'}  
  s.source_files = 'NCSoundAnimation/NCSoundAnimation/Sources/*.swift'
  s.resources = 'NCSoundAnimation/NCSoundAnimation/Lotties/*.json'
  s.dependency 'lottie-ios', '~>2.5'
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
end
