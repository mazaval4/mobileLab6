//
//  AddPlace.swift
//  Lab4
//
//  Created by mazaval4 on 3/3/17.
//  Copyright © 2017 mazaval4. All rights reserved.
//

import Foundation
import UIKit


class AddPlace: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource{

    var array =  ["School","Travel","Hike"]
    var placeLibary = PlaceLibrary.sharedInstance;
    
    @IBOutlet weak var desc: UITextField!
    
    @IBOutlet weak var addressTitle: UITextField!
    
    @IBOutlet weak var addressStreet: UITextField!
    
    
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var elevation: UITextField!
    
    @IBOutlet weak var latitude: UITextField!
    
    @IBOutlet weak var longitude: UITextField!
    
    @IBOutlet weak var image: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    
    @IBAction func savePlaceButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Places", message:
            "Place Added!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
        
        let temp1 = PlaceDescription(addressTitle: addressTitle.text!,addressStreet: addressStreet.text!,elevation: Double(elevation.text!)!, latitude: Double(latitude.text!)!,longitude: Double(longitude.text!)!,name: name.text!,image: image.text!,description: desc.text!,category: placeLibary.getCategorySelected())
        
        placeLibary.addAtIndex(index: 0, place: temp1);
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        placeLibary.setCategorySelected(cat: array[row]);
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1;
    }
    
}

