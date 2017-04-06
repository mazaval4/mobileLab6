//
//  ViewController.swift
//  Lab4
//
//  Created by mazaval4 on 3/1/17.
//  Copyright © 2017 mazaval4. All rights reserved.
//

import UIKit

class PlaceList: UITableViewController{
    
    var library: PlaceLibrary = PlaceLibrary();
    var myArray: Array<PlaceDescription> = Array();
    var places:[String]=[String]()
    var placeLibrary = PlaceLibrary.sharedInstance;
    let urlString:String = "http://127.0.0.1:9090";
    
    
    override func viewDidLoad() {
        library.getAssets();
        myArray = PlaceLibrary.sharedInstance.getPlacesArray();
        super.viewDidLoad()
       self.callGetNamesNUpdateStudentsPicker()
    }
    
    func callGetNamesNUpdateStudentsPicker() {
        let aConnect:PlacesStub = PlacesStub(urlString: urlString)
        let resultNames:Bool = aConnect.getNames(callback: { (res: String, err: String?) -> Void in
            if err != nil {
                NSLog(err!)
            }else{
                NSLog(res)
                if let data: Data = res.data(using: String.Encoding.utf8){
                    do{
                        let dict = try JSONSerialization.jsonObject(with: data,options:.mutableContainers) as?[String:AnyObject]
                        self.places = (dict!["result"] as? [String])!
                        //change these to reflect json file
                        self.places = Array(self.places).sorted()
//                        self.studentPicker.reloadAllComponents()
//                        if self.students.count > 0 {
//                            self.callGetNPopulatUIFields(self.students[0])
//
//                        }
                    } catch {
                        print("unable to convert to dictionary")
                    }
                }
                
            }
        })  // end of method call to getNames
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myArray = PlaceLibrary.sharedInstance.getPlacesArray();
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
//        print(myarray[indexPath.item].getName())

//        cell.textLabel?.text = myArray[indexPath.item].getName()
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedItem = indexPath
        placeLibrary.setRowClicked(row: selectedItem.row);
        
    }
    
    
    
    
    
}

