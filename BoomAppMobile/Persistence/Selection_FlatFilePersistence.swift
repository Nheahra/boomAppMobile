//
//  Selection_FlatFilePersistence.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/19/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import Foundation

class Selection_FlatFilePersistence: FlatFilePersistence {
    init(_ type: PersistenceType) {
        super.init(type, _fileName: "Selections")
        if !FileManager.default.fileExists(atPath: fileURL.path){
            let packagedSelectionsUrl = Bundle.main.url(forResource: "Selections", withExtension: "json")!
            try! FileManager.default.copyItem(at: packagedSelectionsUrl, to: fileURL)
        }
    }
    func write(_ selections: [SortSelection]) {
        do {
            let data = try encode(selections)
            try data.write(to: fileURL, options: Data.WritingOptions.atomicWrite)
        } catch let error as NSError {
            print(error)
        }
    }
    var selections: [SortSelection] {
        do {
            let data = try Data(contentsOf: fileURL)
            return try decode([SortSelection].self, from: data)
        } catch let error as NSError {
            print(error)
        }
        return []
    }
}
