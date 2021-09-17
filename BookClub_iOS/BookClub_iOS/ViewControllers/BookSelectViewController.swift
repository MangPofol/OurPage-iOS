//
//  BookSelectViewController.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/17.
//

import UIKit

class BookSelectViewController: UIViewController {

    let customView = BookSelectView()
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
