//
//  SelectionScreen.swift
//  Delegates-Protocols
//
//  Created by Sean Allen on 5/20/17.
//  Copyright © 2017 Sean Allen. All rights reserved.
//

import UIKit

protocol ColorChangeDelegate {
    func didChooseColor(color: UIColor)
}

class SelectionScreen: UIViewController {
    
    var colorDelegate: ColorChangeDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func redButtonTapped(_ sender: UIButton) {
        colorDelegate.didChooseColor(color: .red)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func blueButtonTapped(_ sender: UIButton) {
        colorDelegate.didChooseColor(color: .blue)
        dismiss(animated: true, completion: nil)
    }
}
