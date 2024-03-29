//
//  ViewController.swift
//  MovieApp
//
//  Created by five on 3/29/24.
//

import UIKit
import MovieAppData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let details = MovieUseCase().getDetails(id: 111161)
        
        print(details)
        // Do any additional setup after loading the view.
    }


}

