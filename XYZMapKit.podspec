Pod::Spec.new do |s|
  # 基本信息
  s.name         = "XYZMapKit"                      # Pod 名称
  s.version      = "0.1.2"                          # 当前版本
  s.summary      = "A lightweight map toolkit with RxSwift integration."  # 简短描述
  s.description  = <<-DESC
    XYZMapKit 是一个基于 RxSwift 的地图工具包，提供高效的定位、地图显示和事件响应封装功能，
    支持多种地图服务扩展和自定义功能。
  DESC
  s.homepage     = "https://github.com/brandy2015/XYZMapKit"  # 项目主页
  s.license      = { :type => "MIT", :file => "LICENSE" }       # 许可证
  s.author       = { "Brando" => "zhangqianbrandy2012@gmail.com" }  # 作者信息
  s.source       = { :git => "https://github.com/brandy2015/XYZMapKit.git", :tag => "0.1.2" }  # Git 地址

  # 平台支持
  s.ios.deployment_target = "14.0"                 # 支持的最低 iOS 系统版本
  s.swift_version = "5.0"                          # Swift 版本

  # 源代码
  s.source_files = "XYZMapKit/XYZLocationKit/*"        # 包含的源码路径
  
  
  #s.resource_bundles = {                          # 资源文件（如果有图片或其他资源文件）
   # 'XYZMapKitResources' => ['XYZMapKit/Assets/**/*']
 # }


    
  
  # 依赖项
  s.dependency 'RxSwift'             # RxSwift 集成
  s.dependency 'RxCocoa'             # RxCocoa 集成
  s.dependency 'Alamofire'           # 网络请求支持
  s.dependency 'RxCoreLocation'      # Rx 封装的 CoreLocation 支持
  s.dependency 'RxMKMapView'         # Rx 封装的 MKMapView 支持
  s.dependency 'XYZResponse'         # 触感反馈
  s.dependency 'SoHow'
  
  # ARC 支持
  #s.requires_arc = true                           # 使用 ARC
end
