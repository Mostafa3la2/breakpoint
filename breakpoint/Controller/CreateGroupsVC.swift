//
//  CreateGroupsVC.swift
//  breakpoint
//
//  Created by Mostafa Alaa on 9/4/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit
import Firebase
class CreateGroupsVC: UIViewController {

    @IBOutlet weak var titleTextField: CustomTextField!
    @IBOutlet weak var descriptionTextField: CustomTextField!
    @IBOutlet weak var emailSearchTextField: CustomTextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addedPeopleLbl: UILabel!
    
    var emailArray = [String]()
    var selectedUserArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(textFielddidChange), for: .editingChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    @objc func textFielddidChange(){
        if emailSearchTextField.text == "" {
            emailArray = []
            tableView.reloadData()
            
        }else{
            DataService.instance.getEmail(forsearchQuery: emailSearchTextField.text!) { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func doneBtnPressed(_ sender: Any) {
        if titleTextField.text != "" && descriptionTextField.text != "" {
            DataService.instance.getIds(forEmails: selectedUserArray) { (idsArray) in
                let me = Auth.auth().currentUser?.uid
                var userIds = idsArray
                userIds.append(me!)
                DataService.instance.createGroup(withTitle: self.titleTextField.text!, andDescription: self.descriptionTextField.text!, forUserIds: userIds, handler: { (groupCreated) in
                    if groupCreated{
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        print("cannot create group")
                    }
                })
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension CreateGroupsVC: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as? UserCell else{return UITableViewCell()}
        let profileImage = UIImage(named: "defaultProfileImage")
        let email = emailArray[indexPath.row]
        if selectedUserArray.contains(email){
            cell.configureCell(profileImage: profileImage!, email: email, isSelected: true)
            
        }else{
            cell.configureCell(profileImage: profileImage!, email: email, isSelected: false)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else{return}
        if !selectedUserArray.contains(cell.emailLbl.text!){
            selectedUserArray.append(cell.emailLbl.text!)
            addedPeopleLbl.text = selectedUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        }else{
            selectedUserArray = selectedUserArray.filter({ $0 != cell.emailLbl.text! })
            if selectedUserArray.count >= 1 {
                addedPeopleLbl.text = selectedUserArray.joined(separator: ", ")
            }else{
                addedPeopleLbl.text = "add people to your group"
                doneBtn.isHidden = true
            }
        }
    }
}

extension CreateGroupsVC:UITextFieldDelegate{
    
}
