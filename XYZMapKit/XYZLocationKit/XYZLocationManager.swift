 
import CoreLocation

import RxCocoa
import RxSwift

public class XYZLocationManager: NSObject{
    // 单例方法
    static let sharedInstance: XYZLocationManager = {
        let instance = XYZLocationManager()
        // setup code
        return instance
    }()
    var locationManager        : CLLocationManager?
    var GPS_Current            : BehaviorRelay<CLLocationCoordinate2D?> = BehaviorRelay(value:nil)
    var CLPlacemark_Current    : BehaviorRelay<CLPlacemark?>            = BehaviorRelay(value:nil)
     
    var GetTheGPS:((_ GPS:  CLLocationCoordinate2D)->())? = nil
    public var coordinate: CLLocationCoordinate2D? = nil
    
    // 调用此方法初始化定位功能
    public func initialize(){
        if (self.locationManager == nil) {
           self.locationManager = CLLocationManager()
           // 设置代理
           self.locationManager?.delegate = self
           // 设置定位精度
           locationManager?.desiredAccuracy = kCLLocationAccuracyBest
           // 设置变动幅度
           locationManager?.distanceFilter = 5.0
            // 允许后台持续使用定位功能
           locationManager?.allowsBackgroundLocationUpdates = true
            // 进入后台后不停止
           self.locationManager?.pausesLocationUpdatesAutomatically = false
        }
    }
    
    public func Stop(){
        self.locationManager?.stopUpdatingLocation()
        print("停止了")
//        self.locationManager = nil
    }
    // 开始尝试获取定位
    public func startRequestLocation() {
        self.locationManager?.requestWhenInUseAuthorization()
        if (self.locationManager != nil) && (CLLocationManager.authorizationStatus() == .denied) {
            // 没有获取到权限，再次请求授权
            self.locationManager?.requestWhenInUseAuthorization()
        } else {
            locationManager?.startUpdatingLocation()
        }
    }
}
// 实现代理
extension XYZLocationManager: CLLocationManagerDelegate {
    // 代理方法，位置更新时回调
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location   = locations.last ?? CLLocation.init()
        let coordinate = location.coordinate.transToGCJ
        //        let latitude   = coordinate.latitude;
        //        let longitude  = coordinate.longitude;
        // TODO... 实现自己的业务
        // 注意，这里获取到的是标准坐标。WGS-84标准
        //        self.coordinate = coordinate
        self.GPS_Current.accept(coordinate)
        //        self.GetTheGPS?(coordinate)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(coordinate.CLLocationx, completionHandler: { [weak self] placemarks, error in
            guard let self = self else{return}
            if error == nil && (placemarks?.count ?? 0) > 0 {
                guard let placeMark = placemarks?.last else{return}
                
                self.CLPlacemark_Current.accept(placeMark)
            }
        })
    }
    
    // 代理方法，当定位授权更新时回调
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // CLAuthorizationStatus
        // .notDetermined   用户还没有选择授权
        // .restricted   应用没有授权用户定位
        // .denied 用户禁止定位
        // .authorizedAlways 用户授权一直可以获取定位
        // .authorizedWhenInUse 用户授权使用期间获取定位
        // TODO...
        if status == .notDetermined {
            self.startRequestLocation()
        } else if (status == .restricted) {
            // 受限制，尝试提示然后进入设置页面进行处理
            
        } else if (status == .denied) {
            // 被拒绝，尝试提示然后进入设置页面进行处理
            
        }
    }
    
    // 当获取定位出错时调用
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // 这里应该停止调用api
        self.locationManager?.stopUpdatingLocation()
    }
    
}

import MapKit

public extension MKMapView {
    func centerToLocation(_ location: CLLocation,regionRadius: CLLocationDistance = 100) {
        let coordinateRegion = MKCoordinateRegion( center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
public extension CLPlacemark{
    
    var ChinesShortPlaceAddress:String{
        return (self.locality ?? "") + "•" + (self.thoroughfare ?? "") + (self.subThoroughfare ?? "")
      
    }
    
    var ChinesPlaceAddress:String{
//        print(1,self)
//        print(2,self.locality)
//        print(3,self.subAdministrativeArea)
//        print(4,self.name)
//        print(5,self.addressDictionary)
        
//        print(6,self.addressDictionary.)
        
//        print(6,self.)
//
//        var dic = self.addressDictionary
//        var addressx = dic?["FormattedAddressLines"] as? NSArray
        
        let place =  (self.administrativeArea ?? "") + (self.subAdministrativeArea ?? "") + (self.locality ?? "") + (self.subLocality ?? "")
        let place2 =  (self.thoroughfare ?? "") + (self.subThoroughfare ?? "")
//        print("place",place + place2)
        
        
        
//        let addressxx = (self.addressDictionary?["FormattedAddressLines"] as? NSArray)?.firstObject as? String
//        print("addressxx",addressxx)
        return place + place2
    }
}
//func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    if let location = locations.last{
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        self.map.setRegion(region, animated: true)
//    }
//}
