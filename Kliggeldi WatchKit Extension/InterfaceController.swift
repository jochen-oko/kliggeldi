//
//  InterfaceController.swift
//  Kliggeldi WatchKit Extension
//
//  Created by Joko on 26.11.15.
//  Copyright © 2015 Joko. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    var currentLevel = 0
    var running = false
    var clickList = [Int]()
    var playerIndex=0

    @IBOutlet var levelCount: WKInterfaceLabel!
    
    @IBOutlet var buttonRed: WKInterfaceButton!
    
    @IBOutlet var buttonGreen: WKInterfaceButton!
    
    @IBOutlet var buttonYellow: WKInterfaceButton!
    
    @IBOutlet var buttonBlue: WKInterfaceButton!
    
    func handleButtonClick(number:Int) {
        if(running) {
            if(clickList[playerIndex]==number) {
                print("correct")
                playerIndex++
            }
            else {
                print("möööp")
                gameOver()
            }
        }
        if(playerIndex==clickList.count){
            success()
        }
    }
   
    @IBAction func buttonGreenClicked() {
        print("button Green tapped")
        handleButtonClick(1)
        
    }
    
    @IBAction func buttonRedClicked() {
        print("button Red tapped")
        handleButtonClick(2)
    }
    
    @IBAction func buttonYellowClicked() {
        print("button Yellow tapped")
        handleButtonClick(3)
    }
    
    @IBAction func buttonBlueClicked() {
        print("button Blue tapped")
        handleButtonClick(4)
    }
    
    @IBAction func go() {
        nextLevel()
        levelCount.setText("Lvl " + String(currentLevel))
        showClicklist()
        running=true;
    }
    
    func showClicklist() {
        for var i=0; i<currentLevel; i++ {
            let current = clickList[i]
            if(current==1) {
                delay(0.4*Double(i)) {self.highlightButton(self.buttonGreen, oldColor: UIColor.greenColor())}
                print("1")
            } else if(current==2) {
                delay(0.4*Double(i)) {self.highlightButton(self.buttonRed, oldColor: UIColor.redColor())}
                print("2")
            } else if(current==3) {
                delay(0.4*Double(i)) {self.highlightButton(self.buttonYellow, oldColor: UIColor.yellowColor())}
                print("3")
            } else if(current==4) {
                delay(0.4*Double(i)) {self.highlightButton(self.buttonBlue, oldColor: UIColor.blueColor())}
                print("4")
            }
            
        }
    }
    
    func delay(delay: Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure
        )
    }
    
    func highlightButton(button: WKInterfaceButton, oldColor: UIColor){
        
        button.setBackgroundColor(UIColor.whiteColor())
        delay(0.2) {
            button.setBackgroundColor(oldColor)
        }
        
    }
    
    func success() {
        running=false
    }
    
    func gameOver() {
        currentLevel=0;
        running=false;
        clickList = []
    }
    
    func nextLevel() {
        playerIndex=0
        currentLevel+=1
        let next = Int(arc4random_uniform(4)+1)
        print("next click: " + String(next))
        clickList.append(next)
    }
    
}
