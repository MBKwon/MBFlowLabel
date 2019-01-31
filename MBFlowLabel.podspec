Pod::Spec.new do |s|  
  s.name 	= 'MBFlowLabel'
  s.version = '0.9'
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.license = 'MIT License'
  s.homepage = 'https://github.com/MBKwon/MBFlowLabel'
  s.authors = {'MB Kyle' => 'maskkwon@gmail.com'}
  s.summary  = 'A label that is flowing a text'
  s.source   = {:git => 'https://github.com/MBKwon/MBFlowLabel', :tag => '0.9'}  
  s.source_files = 'MBFlowLabel_iOS7/MBFlowLabel/MBFlowLabelView.{h,m}'
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
end
