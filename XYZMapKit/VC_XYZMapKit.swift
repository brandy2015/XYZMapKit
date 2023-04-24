 
import UIKit
import RxSwift
import RxCocoa

import MapKit
import SoHow

class VC_XYZMapKit: UIViewController {

    var View_Map           : MKMapView!       { return self.view.viewWithTag(1110001)     as? MKMapView          }
    
 
    var LocationManagerX:XYZLocationManager? = XYZLocationManager()
     
    deinit{
        self.LocationManagerX = nil
    }
    
     
    var placeMark: CLPlacemark!{
        didSet{  self.title = "📌定位成功"}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.LocationManagerX?.initialize()
        afterDelay(1) {
            self.GetLocation()
        }
        
    }
    
    func GetLocation(){
        self.LocationManagerX?.startRequestLocation()
        self.LocationManagerX?.GetTheGPS = { GPS1  in
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(GPS1.CLLocationx, completionHandler: {  placemarks, error in
                
                if error == nil && (placemarks?.count ?? 0) > 0 {
                    guard let placeMark = placemarks?.last else{return}
                    self.placeMark = placeMark
                    
                    let markAnnotation = XYZMKPointAnnotation(coordinate: GPS1, placeMark: placeMark)
                    
//                    let objectAnnotation = MKPointAnnotation()
//                    objectAnnotation.coordinate = GPS1//设置注释对象的地理位置
//                    objectAnnotation.title      = placeMark.ChinesShortPlaceAddress//设置注释对象的标题内容
//                    objectAnnotation.subtitle   = placeMark.ChinesPlaceAddress //设置注释对象的字标题内容
                    self.View_Map.RemoveAllAnnotation()
                    self.View_Map.addAnnotation(markAnnotation.objectAnnotation)
                    self.View_Map.centerToLocation(GPS1.CLLocationx)
                    self.LocationManagerX?.Stop()
                }
            })
        }
    }
}


public extension MKMapView{
    func RemoveAllAnnotation(){
        self.removeAnnotations(self.annotations)
    }
}

class XYZMKPointAnnotation{
    
    var objectAnnotation:MKPointAnnotation!  
    
   
    init(coordinate:CLLocationCoordinate2D,placeMark:CLPlacemark){
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = coordinate//设置注释对象的地理位置
        
        objectAnnotation.title      = placeMark.ChinesShortPlaceAddress//设置注释对象的标题内容
        objectAnnotation.subtitle   = placeMark.ChinesPlaceAddress //设置注释对象的字标题内容
        
        self.objectAnnotation = MKPointAnnotation()
    }
        
}
