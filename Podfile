# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'swift_algorithms' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for swift_algorithms
  pod 'MarkdownView', :git => 'https://github.com/thexande/MarkdownView.git', :branch => 'master'
  pod 'Anchorage'
  pod 'lottie-ios'
  pod 'Hero'
  pod 'DeviceKit'
  pod 'Cache'
  
  target 'swift_algorithmsTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'swift_algorithmsUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        # Fix bundle targets' 'Signing Certificate' to 'Sign to Run Locally'
        if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
            target.build_configurations.each do |config|
                config.build_settings['CODE_SIGN_IDENTITY[sdk=macosx*]'] = '-'
            end
        end
    end
end
