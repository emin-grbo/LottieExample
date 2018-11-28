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
  let animationView = LOTAnimationView(name: "data")
  let eggStates = ["Soft Boiled", "Medium Boiled", "Hard XD Boiled"]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(reckognizer:)))
    self.view.addGestureRecognizer(panGesture)
    
    setupAnimation()
    setupScrollView()
    
    self.view.addSubview(animationView)
    self.view.bringSubviewToFront(scrollView)
  }
  
  
  
  @objc func handlePan(reckognizer: UIPanGestureRecognizer) {
    let translation = reckognizer.translation(in: self.view)
    let progress = translation.x / self.view.bounds.size.width
    
    animationView.animationProgress = progress
    animationView.play()
  }
  
  
  
  func setupScrollView() {
    scrollView.delegate = self
    scrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(eggStates.count),
                                    height: scrollView.frame.size.height)
    
    for item in 0 ... eggStates.count-1 {
      let label = UILabel(frame: CGRect(x: (scrollView.contentSize.width / CGFloat(eggStates.count)) * CGFloat(item),
                                        y: 50,
                                        width: self.scrollView.contentSize.width / CGFloat(eggStates.count),
                                        height: 15))
      label.text = eggStates[item]
      label.textAlignment = .center
      label.font = UIFont.systemFont(ofSize: 20)
      label.textColor = UIColor.red
      
      scrollView.addSubview(label)
    }
    
  }
  
  
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let progress = scrollView.contentOffset.x / scrollView.contentSize.width
    animationView.animationProgress = progress
  }
  
  
  
  func setupAnimation() {
    animationView.loopAnimation = true
    animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width , height: view.bounds.size.height)
    animationView.contentMode = .scaleAspectFit
    animationView.backgroundColor = UIColor.gray
    
    animationView.play()
  }



}

