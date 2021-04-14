source 'https://github.com/CocoaPods/Specs.git'
plugin 'cocoapods-binary-cache'

inhibit_all_warnings!
use_frameworks!

platform :ios, '11.0'

# Rx
pod 'RxSwift', '5.1.1', binary: true
pod 'RxCocoa', binary: true
pod 'RxDataSources', :binary => true
pod 'RxKeyboard', binary: true

# Architecture
pod 'ReactorKit', '2.1.1', binary: true
pod 'RIBs', git: 'https://github.com/uber/RIBs', tag: '0.9.2', binary: true

# DI
pod 'Pure', binary: true
pod 'Swinject', '2.7.1', binary: true
pod 'PureSwinject', binary: true

# UI
pod 'SnapKit', binary: true
pod 'ColorCompatibility', binary: true

# Convenience
pod 'Then', binary: true

def testable_target(name)
  target name do
    yield if block_given?
  end

  target "#{name}Tests" do
    pod 'Quick', binary: true
    pod 'Nimble', binary: true
    pod 'MockingKit', binary: true
  end
end

testable_target 'Dailiary'
testable_target 'DailiaryFoundation'
testable_target 'DailiaryUI'
testable_target 'DailiaryReactive'
testable_target 'DailiaryTest' do
  pod 'Quick', binary: true
  pod 'Nimble', binary: true
  pod 'MockingKit', binary: true
end

config_cocoapods_binary_cache(
  cache_repo: {
    'default' => {
      'local' => '~/.cocoapods-binary-cache/dailiary/prebuilt-frameworks'
    }
  },
  prebuild_config: 'Debug',
  prebuild_all_pods: 'true'
)

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |build_config|
      build_config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'

      if build_config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] == '8.0'
        build_config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      end
    end
  end
end

