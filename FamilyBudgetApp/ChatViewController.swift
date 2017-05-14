//
//  ChatViewController.swift
//  FamilyBudgetApp
//
//  Created by PLEASE on 07/05/2017.
//  Copyright © 2017 Technollage. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase


class ChatViewController: JSQMessagesViewController{
    
    var messages = [JSQMessage]()
    var currentSenderName : String?
    var currentSenderID : String?
    var currentWalletID : String?
    
    lazy var outgoingBubbleImageView : JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView : JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    var allWalletsBtn = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = FIRAuth.auth()?.currentUser?.uid
        self.senderDisplayName = Resource.sharedInstance().currentUser?.userName
        allWalletsBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "allWallets"), style: .plain, target: self, action: #selector(self.allWalletsBtnTapped))
        allWalletsBtn.tintColor = bluethemecolor
        self.navigationItem.leftBarButtonItem = allWalletsBtn
        
        HelperObservers.sharedInstance().getUserAndWallet { (flag) in
            if flag {
                self.navigationItem.title = Resource.sharedInstance().currentWallet?.name
                self.currentSenderName = Resource.sharedInstance().currentUser?.userName
                self.currentSenderID = Resource.sharedInstance().currentUserId!
                self.currentWalletID = Resource.sharedInstance().currentWalletID!
            }
        }
        print("sender name:", senderDisplayName)
        print("sender id:", senderId)
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addMessage(withId: "foo", name: "zee", text: "heelo world")
        addMessage(withId: senderId, name: "he", text: "world")
    }

    func allWalletsBtnTapped() {
        let storyboard = UIStoryboard(name: "HuzaifaStroyboard", bundle: nil)
        let cont = storyboard.instantiateViewController(withIdentifier: "allWallets") as! HomeViewController
        self.present(cont, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Resource.sharedInstance().currentWallet?.name
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage{
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with : UIColor.jsq_messageBubbleBlue())
    }
    private func setupIncomingBubble() -> JSQMessagesBubbleImage{
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId == currentSenderID{
            return outgoingBubbleImageView
        }
        else
        {
            return incomingBubbleImageView
        }
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    private func addMessage(withId id: String, name: String , text: String){
        if let message = JSQMessage(senderId : id, displayName: name , text: text){
            messages.append(message)
        }
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
