//
//  ViewController.swift
//  closest-beacon
//
//  Created by Kenneth Harvey on 4/23/16.
//  Copyright © 2016 Richard Harvey. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "15E21338-718E-40DA-9936-2FAA032D34F5")!, identifier: "Beacons")
    let colors = [
        1: UIColor(red:  84/255, green:  77/255, blue: 160/255, alpha: 1),
        2: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1),
        3: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self;
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        if (knownBeacons.count > 0 ) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            self.view.backgroundColor = self.colors[closestBeacon.minor.integerValue]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

