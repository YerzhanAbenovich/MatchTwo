//
//  ViewController.swift
//  MatchTwo
//
//  Created by Yerzhan Parimbay on 27.08.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var images = ["AR", "BR", "CH", "FR", "GR", "KR", "KZ", "US", "AR", "BR", "CH", "FR", "GR", "KR", "KZ", "US"]
    
    var state = [Int](repeating: 0, count: 16)
    
    var winState = [[0, 8], [1, 9], [2, 10], [3, 11], [4, 12], [5, 13], [6, 14], [7, 15]]
    
    var isActive = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func game(_ sender: UIButton) {
        
        if state[sender.tag - 1] != 0 || isActive {
            return
        }
        
        sender.setBackgroundImage(UIImage(named: images[sender.tag - 1]), for: .normal)
        
        state[sender.tag - 1] = 1
        
        
        var count = 0
        
        for item in state {
            if item == 1 {
                count += 1
            }
        }
        
        if count == 2 {
            isActive = true
            for winArray in winState {
                if state[winArray[0]] == state[winArray[1]] && state[winArray[1]] == 1 {
                    state[winArray[0]] = 2
                    state[winArray[1]] = 2
                    isActive = false
                }
            }
            if isActive {
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(clear), userInfo: nil, repeats: false)
            }
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
    
}

