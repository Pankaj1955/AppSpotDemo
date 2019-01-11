//
//  ListTableViewCell.swift
//  AppSpotDemo
//
//  Created by Pankaj on 10/01/19.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet var firstName: UILabel!
    @IBOutlet var lastName: UILabel!
    @IBOutlet var ItemsImage: UIImageView!
    @IBOutlet var email: UILabel!
    
    func configure(profileModel:ProfileModel){
        self.firstName.text = profileModel.firstName
        self.lastName.text = profileModel.lastName
        self.email.text = profileModel.emailId
        
        self.cacheImage(imageURL: profileModel.imageUrl)
    }
    
    
    
    func cacheImage(imageURL:String){
        if let imageExists = UserDefaults.standard.value(forKey: imageURL) as? Data{
            imageExists.count == 0 ? (self.ItemsImage.image = UIImage(named: "user")) : (self.ItemsImage.image = UIImage(data: imageExists))
            
        }else{
            
            let url = URL(string:imageURL)
            
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                guard let data = data, error == nil else {return}
                DispatchQueue.main.async() {
                    UserDefaults.standard.set(data, forKey: imageURL)
                    self.ItemsImage.image = UIImage(data: data)
                }
            }
            task.resume()
            
        }
        
    }
    

}
