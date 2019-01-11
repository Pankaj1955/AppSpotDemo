//
//  ProfileModel.swift
//  AppSpotDemo
//
//  Created by Pankaj on 10/01/19.
//
import UIKit
import Foundation
import CoreData

struct ProfileModelList {
    
    private var profileListItems = [ProfileModel]()
    var dataController:DataContoller!
    
    mutating func addProfileData(profileListData:ProfileList){
        self.profileListItems = profileListData.items
        self.storedata()
    }
    
    func getProfileData()->[ProfileModel]{
        return profileListItems
    }
    
    func numberOfItems()->Int {
        return profileListItems.count
    }
    
    func itemAtIndex(_ row:Int)->ProfileModel {
        return profileListItems[row]
    }
    
    mutating func addLocalStoredData(){
        if let fetchedData = self.fetchAllData(){
            for item in fetchedData{
                let profileModel = ProfileModel(emailId: item.emailId ?? "", lastName: item.lastName ?? "", imageUrl: item.imageUrl ?? "", firstName: item.firstName ?? "")
                profileListItems.append(profileModel)
            }
        }
    }
    
    func fetchAllData()->[Profile]?{
        
       let fetchRequest:NSFetchRequest<Profile> = Profile.fetchRequest()
        return try? dataController.viewContext.fetch(fetchRequest)
    }
    
    func storedata(){
        
        if let getOldData = self.fetchAllData(){
            for item in getOldData{
                dataController.viewContext.delete(item)
            }
        }
        
        for item in profileListItems{
            let profile = Profile(context: dataController.viewContext)
            profile.emailId = item.emailId
            profile.firstName = item.firstName
            profile.imageUrl = item.imageUrl
            profile.lastName = item.lastName
            try? dataController.viewContext.save()
        }
    }
    
    
    
}



struct ProfileList:Codable {
    let items:[ProfileModel]
}

struct ProfileModel:Codable {
    
    let emailId:String
    let lastName:String
    let imageUrl:String
    let firstName:String

}
