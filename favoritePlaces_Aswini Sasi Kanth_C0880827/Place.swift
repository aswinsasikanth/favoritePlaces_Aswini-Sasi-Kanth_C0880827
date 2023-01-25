//
//  Place.swift
//  favoritePlaces_Aswini Sasi Kanth_C0880827
//
//  Created by Aswin Sasikanth Kanduri on 2023-01-24.
//

import CoreData

@objc(Place)
class Place: NSManagedObject{
    
    @NSManaged var id: NSNumber!
    @NSManaged var title: String!
    @NSManaged var desc: String!
    @NSManaged var deletedDate: Date!
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    
}
