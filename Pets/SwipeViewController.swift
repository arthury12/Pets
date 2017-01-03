//
//  ViewController.swift
//  Pets
//
//  Created by Arthur Yu on 11/20/16.
//  Copyright © 2016 Arthur Yu. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class ViewController: UIViewController {

    @IBOutlet weak var retrieveData: UIButton!
    var pet: Pet?
    var petDB = [Pet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        getPet(location: "90069")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func button1Clicked() {
        getPet(location: "90069")
    }
    
    /* API Manager */
    
    let baseURL = "http://api.petfinder.com/"
    let key = "7c77a4361a1a1ada2b67a1300b31e6d3"
    let defaultLocation = "90069"
    let jsonFormat = "&format=json"
    
    /* Endpoints */
    let petFind = "pet.find?"
    
    
    func getPet(location: String?) {
        let currLocation = location ?? defaultLocation
        let route = baseURL + petFind + "key=" + key + "&location=" + currLocation + jsonFormat
        print("route: \(route)")

        makeHTTPGetRequest(path: route)
    }
    
    func makeHTTPGetRequest(path:String) -> Void {
        let url = URL(string: path)
        var request = URLRequest(url: NSURL(string: path) as! URL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    if let dict = json as? [String: AnyObject] {
                        if let pets = dict["petfinder"] as? [String: AnyObject] {
                            if let pet = pets["pets"] as? [String: AnyObject] { //each pets obj is an array
                                if let petArray = pet["pet"] as? [AnyObject] {
                                    for eachPet in petArray {
                                        var currPet = Pet()
                                        /* name */
                                        if let nameDict = eachPet["name"] as? [String: AnyObject] {
                                            currPet.name = nameDict.values.first as? String
                                        }
                                        /* type */
                                        if let typeDict = eachPet["animal"] as? [String: AnyObject] {
                                            currPet.type = typeDict.values.first as? String
                                        }
                                        /* breeds */
                                        if let breedsDict = eachPet["breeds"] as? [String: AnyObject] {
                                            if let breedArr = breedsDict["breed"] as? [AnyObject] {
                                                for eachBreed in breedArr {
                                                    if (currPet.breed != nil) {
                                                        currPet.breed?.append(", ")
                                                    }
                                                    currPet.breed?.append(eachBreed.value)
                                                }
                                            } else {
                                                if let breedDict = breedsDict["breed"] as? [String: AnyObject] {
                                                    currPet.breed = breedDict.values.first as? String
                                                }
                                            }
                                        }
                                        /* sex */
                                        if let sexDict = eachPet["sex"] as? [String: AnyObject] {
                                            currPet.sex = sexDict.values.first as? String
                                        }
                                        /* age */
                                        if let ageDict = eachPet["age"] as? [String: AnyObject] {
                                            currPet.age = ageDict.values.first as? String
                                        }
                                        /* size */
                                        if let sizeDict = eachPet["size"] as? [String: AnyObject] {
                                            currPet.size = sizeDict.values.first as? String
                                        }
                                        /* description */
                                        if let descriptionDict = eachPet["description"] as? [String: AnyObject] {
                                            currPet.description = descriptionDict.values.first as? String
                                        }

                                        if let contact = eachPet["contact"] as? [String: AnyObject] {
                                            /* phone */
                                            if let phone = contact["phone"] as? [String: AnyObject] {
                                                currPet.phone = phone.values.first as? String
                                            }
                                            /* email */
                                            if let email = contact["email"] as? [String: AnyObject] {
                                                currPet.email = email.values.first as? String
                                            }
                                            /* address */
                                            if let address = contact["address1"] as? [String: AnyObject] {
                                                if (address.values.first != nil) {
                                                    currPet.address = address.values.first as? String
                                                    print(address.values.first)
                                                    print(currPet.address)
                                                    currPet.address!.append(", ")
                                                }
                                            }
                                            if let city = contact["city"] as? [String: AnyObject] {
                                                if (city.values.first != nil && currPet.address != nil) {
                                                    currPet.address!.append((city.values.first as? String)!)
                                                    print(city.values.first)
                                                    print(currPet.address)
                                                    currPet.address!.append(", ")
                                                }
                                            }
                                            if let state = contact["state"] as? [String: AnyObject] {
                                                if (state.values.first != nil && currPet.address != nil) {
                                                    currPet.address!.append((state.values.first as? String)!)
                                                    print(state.values.first)
                                                    print(currPet.address)
                                                    currPet.address!.append(" ")
                                                }
                                            }
                                            if let zip = contact["zip"] as? [String: AnyObject] {
                                                if (zip.values.first != nil && currPet.address != nil) {
                                                    currPet.address!.append((zip.values.first as? String)!)
                                                }
                                            }
                                        }
                                        /* id */
                                        if let id = eachPet["id"] as? [String: AnyObject] {
                                            currPet.id = id.values.first as? String
                                        }
                                        /* photos */
                                        if let media = eachPet["media"] as? [String: AnyObject] {
                                            if let photos = media["photos"] as? [String: AnyObject] {
                                                if let photo = photos["photo"] as? [AnyObject] {
                                                    for eachPhoto in photo {
                                                        if (eachPhoto["@size"] as? String == "x") {
                                                            currPet.imageURL.append(eachPhoto["$t"] as! String)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        
                                        self.petDB.append(currPet)
                                    }
                                }
                            }
                        }
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
