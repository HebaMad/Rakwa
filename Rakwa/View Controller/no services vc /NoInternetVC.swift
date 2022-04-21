//
//  NoInternetVC.swift
//  Rakwa
//
//  Created by moumen isawe on 19/12/2021.
//

import UIKit

class NoInternetVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
 


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func checkInterntConnection(){
        if Reachability3.isConnectedToNetwork(){
            self.dismiss(animated: true, completion: nil)
            
        }
    }
}
