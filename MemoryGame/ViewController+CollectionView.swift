//
//  ViewController+CollectionView.swift
//  MemoryGame
//
//  Created by yeonBlue on 2021/03/01.
//

import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath)
        let currentTile = tiles[indexPath.row]
        currentTile.frame = CGRect(x: 2, y: 2, width: cellWidth - 3 , height: cellWidth - 3)
        //currentTile.backgroundColor = .red
        
        // 게임 리셋시 이미 뒤집은 것도 초기화 하기 위한 코드
        if cell.subviews.count > 0 {
            for cells in cell.subviews{
                cells.removeFromSuperview()
            }
        }
        cell.addSubview(currentTile)
        
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cellWidth = gameCollectionView.frame.width / CGFloat(4)
//        return CGSize(width: cellWidth, height: cellWidth)
//    }
}
