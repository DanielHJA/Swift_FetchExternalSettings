//
//  FileService.swift
//  Mapss
//
//  Created by Daniel Hjärtström on 2020-03-05.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

enum FileType: String {
    case json = "json"
}


class FileService {
    
    private static let manager = FileManager.default
    
    private static var documentsDirectory: URL? {
        return manager.urls(for: .documentDirectory, in: .userDomainMask).first
    }

    class func save(fileName: String, fileType: FileType, data: Data?) {
        guard let documentsDirectory = documentsDirectory else { return }
        let fileLocation = documentsDirectory.appendingPathComponent("\(fileName).\(fileType)")
        
        do {
            try data?.write(to: fileLocation, options: [])
        } catch {
            print(error)
        }
    }
    
    class func fetch<T: Decodable>(type: T.Type, fileName: String, fileType: FileType) -> T? {
        guard let documentsDirectory = documentsDirectory else { return nil }
        let fileLocation = documentsDirectory.appendingPathComponent("\(fileName).\(fileType)")
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data.decoded()
        } catch {
            print(error)
            return nil
        }
    }
    
    class func fileExist(fileName: String, fileType: FileType) -> Bool {
        guard let documentsDirectory = documentsDirectory else { return false }
        let fileLocation = documentsDirectory.appendingPathComponent("\(fileName).\(fileType)")
        return manager.fileExists(atPath: fileLocation.path)
    }
    
}
