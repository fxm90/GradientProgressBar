Pod::Spec.new do |s|
  s.name = 'GradientProgressBar'
  s.version = '1.0.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'A gradient progress bar (UIProgressView).'
  s.description = 'A gradient progress bar (UIProgressView). Inspired by http://www.cssscript.com/ios-style-gradient-progress-bar-with-pure-css-css3/'
  s.homepage = 'https://github.com/fxm90/GradientProgressBar'
  s.screenshot  = 'http://felix.hamburg/files/github/gradient-progress-bar/screen.png'
  s.author = { 'Felix Mau' => 'contact@felix.hamburg' }

  s.source       = { :git => 'https://github.com/fxm90/GradientProgressBar.git', :tag => '1.0.0' }
  s.source_files = 'GradientProgressBar', 'GradientProgressBar/**/*.swift'

  s.platform     = :ios, '9.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }
end