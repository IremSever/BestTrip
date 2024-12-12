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


//detail 
enum DetailType {
    case citySelection
    case dateSelection
    case passengerSelection
    case additionalServiceList
    case campaignCellDetail
}

protocol ConfigurableCell {
    func configure(with data: HomeData)
}
