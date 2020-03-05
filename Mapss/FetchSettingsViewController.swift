//
//  FetchSettingsViewController.swift
//  Mapss_DEBUG
//
//  Created by Daniel Hjärtström on 2020-03-05.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class FetchSettingsViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.black
        temp.text = "Downloading Remote Settings"
        temp.textAlignment = .center
        temp.numberOfLines = 2
        temp.font = UIFont.preferredFont(forTextStyle: .title2)
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0).isActive = true
        temp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temp.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30.0).isActive = true
        return temp
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let temp = UIActivityIndicatorView()
        temp.style = .large
        temp.color = UIColor.gray
        temp.startAnimating()
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20.0).isActive = true
        return temp
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        label.isHidden = false
        activityIndicator.isHidden = false
        fetchCurrentSettings()
    }
    
    private func fetchCurrentSettings() {
        WebService<LayoutSettingsObject>.fetch(urlString: "http://demo6427581.mockable.io/") { [weak self] (result) in
            switch result {
            case .success(let layoutSettingsObject):
                LayoutSettings.shared.layoutSettingsObject = layoutSettingsObject
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    let controller = ViewController()
                    FileService.save(fileName: "LayoutSettings", fileType: .json, data: layoutSettingsObject.encoded())
                    self?.setRootViewController(controller)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

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
    
    class func fetch<T: Decodable>(type: T.Type, fileName: String, fileType: FileType, completion: @escaping (T?) -> Void) {
        guard let documentsDirectory = documentsDirectory else { return }
        let fileLocation = documentsDirectory.appendingPathComponent("\(fileName).\(fileType)")
        
        do {
            let data = try Data(contentsOf: fileLocation)
            completion(data.decoded())
        } catch {
            print(error)
        }
    }
    
    class func fileExist(fileName: String, fileType: FileType, completion: @escaping (Bool) -> Void) {
        guard let documentsDirectory = documentsDirectory else { return }
        let fileLocation = documentsDirectory.appendingPathComponent("\(fileName).\(fileType)")
        completion(manager.fileExists(atPath: fileLocation.path))
    }
    
}


