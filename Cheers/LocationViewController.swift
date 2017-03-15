//
//  LocationViewController.swift
//  Cheers
//
//  Created by Minna Xiao on 3/10/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func goToGroupPage(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let snapContainer = appDelegate.window?.rootViewController as! SnapContainerViewController
        let groupViewOffset = snapContainer.middleVertScrollVc.view.frame.origin
        snapContainer.scrollView.setContentOffset(groupViewOffset, animated: false)
    }
    
    // Properties
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    let initialLocation = CLLocation(latitude: 37.445158, longitude: -122.163913)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationAccess()
        centerMapOnLocation(location: initialLocation)
        addAnnotations()

        // Do any additional setup after loading the view.
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
        case .denied, .restricted:
            print("location access denied")
        default:
            //locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addAnnotations() {
        let coord = CLLocationCoordinate2D(latitude: 37.445158, longitude: -122.163913)
        let emily = DrinkingBuddy(name: "Emily", status: DrinkingBuddy.Status.dangerZone, title: nil, subtitle: "The Patio", coordinate: coord, phone: "4085945805", image: "em-bitmoji-shadow")
        
        mapView?.delegate = self
        mapView?.addAnnotations([emily])
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        } else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            annotationView.canShowCallout = true
            
            // will need to fix this
            
            let pinImage = UIImage(named: "emily1")
            let aspectRatio = pinImage!.size.width / pinImage!.size.height
            let aspectHeight = 50.0 / aspectRatio
            let size = CGSize(width: 50, height: aspectHeight)
            UIGraphicsBeginImageContext(size)
            pinImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            annotationView.image = resizedImage
            return annotationView
        }
    }
}
