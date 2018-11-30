//
//  ViewController.swift
//  LottieExample
//
//  Created by Emin Roblack on 11/25/18.
//  Copyright © 2018 emiN Roblack. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController, UIScrollViewDelegate {
 
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var timerLabel: UILabel!
  
  let animationView = LOTAnimationView(name: "eggsample")
  let eggStates = ["Soft Boiled", "Medium Boiled", "Hard XD Boiled"]
  var timeRemaining = 0
  var timer = Timer()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupAnimation()
    setupScrollView()
    setupTimer()
    
    self.view.addSubview(animationView)
    self.view.sendSubviewToBack(animationView)
  }
  
  
  
  @objc func tickTock() {
    
    if timeRemaining != 0 {
      timeRemaining -= 1
    } else {
      timer.invalidate()
    }
    timerLabel.text = "\(formattedTime(timeRemaining))"
  }
  
  
  
  func formattedTime(_ totalSeconds: Int) -> String {
    let seconds = totalSeconds % 60
    let minutes = (totalSeconds / 60) % 60
    return String(format: "%02d:%02d", minutes, seconds)
  }
  
  
  
  func setupScrollView() {
    scrollView.delegate = self
    scrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(eggStates.count),
                                    height: scrollView.frame.size.height)
    
    for item in 0 ... eggStates.count-1 {
      let label = UILabel(frame: CGRect(x: (scrollView.contentSize.width / CGFloat(eggStates.count)) * CGFloat(item),
                                        y: self.view.frame.height - 80,
                                        width: self.scrollView.contentSize.width / CGFloat(eggStates.count),
                                        height: 15))
      label.text = eggStates[item]
      label.textAlignment = .center
      label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
      label.textColor = UIColor.black
      
      scrollView.addSubview(label)
    }
  
  }
  
  
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let progress = scrollView.contentOffset.x / scrollView.contentSize.width
    animationView.animationProgress = CGFloat(progress)
        setupTimer()
  }
  
  
  
  func setupAnimation() {
    animationView.loopAnimation = true
    animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width , height: view.bounds.size.height)
    animationView.contentMode = .scaleAspectFit
    animationView.backgroundColor = UIColor.gray
  }
  
  
  
  func setupTimer() {
    timer.invalidate()
    
    switch scrollView.currentPage {
    case 1:
      timeRemaining = 240
    case 2:
      timeRemaining = 420
    case 3:
      timeRemaining = 600
    default:
      timeRemaining = 0
    }
    timerLabel.text = formattedTime(timeRemaining)
  }
  
  
  
  @IBAction func startTimerBTN(_ sender: Any) {
    if !timer.isValid {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickTock), userInfo: nil, repeats: true)
    } else {
      print("Fok OF")
    }
  }



}

