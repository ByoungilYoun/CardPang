//
//  EasyModeController.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/14.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class EasyModeController : UIViewController {
  
  //MARK: - Properties
  private let collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  private let timeLabel : UILabel = {
    let lb = UILabel()
    lb.text = "남은 시간: "
    lb.textAlignment = .center
    return lb
  }()
  
  private let secondLabel : UILabel = {
    let lb = UILabel()
    lb.text = ""
    return lb
  }()
  
  var timer : Timer?
  var milliseconds : Float = 10 * 1000
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureGradientBackground()
    setNavi()
  }
  
  //MARK: - setNavi()
  private func setNavi() {
  let image = UIImage(systemName: "arrow.left")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(moveBack))
    navigationItem.leftBarButtonItem?.tintColor = .white
}
  
  //MARK: - objc func handle
  @objc func moveBack() {
    navigationController?.popViewController(animated: true)
  }
}
