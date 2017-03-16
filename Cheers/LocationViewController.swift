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
        snapContainer.scrollView.setContentOffset(groupViewOffset, animated: true)
    }
    
    // Properties
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 500
    let initialLocation = CLLocation(latitude: 37.789819, longitude: -122.420716)
    
    let friends = DrinkingBuddy.getFriends()
    
    //let noLocation = CLLocationCoordinate2D()
    var viewRegion: MKCoordinateRegion?
    
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
        self.viewRegion = coordinateRegion
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addAnnotations() {
        mapView?.delegate = self
        mapView?.addAnnotations(friends)
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
            let name = (annotation.title!)!
            var pinImage: UIImage?
            if (name == "shubha" || name == "nick" || name == "raven") {
                pinImage = UIImage(named: "me-pin")
            } else {
                let pinName = name + "-pin"
                pinImage = UIImage(named: pinName)

            }
            annotationView.image = pinImage
            return annotationView
        }
    }
}
