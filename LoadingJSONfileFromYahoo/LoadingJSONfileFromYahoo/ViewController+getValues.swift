//
//  ViewController+getValues.swift
//  LoadingJSONfileFromYahoo
//
//  Created by Carlos Santiago Cruz on 2/17/19.
//  Copyright © 2019 Carlos Santiago Cruz. All rights reserved.
//

import Foundation

extension ViewController {
    func getValues(jsonData: Data) {
        // the values provided by Yahoo are nested one inside another,
        // so we have to create several structures to represent them
        // we have defined the structures inside the method to simplify the example.
        struct Condition: Codable {
            let temperature: String
            let text: String
            let date: Date
        }
        struct Item: Codable {
            let condition: Condition
        }
        struct Channel: Codable {
            let item: Item
        }
        struct Results: Codable {
            let channel: Channel
        }
        struct Query: Codable {
            let results: Results
        }
        struct JsonResults: Codable {
            let query: Query
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMMM yyyy h:mm a z"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        do { let information = try decoder.decode(JsonResults.self, from: jsonData)
            print("watch the console")
            print("Temperature: \(information.query.results.channel.item.condition.temperature)")
            print("Condition: \(information.query.results.channel.item.condition.text)")
            print("Date: \(information.query.results.channel.item.condition.date)")
        } catch {
            print("Error")
        }
    }
}
