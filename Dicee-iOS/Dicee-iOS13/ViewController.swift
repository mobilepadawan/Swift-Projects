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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        diceImageViewOne.image = arrayDiceImages[leftDiceNumber]
        diceImageViewTwo.image = arrayDiceImages[rightDiceNumber]
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
    
    @IBAction func RollButtonPressed(_ sender: Any) {
        let leftRandomNumber = Int.random(in: 0...5)
        let rightRandomNumber = Int.random(in: 0...5)
        print("Random Number Left: \(leftRandomNumber)")
        print("Random Number Right: \(rightRandomNumber)")
        
        turnImageView(diceImageViewOne, withRandomNumber: leftRandomNumber)
        turnImageView(diceImageViewTwo, withRandomNumber: rightRandomNumber)
    }
}
