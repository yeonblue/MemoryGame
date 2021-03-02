//
//  Tile.swift
//  MemoryGame
//
//  Created by yeonBlue on 2021/03/01.
//

import UIKit

enum TileStatus {
    case UNKNOWN, FOUND, FLIPPED
}

class Tile: UILabel
{
    var tileNumber: Int?
    var status: TileStatus = .UNKNOWN
    
    func tileUpdate()
    {
        self.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        self.textAlignment = .center
        
        switch status {
        case .UNKNOWN:
            UIView.transition(with: self,
                              duration: 0.5,
                              options: .transitionFlipFromRight ,
                              animations: {
                                self.text = "?"
                                self.backgroundColor = .darkGray
                              })
        case .FOUND:
            UIView.transition(with: self,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: {
                                self.text = "😆"
                                self.backgroundColor = .systemGreen
                              })
        case .FLIPPED:
            UIView.transition(with: self,
                              duration: 0.5,
                              options: .transitionFlipFromLeft,
                              animations: {
                                self.text = String(self.tileNumber!)
                                self.backgroundColor = .link
                              })
        }
    }
}

extension ViewController
{
    func makeTiles()
    {
        tiles = []
        let tileCount = gameMode * gameMode
        let numOfHalfTiles = tileCount / 2
        
        for currentNum in 1...tileCount
        {
            let tile = Tile()
            var tileNumber = currentNum
            
            if(currentNum > numOfHalfTiles)
            {
                tileNumber -= numOfHalfTiles
            }
            
            tile.tileNumber = tileNumber
            tile.tileUpdate()
            tiles.append(tile)
        }
        
        tiles.shuffle()
    }
}

