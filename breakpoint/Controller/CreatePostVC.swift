//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by Mostafa Alaa on 9/3/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit
import Firebase
class CreatePostVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendBtn.bindToKeyboard()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if textView.text != nil && textView.text != "Say something here ..."{
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text, forUID:(Auth.auth().currentUser?.uid)! , withGroupKey: nil) { (isComplete) in
                if isComplete{
                print(DB_BASE.url)
                self.sendBtn.isEnabled = true
                self.dismiss(animated: true, completion: nil)
            }else{
                self.sendBtn.isEnabled = true
                print("error sending the message")
                }}
        }
    }
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
extension CreatePostVC:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
