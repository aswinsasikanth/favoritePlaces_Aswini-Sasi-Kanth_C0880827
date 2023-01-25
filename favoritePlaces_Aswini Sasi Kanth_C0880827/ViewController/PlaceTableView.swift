//
//  PlaceTableView.swift
//  favoritePlaces_Aswini Sasi Kanth_C0880827
//
//  Created by Aswin Sasikanth Kanduri on 2023-01-24.
//

import UIKit
import CoreData

var placeList = [Place]()


class PlaceTableView: UITableViewController {
    
    var firstLoad = true
    
    func nonDeletedPlace() -> [Place]
    {
        var noDeletePlaceList = [Place]()
        for place in placeList
        {
            if(place.deletedDate == nil)
            {
                noDeletePlaceList.append(place)
            }
        }
        return noDeletePlaceList
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (firstLoad)
        {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
            
            do{
                
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let place = result as! Place
                    placeList.append(place)
                }
            }
            catch
            {
                print("Fetching is failed")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let placeCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PlaceCell
        
        let thisPlace: Place!
        thisPlace = nonDeletedPlace()[indexPath.row]
        
        
        placeCell.titleLabel.text = thisPlace.title
        placeCell.descLabel.text = thisPlace.desc
        
        return placeCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nonDeletedPlace().count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editPlace", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editPlace"){
            
            let indexPath = tableView.indexPathForSelectedRow
            let placeDetail = segue.destination as! PlaceDetailVC
            
            let selectedPlace : Place!
            selectedPlace = nonDeletedPlace()[indexPath!.row]
            placeDetail.selectedPlace = selectedPlace
            
            
            tableView.deselectRow(at: indexPath!, animated: true)
        }
    }
}
