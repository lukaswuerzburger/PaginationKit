Pod::Spec.new do |s|
    s.name = "PaginationController"
    s.version = "1.0.0"
    s.summary = "PaginationController provides logic to paginate through an API."
    s.author = "Lukas Würzburger"
    s.license = { :type => "MIT" }
    s.homepage = "https://github.com/lukaswuerzburger/PaginationController"
    s.platform = :ios
    s.source = { :git => "https://github.com/lukaswuerzburger/PaginationController.git", :tag => "1.0.0" }
    s.source_files = "PaginationController/Sources/*.swift"
    s.ios.deployment_target = "10.0"
    s.ios.frameworks = 'Foundation', 'UIKit'
    s.requires_arc = true
    s.swift_version = "5.0"
end
