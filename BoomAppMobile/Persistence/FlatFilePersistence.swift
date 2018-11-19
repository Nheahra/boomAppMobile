//
//  FlatFilePersistence.swift
//  BoomAppMobile
//
//  Created by Katelyn on 11/19/18.
//  Copyright © 2018 Katelyn. All rights reserved.
//

import Foundation

class FlatFilePersistence {
    enum PersistenceType: String {
        case json
        case plist
    }
    let fileName: String
    let fileURL: URL
    let persistenceType: PersistenceType
    
    init(_ type: PersistenceType, _fileName: String) {
        fileName = _fileName
        fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent(fileName, isDirectory: false)
            .appendingPathExtension(type.rawValue)
        persistenceType = type
    }
    func encode<T>(_ value: T) throws -> Data where T : Encodable {
        switch persistenceType {
        case .json:
            return try JSONEncoder().encode(value)
        case .plist:
            return try PropertyListEncoder().encode(value)
        }
    }
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        switch persistenceType {
        case .json:
            return try JSONDecoder().decode(type, from: data)
        case .plist:
            return try PropertyListDecoder().decode(type, from: data)
        }
    }
}
