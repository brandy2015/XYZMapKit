  
import UIKit
import RxSwift
import RxCocoa

import MapKit
import SoHow

import RxCoreLocation

class VC_XYZCoreLocation: UIViewController {
    
    var View_Map           : MKMapView!       { return self.view.viewWithTag(1110001)     as? MKMapView          }
    
    var manager :CLLocationManager!
    
    var disposeBag              = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.manager = CLLocationManager()
        
        /// Setup CLLocationManager
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
        
        self.manager.rx
            .placemark
            .subscribe(onNext: { placemark in
                
                print("placemark",placemark)
                print("placemarkname",placemark.name)
                
                
                
                print("chinese",placemark.ChinesPlaceAddress)
                print("chinese short",placemark.ChinesShortPlaceAddress)
                
                
                print("name: \(placemark.name)")
                print("isoCountryCode: \(placemark.isoCountryCode)")
                print("country: \(placemark.country)")
                print("postalCode: \(placemark.postalCode)")
                print("locality: \(placemark.locality)")
                print("subLocality: \(placemark.subLocality)")
                
                
                guard let GPS1 = placemark.location?.coordinate   else{return}
                let markAnnotation = XYZMKPointAnnotation(coordinate: GPS1, placeMark: placemark)
                self.View_Map.RemoveAllAnnotation()
                self.View_Map.addAnnotation(markAnnotation.objectAnnotation)
                if let anno = markAnnotation.objectAnnotation{
                    self.View_Map.selectedAnnotations = [anno]
                }
                
                self.View_Map.centerToLocation(GPS1.CLLocationx)
                
            })
            .disposed(by: disposeBag)
        
        
        
        ///Subscribing for a single location events
//           manager.rx
//           .location
//           .subscribe(onNext: { location in
//               guard let location = location else { return }
//               print("altitude: \(location.altitude)")
//               print("latitude: \(location.coordinate.latitude)")
//               print("longitude: \(location.coordinate.longitude)")
//           })
//           .disposed(by: disposeBag)
//
//           ///Subscribing for an array of location events
//           manager.rx
//           .didUpdateLocations
//           .subscribe(onNext: { _, locations in
//               guard !locations.isEmpty,
//                   let currentLocation = locations.last else { return }
//                   print("altitude: \(currentLocation.altitude)")
//                   print("latitude: \(currentLocation.coordinate.latitude)")
//                   print("longitude: \(currentLocation.coordinate.longitude)")
//           })
//           .disposed(by: disposeBag)
        
        
        
        manager.rx
          .didChangeAuthorization
          .subscribe(onNext: {_, status in
              switch status {
              case .denied:
                  print("Authorization denied")
              case .notDetermined:
                  print("Authorization: not determined")
              case .restricted:
                  print("Authorization: restricted")
              case .authorizedAlways, .authorizedWhenInUse:
                  print("All good fire request")
              @unknown default:
                  print("xxx")
              }
          })
          .disposed(by: disposeBag)
        
    }
    
}
