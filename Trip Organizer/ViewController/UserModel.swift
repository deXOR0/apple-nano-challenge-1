//
//  UserModel.swift
//  Trip Organizer
//
//  Created by Atyanta Awesa Pambharu on 27/04/22.
//

import Foundation
import UIKit

class UserModel {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchUser() -> User {
        
        do {
            return try context.fetch(User.fetchRequest())[0]
        }
        catch {
            print("error")
        }
        
        return User(context: context)
    }
    
}
