//
//  SecondViewController.swift
//  breakpoint
//
//  Created by Mostafa Alaa on 8/29/18.
//  Copyright © 2018 Mostafa Alaa. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    @IBOutlet weak var groupsTableView: UITableView!
    
    var groupsArray = [Group]()
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllGroups { (returnedGroupsArray) in
                self.groupsArray = returnedGroupsArray
                self.groupsTableView.reloadData()
            }
        }
    }
}
extension GroupsVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell") as? GroupCell else {return UITableViewCell()}
        let title = groupsArray[indexPath.row].groupTitle
        let desc = groupsArray[indexPath.row].groupDesc
        let membersCount = groupsArray[indexPath.row].memberCount
        cell.configureCell(title: title, description: desc, memberCount: membersCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupsFeedVC") as? GroupFeedVC else {return}
        groupFeedVC.initGroupData(forGroup: groupsArray[indexPath.row])
        presentDetail(groupFeedVC)
    }
    
    
}
