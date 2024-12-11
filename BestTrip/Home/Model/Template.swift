//
//  Template.swift
//  BestTrip
//
//  Created by İrem Sever on 6.12.2024.
//

import Foundation

public enum Template: String, Codable{
    case campaign
    case flights
    case additionalService
    case bestOppotunity
}


//flight cell button type
enum DetailType {
    case citySelection
    case dateSelection
    case passengerSelection
    case additionalServiceList
}
