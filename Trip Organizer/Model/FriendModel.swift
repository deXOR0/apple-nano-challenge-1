//
//  FriendModel.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 26/04/22.
//

import Foundation
import Contacts
import UIKit

public class Friend: NSObject, NSCoding {
    
    let name: String
    let id: String
    let source: CNContact

    public func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(id, forKey: "id")
        coder.encode(source, forKey: "source")
    }
    
    public required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        id = coder.decodeObject(forKey: "id") as! String
        source = coder.decodeObject(forKey: "source") as! CNContact
    }
    
    init(source: CNContact) {
        self.source = source
        self.name = "\(source.givenName) \(source.familyName)"
        self.id = source.identifier
    }
    
    func getImageThumbnail() -> UIImage {
        if self.source.imageDataAvailable {
            if let imageData = self.source.thumbnailImageData {
                return UIImage(data: imageData)!
            }
        }
        return UIImage(named: "default-profile")!
    }
    
}
