//
//  DataFoods+CoreDataProperties.swift
//  Uikit_Menu_14_03_2023
//
//  Created by Denis Orlenko on 04.05.2023.
//
//

import Foundation
import CoreData


extension DataFoods {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataFoods> {
        return NSFetchRequest<DataFoods>(entityName: "DataFoods")
    }

    @NSManaged public var names: String?

}

extension DataFoods : Identifiable {

}
