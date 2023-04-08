//
//  File.swift
//  
//
//  Created by Adam Mąka on 08/04/2023.
//

import Foundation

let formatter = DateFormatter()

func stringToDate(stringDate: String) -> Date {
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: stringDate)!
}


var stockValues: [DataStructureVertical] = [
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-03"), value: 130.0819),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-04"), value: 126.6970),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-05"), value: 126.9367),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-06"), value: 125.8184),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-09"), value: 130.2666),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-10"), value: 130.0619),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-11"), value: 131.0504),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-12"), value: 133.6764),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-13"), value: 131.8292),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-17"), value: 134.6250),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-18"), value: 136.6069),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-19"), value: 133.8761),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-20"), value: 135.0743),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-23"), value: 137.9100),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-24"), value: 140.0916),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-25"), value: 140.6757),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-26"), value: 142.9523),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-27"), value: 142.9373),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-30"), value: 144.7346),
    DataStructureVertical(description: stringToDate(stringDate: "2023-01-31"), value: 142.4830),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-01"), value: 143.7511),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-02"), value: 148.6736),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-03"), value: 147.8049),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-06"), value: 152.3430),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-07"), value: 150.4109),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-08"), value: 153.6460),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-09"), value: 153.5411),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-10"), value: 149.4600),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-13"), value: 150.9520),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-14"), value: 152.1200),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-15"), value: 153.1100),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-16"), value: 153.5100),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-17"), value: 152.3500),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-21"), value: 150.2000),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-22"), value: 148.8700),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-23"), value: 150.0900),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-24"), value: 147.1100),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-27"), value: 147.7100),
    DataStructureVertical(description: stringToDate(stringDate: "2023-02-28"), value: 147.0500),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-01"), value: 146.8300),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-02"), value: 144.3800),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-03"), value: 148.0450),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-06"), value: 153.7850),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-07"), value: 153.7000),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-08"), value: 152.8100),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-09"), value: 153.5590),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-10"), value: 150.2100),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-13"), value: 147.8050),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-14"), value: 151.2800),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-15"), value: 151.1900),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-16"), value: 152.1600),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-17"), value: 156.0800),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-20"), value: 155.0700),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-21"), value: 157.3200),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-22"), value: 159.3000),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-23"), value: 158.8300),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-24"), value: 158.8600),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-27"), value: 159.9400),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-28"), value: 157.9700),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-29"), value: 159.3700),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-30"), value: 161.5300),
    DataStructureVertical(description: stringToDate(stringDate: "2023-03-31"), value: 162.4400)
]

