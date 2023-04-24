 
import Foundation
import UIKit
import MapKit

class XYZMKPointAnnotation{
    
    var objectAnnotation:MKPointAnnotation!
    
   
    init(coordinate:CLLocationCoordinate2D,placeMark:CLPlacemark){
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = coordinate//设置注释对象的地理位置
        
        objectAnnotation.title      = placeMark.ChinesShortPlaceAddress//设置注释对象的标题内容
        objectAnnotation.subtitle   = placeMark.ChinesPlaceAddress //设置注释对象的字标题内容
        
        self.objectAnnotation = objectAnnotation
    }
        
}

public extension MKMapView{
    func RemoveAllAnnotation(){
        self.removeAnnotations(self.annotations)
    }
}
