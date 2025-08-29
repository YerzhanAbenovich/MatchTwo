//
//  ViewController.swift
//  MatchTwo
//
//  Created by Yerzhan Parimbay on 27.08.2025.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var game = GameModel()
    
    var state = [Int](repeating: 0, count: 16)
    
    var isActive = false
    
    var time = 0
    
    var moves = 0
    
    var timer = Timer()
    
    var isFinished = false
    
    @IBOutlet weak var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        game.newGame()
    }
    
    @objc func saveTime(){
        if time < 0 {
            timer.invalidate()
            return
        }
        timeLabel.text = timeToString(time: time)
        time += 1
    } // Секундомер
    
    @IBAction func startGame(_ sender: UIButton) {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(saveTime), userInfo: nil, repeats: true)
            
        startButton.isHidden = true
    } // Кнопка "Start" чтобы можно было один раз запустить секундомер и после кнопка исчезает 👍🏻
    
    @IBAction func game(_ sender: UIButton) {
        
        if state[sender.tag - 1] != 0 || isActive {
            return
        }
        
        sender.setBackgroundImage(UIImage(named: game.images[sender.tag - 1]), for: .normal)
        
        state[sender.tag - 1] = 1
        
        
        var count = 0
        
        for item in state {
            if item == 1 {
                count += 1
            }
        }
        
        if count == 2 {
            isActive = true
            for winArray in game.winState {
                if state[winArray[0]] == state[winArray[1]] && state[winArray[1]] == 1 {
                    state[winArray[0]] = 2
                    state[winArray[1]] = 2
                    isActive = false
                }
            }
            if isActive {
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(clear), userInfo: nil, repeats: false)
            }
            
            moves += 1
            movesLabel.text = "\(moves)" // Подсчет ходов
            
            isFinished = true
            for item in state {
                if item != 2 {
                    isFinished = false
                    break
                    } // Проверка на то, что в массиве state все 2 (то есть пары найдены)
            }
            
            if isFinished {
                timer.invalidate()
                let alert = UIAlertController(title: "Победа", message: "за \(moves) ходов и \(timeToString(time: time)) времени!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: {_ in self.playAgain()}))//Нужна функция, чтобы он очищал всё
                
                present(alert, animated: true)
            } // Завершение игры: посчет времени и ходов
            
        }
        
        
    }
        
    @objc func clear(){
        for i in 0...15 {
            if state[i] == 1 {
                state[i] = 0
                let button = view.viewWithTag(i + 1) as! UIButton
                button.setBackgroundImage(nil, for: .normal)
                
            }
        }
        isActive = false
    }
    
    @objc func timeToString(time: Int) -> String {
        let hour = time / 3600
        let minute = time / 60 % 60
        let second = time % 60
        return String(format: "%02i:%02i:%02i",hour, minute, second)
    }
    
    func playAgain(){
        for i in 0..<state.count {
            state[i] = 0
            if let button = view.viewWithTag(i + 1) as? UIButton {
                button.setBackgroundImage(nil, for: .normal)
            }
        }
        
        moves = 0
        movesLabel.text = "0"
        time = 0
        timeLabel.text = "00:00:00"
        isActive = false
        isFinished = false
        startButton.isHidden = false
        
        game.newGame()
        
    }
    
}

