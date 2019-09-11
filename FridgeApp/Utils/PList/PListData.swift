//
//  PListData.swift
//  FridgeApp
//
//  Created by Bia on 27/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class PListData {
    static func readPropertyList(resource: String) -> [String] {
        guard let url = Bundle.main.url(forResource: resource, withExtension: ".plist") else { fatalError("url invalido") }
        let plistDecoder = PropertyListDecoder.init()
        var plistData = [String]()
        do {
            let data = try Data.init(contentsOf: url)
            plistData = try plistDecoder.decode([String].self, from: data)
        } catch {
            print(error)
        }

        return plistData
    }
}
