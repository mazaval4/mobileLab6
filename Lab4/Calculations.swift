//
//  Calculations.swift
//  Lab4
//
//  Created by mazaval4 on 3/3/17.
//  Copyright © 2017 mazaval4. All rights reserved.
//

import Foundation
import UIKit

class Calculations: UIViewController{
    
    var placeLibary = PlaceLibrary.sharedInstance;
    var myarray = PlaceLibrary.sharedInstance.getPlacesArray();
    
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var distance: UITextField!
    @IBOutlet weak var bearing: UITextField!
    @IBOutlet weak var elevation: UITextField!
    
    override func viewDidLoad() {
        print(placeLibary.getRowClicked())
        latitude.text = String(myarray[placeLibary.getRowClicked()].getLatitude())
        longitude.text = String(myarray[placeLibary.getRowClicked()].getLongitude())
        elevation.text = String(myarray[placeLibary.getRowClicked()].getElevation())
        super.viewDidLoad()
    }
    
    
//    private static double distance(double lat1, double lon1, double lat2, double lon2, String unit) {
//    double theta = lon1 - lon2;
//    double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
//    dist = Math.acos(dist);
//    dist = rad2deg(dist);
//    dist = dist * 60 * 1.1515;
//    if (unit == "K") {
//    dist = dist * 1.609344;
//    } else if (unit == "N") {
//    dist = dist * 0.8684;
//    }
//    
//    return (dist);
//    }
//    
//    /*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
//    /*::	This function converts decimal degrees to radians						 :*/
//    /*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
//    private static double deg2rad(double deg) {
//    return (deg * Math.PI / 180.0);
//    }
//    
//    /*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
//    /*::	This function converts radians to decimal degrees						 :*/
//    /*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
//    private static double rad2deg(double rad) {
//    return (rad * 180 / Math.PI);
//    }

}
