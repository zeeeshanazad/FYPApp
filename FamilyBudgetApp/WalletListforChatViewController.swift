//
//  WalletListforChatViewController.swift
//  FamilyBudgetApp
//
//  Created by PLEASE on 07/05/2017.
//  Copyright © 2017 Technollage. All rights reserved.
//

import UIKit

class WalletListforChatViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var WalletMembers : [User]?
        var WalletIDs : [String]?
        
        HelperObservers.sharedInstance().getUserAndWallet{
            (flag) in
            if(flag){
                WalletMembers = Resource.sharedInstance().currentWallet!.members
                WalletIDs = [Resource.sharedInstance().currentUserId!]
            }
                
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
