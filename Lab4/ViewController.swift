//
//  ViewController.swift
//  Lab4
//
//  Created by mazaval4 on 3/1/17.
//  Copyright © 2017 mazaval4. All rights reserved.
//export JAVA_HOME=$(/usr/libexec/java_home)

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource{

    
    var urlString:String = "";
    var array =  ["School","Travel","Hike"]
    var intPassed = Double()
    @IBOutlet weak var pickerView: UIPickerView!
    static var stringPassed = ""
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject]  {
            self.urlString = ((dict["ServerURLString"]) as?  String!)!
            NSLog("The default urlString from info.plist is \(self.urlString)")
        }else{
            NSLog("error getting urlString from info.plist")
        }
        

        self.callGetNPopulatUIFields()
        
        elevation.keyboardType = UIKeyboardType.numberPad;
        latitude.keyboardType = UIKeyboardType.numberPad;
        longitude.keyboardType = UIKeyboardType.numberPad;
        
        
    }
    
    
    func callGetNPopulatUIFields(){
        let aConnect:PlacesStub = PlacesStub(urlString: urlString)
        let resGet:Bool = aConnect.get(name: ViewController.stringPassed, callback: { (res: String, err: String?) -> Void in
            if err != nil {
                NSLog(err!)
            }else{
                NSLog(res)
                if let data: Data = res.data(using: String.Encoding.utf8){
                    do{
                        let dict = try JSONSerialization.jsonObject(with: data,options:.mutableContainers) as?[String:AnyObject]
                        let aDict:[String:AnyObject] = (dict!["result"] as? [String:AnyObject])!
                        let aPlace:PlaceDescription = PlaceDescription(dict: aDict)
                        self.desc.text = aPlace.description
                        self.name.text = aPlace.name
                        self.addressTitle.text = aPlace.addressTitle
                        self.addressStreet.text = aPlace.addressStreet
                        self.elevation.text = String(aPlace.elevation)
                        self.latitude.text = String(aPlace.latitude)
                        self.longitude.text = String(aPlace.longitude)
                        self.image.text = aPlace.image
                        let tempe = aPlace.category
                        
                        if(tempe == "School"){
                            self.myPicker.selectRow(0, inComponent: 0, animated: true)
                        }
                        else if(tempe == "Travel"){
                            self.myPicker.selectRow(1, inComponent: 0, animated: true)
                        }
                        else{
                            self.myPicker.selectRow(2, inComponent: 0, animated: true)
                        }

                    } catch {
                        NSLog("unable to convert to dictionary")
                    }
                }
            }
        })
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Places", message:
            "Place Removed!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: backAction))
        self.present(alertController, animated: true, completion: nil)
        self.removePlace()
        
        
        }
        
    
    
    @IBAction func saveButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Places", message:
            "Place Saved!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        let temp1 = PlaceDescription(addressTitle: addressTitle.text!,addressStreet: addressStreet.text!,elevation: Double(elevation.text!)!, latitude: Double(latitude.text!)!,longitude:
            Double(longitude.text!)!,name: name.text!,image: image.text!,description: desc.text!,category: placeLibary.getCategorySelected())
        self.removePlace()
        self.addPlace(temp1)
        
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
    
    
    func removePlace() {
        let aConnect:PlacesStub = PlacesStub(urlString: urlString)
        let resGet:Bool = aConnect.remove(placeName: ViewController.stringPassed, callback: { (res: String, err: String?) -> Void in
            if err != nil {
                NSLog(err!)
            }else{
                NSLog(res)
                
            }
        })
    }
    
    
    func addPlace(_ place:PlaceDescription) {
        let aConnect:PlacesStub = PlacesStub(urlString: urlString)
        let resultNames:Bool = aConnect.add(placeDescription: place,callback: { (res: String, err: String?) -> Void in
            if err != nil {
                NSLog(err!)
            }else{
                NSLog(res)
                
                
            }
        })
    }
    
    func backAction(action: UIAlertAction){
        //print("Back Button Clicked")
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

