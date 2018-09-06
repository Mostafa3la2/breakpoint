//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Mostafa Alaa on 9/5/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit
import Firebase
class GroupFeedVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var sendBtnView: UIView!

    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageTextField: CustomTextField!
    
    var group : Group?
    var messages = [Message]()
    func initGroupData(forGroup group : Group){
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtnView.bindToKeyboard()
        tableview.delegate = self
        tableview.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLbl.text = group?.groupTitle
        DataService.instance.getEmailsFor(group: group!) { (returnedEmails) in
            self.membersLbl.text = returnedEmails.joined(separator: ", ")
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
                self.messages = returnedGroupMessages
                self.tableview.reloadData()
                
                if self.messages.count > 0{
                    self.tableview.scrollToRow(at: IndexPath(row: self.messages.count-1, section: 0), at: .none, animated: true)
                }
            })
        }
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    @IBAction func sendBtnPressed(_ sender: Any) {
        if messageTextField.text != "" {
            sendBtn.isEnabled = false
            messageTextField.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTextField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.key) { (complete) in
                if complete{
                    self.messageTextField.text = ""
                    self.messageTextField.isEnabled = true
                    self.sendBtn.isEnabled = true
                    
                }
            }
        }
    }
}

extension GroupFeedVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "GroupFeedCell") as? GroupFeedCell else{ return UITableViewCell()}
        let message = messages[indexPath.row]
        DataService.instance.getUserName(forUID: message.senderID) { (email) in
            let profileImage = UIImage(named: "defaultProfileImage")
            cell.configureCell(profileImg: profileImage!, email: email, content: message.content)
        }
        return cell
        
    }
    
}






