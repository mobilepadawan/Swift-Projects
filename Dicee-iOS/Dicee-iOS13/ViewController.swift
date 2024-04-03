/*
  ViewController.swift
  Dicee
  Created by Fer Moon on 03/30/2024.
  Copyright © 2024 Vidamobile. All rights reserved.
*/
/*
    URL DEL ENDPOINT: https://65c408c0dae2304e92e246d2.mockapi.io/v1/scores
    ESTRUCTURA DEL ENDPOINT: [{"id":"1","date":"2024-04-02 18:38:04","you":14,"house":36,"userid":"Ferproonline"}]
 */
import UIKit

class ViewController: UIViewController {
    //    Image view de los dados
    @IBOutlet weak var diceImageViewOne: UIImageView!
    @IBOutlet weak var diceImageViewTwo: UIImageView!
    //    Etiquetas de puntaje
    @IBOutlet weak var theHouseValueLabel: UILabel!
    @IBOutlet weak var youValueLabel: UILabel!
    @IBOutlet weak var rollButton: UIButton! //    Botón tirar los dados
    let arrayDiceImages = [//    Array con los nros
        UIImage(imageLiteralResourceName: "DiceOne"),
        UIImage(imageLiteralResourceName: "DiceTwo"),
        UIImage(imageLiteralResourceName: "DiceThree"),
        UIImage(imageLiteralResourceName: "DiceFour"),
        UIImage(imageLiteralResourceName: "DiceFive"),
        UIImage(imageLiteralResourceName: "DiceSix")
    ]
    
    struct GameResult: Codable {
        let house: Int
        let you: Int
        let date: String
        let userid: String
    }
    
    var originalColor: CGColor?
    var leftDiceNumber = 0
    var rightDiceNumber = 5
    var theHouseValue = 0
    var youValue = 0
    var id = "1"
    
    func sendGameResult(house: Int, you: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.string(from: Date())
        
        let gameResult = GameResult(house: house, you: you, date: date, userid: "Ferproonline")
        
        guard let jsonData = try? JSONEncoder().encode(gameResult) else {
            print("Error al codificar los datos a JSON")
            return
        }
        
        let urlString = "https://65c408c0dae2304e92e246d2.mockapi.io/v1/scores/\(id)"
        guard let url = URL(string: urlString) else {
            print("URL inválida")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                print("Error en la solicitud: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error en el servidor: \(response.debugDescription)")
                return
            }
            
            if let data = data,
               let responseData = String(data: data, encoding: .utf8) {
                print("Respuesta del servidor: \(responseData)")
            } else {
                print("Error al procesar los datos de respuesta")
            }
        }
        task.resume()
    }

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
        // capturar el color de fondo del botón 'rollButton'
        originalColor = rollButton.backgroundColor?.cgColor
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
            if let originalColor = self.originalColor {
                        self.rollButton.backgroundColor = UIColor(cgColor: originalColor)
                    }
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
            self.sendGameResult(house: self.theHouseValue, you: self.youValue)
        }
    }
}
