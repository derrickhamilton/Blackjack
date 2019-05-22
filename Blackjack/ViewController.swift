//
//  ViewController.swift
//  Blackjack
//
//  Created by iOSDev on 5/20/19.
//  Copyright © 2019 iOSDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerValLbl: UILabel!
    @IBOutlet weak var dealerValLbl: UILabel!
    @IBOutlet weak var moneyLbl: UILabel!
    @IBOutlet weak var cardsLeftLbl: UILabel!
    var gameModel = BlackjackModel()
    var playerHandView: UIStackView!
    var dealerHandView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        playerHandView = view.viewWithTag(1) as! UIStackView
        dealerHandView = view.viewWithTag(2) as! UIStackView
        playerValLbl.text = "0"
        dealerValLbl.text = "0"
        moneyLbl.text = "$\(gameModel.getPlayerMoney())"
        cardsLeftLbl.text = "\(gameModel.getDeckCount())"
        
        /*let image: UIImage = UIImage(named: "ace_of_spades")!
        let image2: UIImage = UIImage(named: "ace_of_clubs")!
        let imageView: UIImageView = UIImageView(frame: CGRect(x:0, y:0, width:60, height:90))
        imageView.image = image
        stackView.addSubview(imageView)
        let imageView2: UIImageView = UIImageView(frame: CGRect(x:0, y:0, width:60, height:90))
        imageView2.image = image2
        stackView2.addSubview(imageView2)*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnStartHand(_ sender: UIButton) {
    }
    
    @IBAction func btnStand(_ sender: UIButton) {
    }
    
    @IBAction func btnHit(_ sender: UIButton) {
    }
}

