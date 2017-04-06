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
    var placeLibrary = PlaceLibrary.sharedInstance;
    
    
    override func viewDidLoad() {
        library.getAssets();
        myArray = PlaceLibrary.sharedInstance.getPlacesArray();
        super.viewDidLoad()
       
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

        cell.textLabel?.text = myArray[indexPath.item].getName()
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

