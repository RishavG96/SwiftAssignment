//
//  SecondViewController.swift
//  LifeCycleApp
//
//  Created by Rishavgupta on 1/11/19.
//  Copyright © 2019 Nuclei. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print("Second View Will Appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("Second View did Appeared")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("Second View Will Disappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("Second View did Dissapear")
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
