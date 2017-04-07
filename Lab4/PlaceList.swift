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
    var urlString = "";
    
    
    
    override func viewDidLoad() {
        library.getAssets();
        myArray = PlaceLibrary.sharedInstance.getPlacesArray();
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject]  {
            self.urlString = ((dict["ServerURLString"]) as?  String!)!
            NSLog("The default urlString from info.plist is \(self.urlString)")
        }else{
            NSLog("error getting urlString from info.plist")
        }
        self.callGetNamesNUpdateStudentsPicker(urlString)
        
    }
    func callGetNamesNUpdateStudentsPicker(_ urlString:String) {
        let aConnect:PlacesStub = PlacesStub(urlString: urlString)
        let resultNames:Bool = aConnect.getNames(callback: { (res: String, err: String?) -> Void in
            if err != nil {
                NSLog(err!)
            }else{
//                NSLog(res)
                if let data: Data = res.data(using: String.Encoding.utf8){
                    do{
                        let dict = try JSONSerialization.jsonObject(with: data,options:.mutableContainers) as?[String:AnyObject]
                        self.places = (dict!["result"] as? [String])!
                        self.places = Array(self.places).sorted()
                        self.tableView.reloadData();
//                        for ob in self.places{
//                            NSLog(ob)
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
//        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath)
        cell.textLabel?.text = self.places[indexPath.item]
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedItem = indexPath
        ViewController.stringPassed = self.places[selectedItem.row]
        placeLibrary.setRowClicked(row: selectedItem.row);
        
    }
    
    
    
    
    
}

