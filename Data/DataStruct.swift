//
//  File 2.swift
//  
//
//  Created by Adam Mąka on 01/04/2023.
//

import Foundation

struct DataStruct: Identifiable {
    var id = UUID()
    var description: String
    var value: Double
}

struct DataStructureVertical: Identifiable {
    var id = UUID()
    var description: Date
    var value: Double
}

struct DataStructureVerticalDouble: Identifiable {
    var id = UUID()
    var description: String
    var value: [DataStructureVertical]
}
