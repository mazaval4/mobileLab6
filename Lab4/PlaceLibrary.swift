//
//  PlaceLibrary.swift
//  Lab4
//
//  Created by mazaval4 on 3/1/17.
//  Copyright © 2017 mazaval4. All rights reserved.
//

import Foundation
import UIKit

class PlaceLibrary{
    var addressTitle: String = ""
    var addressStreet: String = ""
    var elevation: Double = 0
    var latitude: Double = 0
    var longitude: Double = 0
    var name: String = ""
    var image: String = ""
    var desc: String = ""
    var category: String = ""
    var places: Array<PlaceDescription> = Array();
    var row: Int = 0;
    var catSelected: String = ""
    
    
    
    struct Static {
        static let instance = PlaceLibrary()
    }
    
    class var sharedInstance: PlaceLibrary {
        return Static.instance
    }
    
    func getAssets() -> Void{
        
        let asset = NSDataAsset(name: "places", bundle: Bundle.main)
        let json = try! JSONSerialization.jsonObject(with: asset!.data, options: .allowFragments)
        //        PlaceLibrary.sharedInstance
        
        let idk = try! JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        if let temp = NSString(data: idk, encoding: String.Encoding.utf8.rawValue) {
            
            if let data:Data = temp.data(using: String.Encoding.utf8.rawValue) as Data!{
                do{
                    let dict = try JSONSerialization.jsonObject(with: data, options:.mutableContainers) as! [String:Any]
                    let keys = Array(dict.keys)
                    
                    
                    for value in keys{
                        //                        print("\(dict[value]!)")
                        let idk2 = try! JSONSerialization.data(withJSONObject: (dict[value]!), options: JSONSerialization.WritingOptions.prettyPrinted)
                        
                        if let temp2 = NSString(data: idk2, encoding: String.Encoding.utf8.rawValue){
                            if let data2:Data = temp2.data(using: String.Encoding.utf8.rawValue) as Data!{
                                let dict2 = try JSONSerialization.jsonObject(with: data2, options:.mutableContainers) as! [String:Any]
                                self.addressTitle = (dict2["address-title"] as? String)!
                                self.addressStreet = (dict2["address-street"] as? String)!
                                self.elevation = (dict2["elevation"] as? Double)!
                                self.latitude = (dict2["latitude"] as? Double)!
                                self.longitude = (dict2["longitude"] as? Double)!
                                self.name = (dict2["name"] as? String)!
                                self.image = (dict2["image"] as? String)!
                                self.desc = (dict2["description"] as? String)!
                                self.category = (dict2["category"] as? String)!
                                
                                let placeDescription = PlaceDescription(addressTitle: addressTitle,addressStreet: addressStreet,elevation: elevation,latitude: latitude,longitude: longitude,name: name,image: image,description: desc,category: category);
                                
                                PlaceLibrary.sharedInstance.add(place: placeDescription);
                                
                                
                            }
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                } catch {
                    print("unable to convert Json to a dictionary")
                    
                }
            }
        }
    }
    
    
    
    func add(place:PlaceDescription) -> Void {
        places.append(place);
    }
    
    func getPlacesArray() -> Array<PlaceDescription> {
        return places;
    }
    func deleteArrayElement(index:Int) ->Void{
        print(index)
        places.remove(at: index);
    }
    
    func addAtIndex(index:Int, place:PlaceDescription) ->Void{
        places.insert(place, at: index);
    }
    
    func setRowClicked(row:Int) -> Void {
        self.row = row;
    }
    
    func getRowClicked() -> Int {
        return row;
    }
    
    func setCategorySelected(cat:String) -> Void {
        self.catSelected = cat;
    }
    
    func getCategorySelected() -> String {
        return catSelected;
    }
}





