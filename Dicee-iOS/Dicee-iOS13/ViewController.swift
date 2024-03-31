/*
  ViewController.swift
  Dicee-iOS

  Created by Fer Moon on 03/30/2024.
  Copyright © 2024 Vidamobile. All rights reserved.
*/
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var diceImageViewOne: UIImageView!
    @IBOutlet weak var diceImageViewTwo: UIImageView!
    
    @IBOutlet weak var theHouseValueLabel: UILabel!
    @IBOutlet weak var youValueLabel: UILabel!
    
    @IBOutlet weak var rollButton: UIButton!

    var arrayDiceImages = [
        UIImage(imageLiteralResourceName: "DiceOne"),
        UIImage(imageLiteralResourceName: "DiceTwo"),
        UIImage(imageLiteralResourceName: "DiceThree"),
        UIImage(imageLiteralResourceName: "DiceFour"),
        UIImage(imageLiteralResourceName: "DiceFive"),
        UIImage(imageLiteralResourceName: "DiceSix")
    ]
    
    var leftDiceNumber = 0
    var rightDiceNumber = 5
    var theHouseValue = 0
    var youValue = 0
    
    func compareNumbersOfDices(nroA: Int, nroB: Int)-> Bool {
        let result = nroA == nroB
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diceImageViewOne.image = arrayDiceImages[leftDiceNumber]
        diceImageViewTwo.image = arrayDiceImages[rightDiceNumber]
        theHouseValueLabel.text = "\(theHouseValue)"
        youValueLabel.text = "\(youValue)"
        
    }
    
    func turnImageView(_ imageView: UIImageView, withRandomNumber randomNumber: Int) {
        let rotacion = CABasicAnimation(keyPath: "transform.rotation")
        
        rotacion.fromValue = 0.0
        rotacion.toValue = CGFloat.pi * 2.0
        rotacion.duration = 1.0
        rotacion.repeatCount = 1
        imageView.layer.add(rotacion, forKey: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            imageView.layer.removeAllAnimations()
            imageView.transform = .identity
            imageView.image = self.arrayDiceImages[randomNumber]
        }
    }
    
    @IBAction func RollButtonDown(_ sender: Any) {
        rollButton.backgroundColor = .clear
        rollButton.setTitle("⏳", for: .normal)
    }
    
    @IBAction func RollButtonPressed(_ sender: UIButton) {
        let leftRandomNumber = Int.random(in: 0...5)
        let rightRandomNumber = Int.random(in: 0...5)
                
        turnImageView(diceImageViewOne, withRandomNumber: leftRandomNumber)
        turnImageView(diceImageViewTwo, withRandomNumber: rightRandomNumber)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
            self.rollButton.backgroundColor = UIColor.systemGreen
            self.rollButton.setTitle("ROLL THE DICE", for: .normal)
            let resultComparision = self.compareNumbersOfDices(nroA: leftRandomNumber, nroB: rightRandomNumber)
            if resultComparision == true {
                let newScore = leftRandomNumber + rightRandomNumber + 2
                self.youValue = self.youValue + newScore
                self.youValueLabel.text = "\(self.youValue)"
            } else {
                self.theHouseValue = self.theHouseValue + 1
                self.theHouseValueLabel.text = "\(self.theHouseValue)"
            }
        }

    }
}
