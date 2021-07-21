//
//  ViewController.swift
//  CollectionViewPageControl
//
//  Created by 신미지 on 2021/07/21.
//

import UIKit

class ViewController: UIViewController {
  
  var posterImage: [String] = [
    "furyload",
    "eightmile",
    "hiq",
    "peninsula",
    "sabaha"
  ]
  
  var timer: Timer?
  var currentCellIndex = 0
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var myPageControl: UIPageControl!
  
//  var currentPage: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    myPageControl.currentPage = 0
    myPageControl.numberOfPages = posterImage.count
    
    timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
  }
  
  @objc func slideToNext() {
    if currentCellIndex < posterImage.count - 1 {
      currentCellIndex = currentCellIndex + 1
    } else {
      currentCellIndex = 0
    }
    collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
  }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return posterImage.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionCell
    cell.myWebImageView.image = UIImage(named: posterImage[indexPath.item])
    cell.myWebImageView.layer.cornerRadius = 50.0
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.safeAreaLayoutGuide.layoutFrame.width
    let height = collectionView.safeAreaLayoutGuide.layoutFrame.height
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    myPageControl.currentPage = indexPath.item
  }
}
