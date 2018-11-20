//
//  Tournament_FlatFilePersistence.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/19/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import Foundation

class Tournament_FlatFilePersistence: FlatFilePersistence {
    init(_ type: PersistenceType) {
        super.init(type, _fileName: "Tournaments")
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            guard let packagedTournamentsUrl = Bundle.main.url(forResource: "Tournaments", withExtension: "json") else { return }
            try! FileManager.default.copyItem(at: packagedTournamentsUrl, to: fileURL)
        }
    }
    func write(_ tournaments: [Tournament]) {
        do {
            let data = try encode(tournaments)
            try data.write(to: fileURL, options: Data.WritingOptions.atomicWrite)
        } catch let error as NSError {
            print(error)
        }
    }
    var tournaments: [Tournament] {
        do {
            let data = try Data(contentsOf: fileURL)
            return try decode([Tournament].self, from: data)
        } catch let error as NSError {
            print(error)
        }
        return []
    }
}
