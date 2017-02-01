//
//  Server.swift
//  Week4 Exercise2
//
//  Created by Hanna Chen on 1/30/17.
//  Copyright © 2017 Rethink Canada. All rights reserved.
//

import Foundation

class Server {

    var registeredUsers: [String : String] = [:]
    var loggedInUser: String?
    var requiredPasswordLength: Int = 8
    var loginState: Bool = false
    
    init() {
    }
    
    func logIn(username: String?, password: String?) -> (successful: Bool, message: String) {
        
        var checkUsername: String = ""
        var checkPassword: String = ""
        
        if let unwrappedUsername = username {
            checkUsername = unwrappedUsername.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        if let unwrappedPassword = password {
            checkPassword = unwrappedPassword.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // Check for empties
        if (checkUsername == "" || checkPassword == "") {
            
            return (false, "Username and password shouldn't be empty.")
        }
        
        // Check if username exists
        if self.registeredUsers.first(where: { (key, _) in
            key.lowercased() == checkUsername.lowercased()
        }) == nil {
            
            return (false, "Username not found.")
        } else {
            
            if (self.registeredUsers[checkUsername] != checkPassword) {
                
                return (false, "Login failed.")
            } else {
                
                self.loggedInUser = checkUsername
                self.loginState = true
                return (true, "User \(checkUsername) is logged in.")
            }
        }
    }
    
    func logOut() -> (successful: Bool, message: String) {
        if (self.loggedInUser != "") {
            self.loggedInUser = nil
            self.loginState = false
            return (true, "Logged out.")
        } else {
            return (false, "No one's logged in.")
        }
    }
    
    func createNewUser(username: String?, password: String?) -> (successful: Bool, message: String) {
        
        var newUsername: String = ""
        var newPassword: String = ""
        
        if let unwrappedUsername = username {
            newUsername = unwrappedUsername.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        if let unwrappedPassword = password {
            newPassword = unwrappedPassword.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        // Check for empties
        if (newUsername == "" || newPassword == "") {
            
            return (false, "Username and password shouldn't be empty.")
        }
        
        // Validation
        if (newPassword.characters.count < self.requiredPasswordLength) {
            
            return (false, "Password must be at least \(self.requiredPasswordLength) characters long, no spaces.")
        }
        
        // Check if username exists
        if self.registeredUsers.first(where: { (key, _) in
            key.lowercased() == newUsername.lowercased()
        }) != nil {
            
            return (false, "This username is already taken!")
        }
        
        // All is good, add user
        self.registeredUsers[newUsername] = newPassword
        return (true, "User \(newUsername) added.")
    }
    
    func updatePassword(oldPassword: String?, newPassword: String?) -> (successful: Bool, message: String) {
        
        var updateOldPassword: String = ""
        var updateNewPassword: String = ""
        
        if let unwrappedOldPassword = oldPassword {
            updateOldPassword = unwrappedOldPassword.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        if let unwrappedNewPassword = newPassword {
            updateNewPassword = unwrappedNewPassword.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        if let loggedInUser = self.loggedInUser {
            
            if (self.loggedInUser != updateOldPassword) {
                
                return (false, "Wrong password")
            } else {
                
                self.registeredUsers[loggedInUser] = updateNewPassword
                return (true, "Password for \(self.loggedInUser) is updated!")
            }
        } else {
            
            return (false, "Not logged in.")
        }
    }
    
    
}
