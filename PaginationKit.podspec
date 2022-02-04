Pod::Spec.new do |s|
    s.name = "PaginationKit"
    s.version = "2.0.0"
    s.summary = "PaginationKit provides logic to paginate through a list."
    s.author = "Lukas Würzburger"
    s.license = { :type => "MIT" }
    s.homepage = "https://github.com/lukaswuerzburger/PaginationKit"
    s.platform = :ios
    s.source = { :git => "https://github.com/lukaswuerzburger/PaginationKit.git", :tag => "2.0.0" }
    s.source_files = "PaginationKit/Sources/*.swift"
    s.ios.deployment_target = "10.0"
    s.ios.frameworks = 'Foundation', 'UIKit'
    s.requires_arc = true
    s.swift_version = "5.0"
end
