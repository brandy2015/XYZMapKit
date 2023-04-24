
import UIKit
import RxSwift
import RxCocoa

import MapKit
import SoHow

class VC_XYZMapKit: UIViewController {

    var disposeBag              = DisposeBag()

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
        guard let LocationManagerX = self.LocationManagerX else{return}
        LocationManagerX.startRequestLocation()
        Observable.zip(LocationManagerX.GPS_Current,LocationManagerX.CLPlacemark_Current).subscribe { [weak self] event  in
            guard let self = self else{return}

            guard let eventPoint = event.element,let GPS1 = eventPoint.0, let placeMark = eventPoint.1 else{return}
                let markAnnotation = XYZMKPointAnnotation(coordinate: GPS1, placeMark: placeMark)
                self.View_Map.RemoveAllAnnotation()
                self.View_Map.addAnnotation(markAnnotation.objectAnnotation)
                self.View_Map.centerToLocation(GPS1.CLLocationx)
                self.LocationManagerX?.Stop()

        }.disposed(by: self.disposeBag)
    }
}
