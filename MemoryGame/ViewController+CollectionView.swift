//
//  ViewController+CollectionView.swift
//  MemoryGame
//
//  Created by yeonBlue on 2021/03/01.
//

import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath)
        let currentTile = tiles[indexPath.row]
        currentTile.frame = CGRect(x: 3, y: 3, width: cellWidth - 3 , height: cellWidth - 3)
        
        // 게임 리셋시 이미 뒤집은 것도 초기화 하기 위한 코드
        if cell.subviews.count > 0 {
            for cells in cell.subviews{
                cells.removeFromSuperview()
            }
        }
        cell.addSubview(currentTile)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        if let tile = cell?.subviews[0] as? Tile
        {
            // 이미 찾은 타일은 제외
            if(foundTiles.contains(tile)) || isTileFlipping{
                return
            }
            
            // 동일 타일 클릭시 리턴
            if(firstTile != nil){
                if tile == firstTile {
                    return
                }
            }
            
            isTileFlipping = true
            
            if firstTile == nil{
                firstTile = tile
                firstTile?.status = .FLIPPED
                firstTile?.tileUpdate()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.isTileFlipping = false
                }
            }
            else{
                secondTile = tile
                secondTile?.status = .FLIPPED
                secondTile?.tileUpdate()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    
                    self.compareTwoTiles()
                    self.isTileFlipping = false
                }
            }
        }
    }
    
    func compareTwoTiles(){
        if firstTile?.tileNumber == secondTile?.tileNumber{
            firstTile?.status = .FOUND
            secondTile?.status = .FOUND
            
            foundTiles.append(firstTile!)
            foundTiles.append(secondTile!)
            
            // 모두 찾았는지 확인
            if checkAllTileFlipped(){
                gameTimer?.invalidate()
                timeLabel.text = "Finished in \(gameTime / 60) : \(gameTime % 60)"
                timeLabel.backgroundColor = .systemGreen
            }
        }
        else{
            firstTile?.status = .UNKNOWN
            secondTile?.status = .UNKNOWN
        }
        
        firstTile?.tileUpdate()
        secondTile?.tileUpdate()
        
        firstTile = nil
        secondTile = nil
    }
    
    func checkAllTileFlipped() -> Bool{
        return foundTiles.count == tiles.count
    }
}
