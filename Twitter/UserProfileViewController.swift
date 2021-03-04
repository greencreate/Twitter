//
//  UserProfileViewController.swift
//  Twitter
//
//  Created by Joey Steigelman on 3/1/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    
    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var numFollowing: UILabel!
    @IBOutlet weak var numFollowers: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfile()
    }
    
    func verifyCreds() {
        
        //test
        let myCredentials = "https://api.twitter.com/1.1/account/verify_credentials.json"
        let myParams = ["skip_status": true]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myCredentials, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            
        }, failure: { (Error) in
            print("Error: could not retreive user credentials.")
        })
        
    }
    
    func loadProfile() {

        //set user
        let user = "user" as! NSDictionary
        
        //set username
        name.text = user["name"] as? String
        
        //set image
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        if let imageData = data {
            profilePicture.image = UIImage(data: imageData)
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
