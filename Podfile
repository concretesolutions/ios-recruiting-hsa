platform :ios, '10.0'

target 'TheMovieDB' do
  use_frameworks!

  # Pods for TheMovieDB
  pod 'Alamofire', '~> 4.8'
  pod 'AppCenter'
  pod 'DZNEmptyDataSet'
  pod 'ICSPullToRefresh', '~> 0.6'
  pod 'RxSwift', '~> 4.0'
  pod 'SDWebImage', '~> 4.0'
  pod 'SVProgressHUD'
  pod 'SwiftLint'

  target 'TheMovieDBTests' do
    inherit! :search_paths
    pod 'OHHTTPStubs/Swift'
    pod 'RxBlocking', '~> 4.0'
    pod 'RxTest', '~> 4.0'
  end

  target 'TheMovieDBUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  require 'fileutils'
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if target.name == 'ICSPullToRefresh'
        config.build_settings['SWIFT_VERSION'] = '4.1'
        else
        config.build_settings['SWIFT_VERSION'] = '4.2'
      end
      config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
    end
  end
end
