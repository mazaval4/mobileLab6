//
//  ViewController.swift
//  Lab4
//
//  Created by mazaval4 on 3/1/17.
//  Copyright © 2017 mazaval4. All rights reserved.
//export JAVA_HOME=$(/usr/libexec/java_home)

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource{

    let urlString:String = "http://127.0.0.1:9090"
    
    var array =  ["School","Travel","Hike"]
    var intPassed = Double()
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var addressTitle: UITextField!
    @IBOutlet weak var addressStreet: UITextField!
    @IBOutlet weak var elevation: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var image: UITextField!
    @IBOutlet weak var myPicker: UIPickerView!
    
    var placeLibary = PlaceLibrary.sharedInstance;
    var myarray = PlaceLibrary.sharedInstance.getPlacesArray();
    
    @IBAction func deleteButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Places", message:
            "Place Removed!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
        let itemIndex = placeLibary.getRowClicked();
        placeLibary.deleteArrayElement(index: itemIndex);
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Places", message:
            "Place Saved!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
        
        let temp1 = PlaceDescription(addressTitle: addressTitle.text!,addressStreet: addressStreet.text!,elevation: Double(elevation.text!)!, latitude: Double(latitude.text!)!,longitude: Double(longitude.text!)!,
                                     name: name.text!,image: image.text!,description: desc.text!,category: placeLibary.getCategorySelected())
        let itemIndex = placeLibary.getRowClicked();
        placeLibary.deleteArrayElement(index: itemIndex);
        placeLibary.addAtIndex(index: itemIndex, place: temp1);
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        desc.text = myarray[placeLibary.getRowClicked()].getDescription()
        name.text = myarray[placeLibary.getRowClicked()].getName()
        addressTitle.text = myarray[placeLibary.getRowClicked()].getAddressTitle()
        addressStreet.text = myarray[placeLibary.getRowClicked()].getAddressStreet()
        elevation.text = String(myarray[placeLibary.getRowClicked()].getElevation())
        latitude.text = String(myarray[placeLibary.getRowClicked()].getLatitude())
        longitude.text = String(myarray[placeLibary.getRowClicked()].getLongitude())
        image.text = myarray[placeLibary.getRowClicked()].getImage()
        let tempe = myarray[placeLibary.getRowClicked()].getCategory();
        
        if(tempe == "School"){
            myPicker.selectRow(0, inComponent: 0, animated: true)
        }
        else if(tempe == "Travel"){
            myPicker.selectRow(1, inComponent: 0, animated: true)
        }
        else{
            myPicker.selectRow(2, inComponent: 0, animated: true)
        }
        
        
        elevation.keyboardType = UIKeyboardType.numberPad;
        latitude.keyboardType = UIKeyboardType.numberPad;
        longitude.keyboardType = UIKeyboardType.numberPad;
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        placeLibary.setCategorySelected(cat: array[row]);
        return array[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count;
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1;
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

