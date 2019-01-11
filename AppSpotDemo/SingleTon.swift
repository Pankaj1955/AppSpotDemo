//
//  SingleTon.swift
//  AppSpotDemo
//
//  Created by Pankaj on 10/01/19.
//

import Foundation
class SingleTon{
    
    
    static let sharedInstance = SingleTon()
    
    private init(){
        
    }
    
    func setLogin(){
        self.setValueToDefaults(key: "login", value: "true" as AnyObject)
    }
    
    func getLogin()->String?{
        return self.getValueFromDefaults(key: "login") as? String
    }
    
    func logoutReset(){
        self.removeKeyValueFromDefaults(Key: "email")
    }
    
    
    func storeUserEmail(userEmail:String){
        self.setValueToDefaults(key: "email", value: userEmail as AnyObject)
    }
    func getUserEmail()->String?{
        return self.getValueFromDefaults(key: "email") as? String
    }
    
    
    //Generinc functions
    func setValueToDefaults(key:String, value:AnyObject){
        
        UserDefaults.standard.set(value, forKey: key)
    }
    func getValueFromDefaults(key:String) ->AnyObject?{
        
        if((UserDefaults.standard.value(forKey: key)) != nil){
            
            let value:AnyObject = UserDefaults.standard.value(forKey: key)! as AnyObject
            
            return value
        }else{
            
            return nil
        }
        
    }
    
    func removeKeyValueFromDefaults(Key:String){
        UserDefaults.standard.removeObject(forKey: Key)
        
    }

}
