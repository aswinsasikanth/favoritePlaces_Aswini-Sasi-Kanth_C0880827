//
//  ViewController.swift
//  favoritePlaces_Aswini Sasi Kanth_C0880827
//
//  Created by Aswin Sasikanth Kanduri on 2023-01-24.
//

import UIKit
import CoreData
import CoreLocation


class PlaceDetailVC: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTF: UITextField!
    
    var locationManager:CLLocationManager!
    var latitude: Double = 0.0
    var longtitute: Double = 0.0
    
    var selectedPlace : Place? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if selectedPlace != nil {
            titleTF.text = selectedPlace?.title
            descTF.text = selectedPlace?.desc

            
            latitude = selectedPlace!.latitude
            longtitute = selectedPlace!.longitude
        }
        
    }

    @IBAction func saveAction(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if (selectedPlace == nil)
        {
            let entity = NSEntityDescription.entity(forEntityName: "Place", in: context)
            let newPlace = Place(entity: entity!, insertInto: context)
            
            newPlace.id = placeList.count as NSNumber
            newPlace.title = titleTF.text
            newPlace.desc = descTF.text
            
            do {
                try context.save()
                placeList.append(newPlace)
                navigationController?.popViewController(animated: true)
            }
            catch {
                print("Contex has error")
            }
        }
     
        else{
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
            
            do{
                
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let place = result as! Place
                    
                    if (place == selectedPlace){
                        place.title = titleTF.text
                        place.desc = descTF.text
                        
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
    
                }
            }
            catch
            {
                print("Fetching is failed")
            }
            
        }
    }
    
    @IBAction func deletePlace(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
        
        do{
            
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results {
                let place = result as! Place
                
                if (place == selectedPlace){
                    place.deletedDate = Date()
                    
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }

            }
        }
        catch
        {
            print("Fetching is failed")
        }
    }
    
}

