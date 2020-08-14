//
//  HardModeController.swift
//  CardPang
//
//  Created by 윤병일 on 2020/08/14.
//  Copyright © 2020 Byoungil Youn. All rights reserved.
//

import UIKit

class HardModeController : UIViewController {
  //MARK: - Properties
     private let collectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .vertical
       return UICollectionView(frame: .zero, collectionViewLayout: layout)
     }()
     
     private let timeLabel : UILabel = {
       let lb = UILabel()
       lb.text = "남은 시간: "
       lb.font = UIFont.boldSystemFont(ofSize: 20)
       lb.textAlignment = .center
       return lb
     }()
     
     private let secondLabel : UILabel = {
       let lb = UILabel()
       lb.text = "0.00"
       lb.font = UIFont.boldSystemFont(ofSize: 20)
       return lb
     }()
     
     var timer : Timer?
     var milliseconds : Float = 10 * 1000
     //MARK: - Life Cycle
     override func viewDidLoad() {
       super.viewDidLoad()
       configureGradientBackground()
       setNavi()
       configureUI()
     }
     
     //MARK: - Standard
     struct Standard {
       static let standard : CGFloat = 10
       static let inset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
     }
     //MARK: - setNavi()
     private func setNavi() {
     let image = UIImage(systemName: "arrow.left")
       navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(moveBack))
       navigationItem.leftBarButtonItem?.tintColor = .white
     }
     
     private func configureUI() {
       view.addSubview(timeLabel)
       timeLabel.snp.makeConstraints {
         $0.top.equalToSuperview().offset(60)
         $0.leading.equalToSuperview().offset(120)
       }
       
       view.addSubview(secondLabel)
       secondLabel.snp.makeConstraints {
         $0.top.equalToSuperview().offset(60)
         $0.leading.equalTo(timeLabel.snp.trailing)
       }
       collectionView.dataSource = self
       collectionView.delegate = self
       collectionView.backgroundColor = .clear
       collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
       view.addSubview(collectionView)
       
       collectionView.snp.makeConstraints {
        $0.top.equalTo(secondLabel.snp.bottom)
        $0.leading.trailing.equalToSuperview()
        $0.bottom.equalTo(view.safeAreaLayoutGuide)
       }
     }
     
     
     //MARK: - objc func handle
     @objc func moveBack() {
       navigationController?.popViewController(animated: true)
     }
   }

     //MARK: - UICollectionViewDataSource
   extension HardModeController : UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       20
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
       cell.backgroundColor = .blue
       return cell
     }
     
     
   }
     
     //MARK: -
   extension HardModeController : UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      Standard.standard
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       Standard.standard
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       Standard.inset
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let width = view.frame.size.width - Standard.inset.left - Standard.inset.right - (Standard.standard * 3)
       let realWidth = width / 4
       return CGSize(width: realWidth, height: 100)
     }
   }

