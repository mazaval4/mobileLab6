/*
 * Copyright 2017 Miguel Zavala,
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * Purpose: This class is for the place descriptions
 *
 * Ser423 Mobile Applications
 * see http://pooh.poly.asu.edu/Mobile
 * @author Miguel Zavala miguel.zavala@asu.edu
 *         Software Engineering, CIDSE, IAFSE, ASU Poly
 * @version February 2017
 */

import Foundation
import UIKit

class PlaceDescription
{
    open var addressTitle: String
    open var addressStreet: String
    open var elevation: Double;
    open var latitude: Double;
    open var longitude: Double;
    open var name: String;
    open var image: String
    open var description: String;
    open var category: String;
    
    
    init(addressTitle:String,addressStreet:String,elevation:Double,latitude:Double,longitude:Double,name:String,image:String,description:String, category:String)
    {
        self.addressTitle = addressTitle;
        self.addressStreet = addressStreet;
        self.elevation = elevation;
        self.latitude = latitude;
        self.longitude = longitude;
        self.name = name;
        self.image = image;
        self.description = description;
        self.category = category;
        
    }
    
    
    init (jsonStr: String){
        self.addressTitle = "";
        self.addressStreet = "";
        self.elevation = 0;
        self.latitude = 0;
        self.longitude = 0;
        self.name = "";
        self.image = "";
        self.description = "";
        self.category = "";
        
        if let data: Data = jsonStr.data(using: String.Encoding.utf8){
            do{
                //change these to reflect json file
                let dict = try JSONSerialization.jsonObject(with: data,options:.mutableContainers) as?[String:AnyObject]
                self.addressTitle = (dict!["address-title"] as? String)!
                self.addressStreet = (dict!["address-street"] as? String)!
                self.elevation = (dict!["elevation"] as? Double)!
                self.latitude = (dict!["latitude"] as? Double)!
                self.longitude = (dict!["longitude"] as? Double)!
                self.name = (dict!["name"] as? String)!
                self.image = (dict!["image"] as? String)!
                self.description = (dict!["description"] as? String)!
                self.category = (dict!["category"] as? String)!
            } catch {
                print("unable to convert to dictionary")
                
            }
        }
    }
    //change the takes to what the json file is
    init(dict: [String:Any]){
        self.addressTitle = dict["address-title"] as! String
        self.addressStreet = dict["address-street"] as! String
        self.elevation = dict["elevation"] as! Double
        self.latitude = dict["latitude"] as! Double
        self.longitude = dict["longitude"] as! Double
        self.name = dict["name"] as! String
        self.image = dict["image"] as! String
        self.description = dict["description"] as! String
        self.category = dict["category"] as! String
    }
    
    //change these to reflect json file
    func toJsonString() -> String {
        var jsonStr = "";
        let dict = ["address-title": addressTitle, "address-street": addressStreet, "elevation":elevation,"latitude":latitude,"longitude":longitude,"name":name
            ,"image":image,"description":description,"category":category] as [String : Any]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            jsonStr = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        } catch let error as NSError {
            print(error)
        }
        return jsonStr
    }
    
    //change these to reflect json file
    func toDict() -> [String:Any] {
        let dict:[String:Any] = ["address-title": addressTitle, "address-street": addressStreet, "elevation":elevation,"latitude":latitude,"longitude":longitude,"name":name
            ,"image":image,"description":description,"category":category] as [String : Any]
        return dict
    }
    
    
}
