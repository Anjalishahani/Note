# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'SecretNoteApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
pod 'EncryptedCoreData', :git => 'https://github.com/project-imas/encrypted-core-data.git' 
  # Pods for SecretNoteApp

  target 'SecretNoteAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SecretNoteAppUITests' do
    use_frameworks!
    inherit! :search_paths
    # Pods for testing
    pod 'EncryptedCoreData', :git => 'https://github.com/project-imas/encrypted-core-data.git' 
  end

end
