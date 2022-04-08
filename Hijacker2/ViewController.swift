//
//  ViewController.swift
//  Hijacker2
//
//  Created by albin holmberg on 2022-04-07.
//

import UIKit

class ViewController: UIViewController {
    private let button:  UIButton={
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Send fake response", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemRed
        view.addSubview(button)
        button.frame = CGRect(x: 0, y:0, width: 200, height: 50)
        button.center = view.center
        button.addTarget(self, action: #selector(sendResponse), for: .touchUpInside)
    }
    @objc func sendResponse(){
        print("sending fake response back to company")
    }


}

