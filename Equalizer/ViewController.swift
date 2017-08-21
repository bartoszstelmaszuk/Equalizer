//
//  ViewController.swift
//  Equalizer
//
//  Created by Bartosz Stelmaszuk on 19/08/2017.
//  Copyright © 2017 Bartosz Stelmaszuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func loadView() {
        view = MainView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let castView = view as? MainView else { fatalError("Wrong view initialized") }
        castView.runTimer()
    }
}

