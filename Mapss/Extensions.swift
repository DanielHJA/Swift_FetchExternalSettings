//
//  Extensions.swift
//  Mapss_DEBUG
//
//  Created by Daniel Hjärtström on 2020-03-04.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit
import MapKit

extension UIAlertController {
    func addActions(_ actions: [UIAlertAction]) {
        actions.forEach {
            self.addAction($0)
        }
    }
}

extension MKMapView {
    
    func clearOverlays() {
        removeOverlays(self.overlays)
        removeAnnotations(self.annotations)
    }
    
    func addRouteOverLaysFromDirections(_ directions: MKDirections) {
        directions.calculate { [weak self] response, error in
            guard let response = response else { return }
            for route in response.routes {
                self?.addOverlay(route.polyline)
                self?.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: .init(top: 20, left: 20, bottom: 20, right: 20), animated: true)
            }
        }
    }
    
}

extension UIViewController {
    func setRootViewController(_ controller: UIViewController) {
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            scene.window?.rootViewController = UINavigationController(rootViewController: controller)
            scene.window?.makeKeyAndVisible()
        }
    }
}

extension Encodable {
    func encoded() -> Data? {
        let encoder = JSONEncoder()
        do {
            return try encoder.encode(self)
        } catch {
            print(error)
            return nil
        }
    }
}

extension Data {
    func decoded<T: Decodable>() -> T? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: self)
        } catch {
            print(error)
            return nil
        }
    }
}

extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
        var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt64 = 10066329 //color #999999 if string has wrong format

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt64(&rgbValue)
        }

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

extension Bundle {
    static func loadFileFromBundle(_ filename: String) -> URL? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "mp3") else { return nil }
        return URL(fileURLWithPath: path)
    }
}
