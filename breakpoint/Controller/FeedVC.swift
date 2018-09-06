//
//  FirstViewController.swift
//  breakpoint
//
//  Created by Mostafa Alaa on 8/29/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var messageArray = [Message] ()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataService.instance.getAllFeedMessages { (returnedMssageArray) in
            self.messageArray = returnedMssageArray.reversed()
            self.tableView.reloadData()
        }
    }
}
extension FeedVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell else {
            return UITableViewCell()
        }
        let message = messageArray[indexPath.row]
        let image = UIImage(named: "defaultProfileImage")
        DataService.instance.getUserName(forUID: message.senderID) { (returnedUserName) in
            cell.configureCell(profileImage: image!, email: returnedUserName, content: message.content)
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
}

