//
//  ProfileTableViewCell.swift
//  XCHAT
//
//  Created by Jim Cai on 5/25/15.
//  Copyright (c) 2015 Mateo Garcia. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var realName: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let photo: PFFile=PFUser.current()?.object(forKey: "photo") as! PFFile?{
            let pfImageView = PFImageView()
            pfImageView.image = UIImage(named: "profilePic")
            print(photo)
            pfImageView.file = photo
            pfImageView.load { (image: UIImage?, error: Error?) -> Void in
                if let error = error {
                    
                    // Log details of the failure
                    print("Error: \(error) \(error._userInfo)")
                } else {
                    
                    print("Setting cell photo.")
                    
                    self.profilePic.image = image
                }
            }

        }
        
        PFUser.current()?.fetchInBackground(block: { (object: PFObject?, error: Error?) -> Void in
            if let error = error {
                self.setDefaults()
                
                // Log failure.
                print("Error refreshing current user: \(error._userInfo)")
            } else {
                
                print("LALALALALALALABANANANANANANA")
                
                if let object = object {
                    self.userName.text = object["username"] as? String
                    self.realName.text = object["name"] as? String
                } else {
                    self.setDefaults()
                }
            }
        })
        
        /*
        let query = PFQuery(className: "User")
        query.whereKey("username", equalTo: (PFUser.currentUser()?.username)!)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            let objs = objects as! [PFObject]
            if objs.count > 0 {
                let profile = objects![0] as! PFObject
                self.userName.text = profile["username"] as? String
                self.realName.text = profile["name"] as? String
            } else {
                self.userName.text = "Please Set Your Name by Tapping"
                self.realName.text = ""
            }
        }
        */
    }
    
    func setDefaults() {
        self.userName.text = "Please Set Your Name by Tapping"
        self.realName.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
