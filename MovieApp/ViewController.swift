//
//  ViewController.swift
//  MovieApp
//
//  Created by five on 3/29/24.
//

import UIKit
import MovieAppData
import PureLayout

class ViewController: UIViewController {
    
    private var yellowRectangle: UIView!
    private var redRectangle: UIView!
    private var greenRectangle: UIView!
    
    private let rectWidth = 100
    private let rectHeight = 100
    private let sidePadding = 10
    private let topPadding = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildViews()
        
        // Do any additional setup after loading the view.
    }
    
    private func buildViews() {
        super.viewWillLayoutSubviews()
        
        let bounds = UIScreen.main.bounds
        
        
        view.backgroundColor = .systemBlue
        yellowRectangle = UIView()
        yellowRectangle.backgroundColor = .systemYellow
        yellowRectangle.frame = CGRect(
            x: sidePadding,
            y: topPadding,
            width: rectWidth,
            height: rectHeight
        )
        view.addSubview(yellowRectangle)
        
        redRectangle = UIView()
        redRectangle.backgroundColor = .systemRed
        redRectangle.frame = CGRect(
            x: 390 - sidePadding - rectWidth,
            y: topPadding,
            width: rectWidth,
            height: rectHeight
        )
        view.addSubview(redRectangle)
        
    }
    
    private func positionViews() {
        yellowRectangle.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        yellowRectangle.autoPinEdge(toSuperviewEdge: .top, withInset: 100)
        yellowRectangle.autoSetDimension(.width, toSize: 100)
        yellowRectangle.autoSetDimension(.height, toSize: 100)
    }

}

