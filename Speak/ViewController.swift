//
//  ViewController.swift
//  Speak
//
//  Created by JiaCheng on 2018/11/30.
//  Copyright © 2018 JiaCheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var text: UITextField!
    let speaker = Speaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Speak", style: .done, target: self, action: #selector(speaking))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Pause", style: .done, target: self, action: #selector(pauseSpeaking))
    }
    
    @objc func speaking() {
        speaker.speak(message: self.text.text!)
    }
    @objc func pauseSpeaking() {
        speaker.pauseSpeak()
    }
}

