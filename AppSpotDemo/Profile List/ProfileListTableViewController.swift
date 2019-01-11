//
//  ProfileListTableViewController.swift
//  AppSpotDemo
//
//  Created by Pankaj on 10/01/19.
//
//

import UIKit

class ProfileListTableViewController: UITableViewController {

    var dataController:DataContoller!
    
    var profileModelList = ProfileModelList(){
        didSet{
            tableView.reloadData()
        }
    }
    var emailString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated:true);

        profileModelList.dataController = dataController
        
        self.configure(post: Post(emailId: emailString ?? ""))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    func configure(post:Post){
        
        let urlString = URL(string:"\(Constants.baseURl)\(Constants.profileList)")!
        let response = Response<ProfileList>(url: urlString, postData: post){(recivedData) in
            let result = try? JSONDecoder().decode(ProfileList.self, from: recivedData)
            return result
        }
        
        if NetworkManager.sharedInstance.reachability.connection != .none{
            WebService().callPost(response: response) { (profileModel) in
                if let model = profileModel{
                    self.profileModelList.addProfileData(profileListData: model)
                }
            }
            
        }else{
          self.profileModelList.addLocalStoredData()
        }
       
    }
    @IBAction func logoutAction(_ sender: Any) {
        
        
        let alert = UIAlertController(title:Constants.kAppName , message: Constants.kLogout, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            SingleTon.sharedInstance.logoutReset()
        
            let vcInvoiceInstances = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vcInvoiceInstances.dataController = self.dataController
            self.navigationController?.pushViewController(vcInvoiceInstances, animated: true)
            
        }))
        self.present(alert, animated: true)
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileModelList.numberOfItems()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.configure(profileModel: profileModelList.itemAtIndex(indexPath.row))
        return cell
    }
    
    
    
}




