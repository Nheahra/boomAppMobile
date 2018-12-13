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
    typealias CreateTournamentResponse = (Tournament) -> ()
    
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
                            var i: Int = 0
                            for row in rows {
                                let tournament = Tournament(id: row["tournament_id"] as? Int ?? i, tournamentName: row["tournament_name"] as? String ?? "Tournament Name Here", locationName: row["location_name"] as? String ?? "Location Name", address: row["location_address"] as? String ?? "Address", city: row["location_city"] as? String ?? "City", state: row["location_state"] as? String ?? "State", startDate: row["tournament_start_date"] as? Date ?? Date(), rainDate: row["tournament_rain_date"] as? Date ?? Date())
                                TournamentArray.append(tournament)
                                i += 1
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
    
    func createTournament(tournament: Tournament, completion: @escaping CreateTournamentResponse){
        guard let url = URL.init(string: "https://sabrie.com:3000/tournaments") else
        {
            print("Create Tournament Failed.")
            return
        }
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: tournament, options: .prettyPrinted)
        } catch let error {
            print(error)
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON {
                        print(json)
                        completion(tournament)
                    }
                } catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
