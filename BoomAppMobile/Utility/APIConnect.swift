//
//  APIConnect.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/7/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import Foundation

class APIConnect {
    
    typealias JSON = [String : Any]
    typealias TournamentResponse = ([Tournament]) -> ()
    
    func getTournaments(completion: @escaping TournamentResponse){
        var TournamentArray = [Tournament]()
        guard let url = URL.init(string: "https://sabrie.com:3000/tournaments") else {
            print("No tournaments for you.")
            return
        }
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? JSON {
                        if let rows = json["rows"] as? [JSON] {
                            for row in rows {
                                let tournament = Tournament(id: row["tournament_id"] as! Int, tournamentName: row["tournament_name"] as! String, locationName: row["location_name"] as! String, address: row["location_address"] as! String, city: row["location_city"] as! String, state: row["location_state"] as! String, startDate: row["tournament_start_date"] as! Date, rainDate: row["tournament_rain_date"] as! Date)
                                TournamentArray.append(tournament)
                            }
                        }
                        completion(TournamentArray)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
}
