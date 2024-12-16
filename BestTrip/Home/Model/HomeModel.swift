//
//  HomeModel.swift
//  BestTrip
//
//  Created by İrem Sever on 5.12.2024.
//

import Foundation

struct HomeModel: Codable {
    let app: [App]
}

struct App: Codable {
    let title: String
    let type: Template?
    let data: [HomeData]
    
    var shouldDisplay: Bool {
        return !(title.isEmpty && type == nil)
    }
}

struct HomeData: Codable {
    let title, titleImage, detail, image: String?
    let campaignDate, validOfferDates, validFlightDates, offerEligibility: String?
    let validOfferRoutes, fees, numberOfSeats: String?
    let link: String?
    let flightNumber, departureAirportName, departureAirportCode, arrivalAirportName: String?
    let arrivalAirportCode, departureCity, arrivalCity, departureTime: String?
    let arrivalTime, date, price: String?
    let isDirect: Bool?
    let detailData: [DetailData]?
    let city, country, airport: String?

    enum CodingKeys: String, CodingKey {
        case title
        case titleImage = "title_image"
        case detail, image
        case campaignDate = "campaign_date"
        case validOfferDates = "valid_offer_dates"
        case validFlightDates = "valid_flight_dates"
        case offerEligibility = "offer_eligibility"
        case validOfferRoutes = "valid_offer_routes"
        case fees
        case numberOfSeats = "number_of_seats"
        case link
        case flightNumber = "flight_number"
        case departureAirportName = "departure_airport_name"
        case departureAirportCode = "departure_airport_code"
        case arrivalAirportName = "arrival_airport_name"
        case arrivalAirportCode = "arrival_airport_code"
        case departureCity = "departure_city"
        case arrivalCity = "arrival_city"
        case departureTime = "departure_time"
        case arrivalTime = "arrival_time"
        case date, price
        case isDirect = "is_direct"
        case detailData
        case city, country, airport
    }
}

struct DetailData: Codable {
    let title, detail, image: String?
}
