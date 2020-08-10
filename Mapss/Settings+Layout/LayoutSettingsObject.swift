//
//  LayoutSettingsObject.swift
//  Mapss_DEBUG
//
//  Created by Daniel Hjärtström on 2020-03-05.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

struct LayoutSettingsObject: Codable {

    let font: String
    let textColor: String
    
    private enum CodingKeys: String, CodingKey {
        case font = "font"
        case textColor = "textColor"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        font = try container.decode(String.self, forKey: .font)
        textColor = try container.decode(String.self, forKey: .textColor)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(font, forKey: .font)
        try container.encode(textColor, forKey: .textColor)
    }
    
}

