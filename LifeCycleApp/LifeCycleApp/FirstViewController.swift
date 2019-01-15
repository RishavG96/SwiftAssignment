//
//  ViewController.swift
//  LifeCycleApp
//
//  Created by Rishavgupta on 1/11/19.
//  Copyright © 2019 Nuclei. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onClickButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        //showToast(controller: self, message : "This is a test", seconds: 2.0)
    }
    override func viewWillAppear(_ animated: Bool) {
        print("First View Will Appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("First View did Appeared")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("First View Will Disappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("First View did Dissapear")
    }
    
}

