//
//  Tile.swift
//  MemoryGame
//
//  Created by yeonBlue on 2021/03/01.
//

import UIKit

let NUM_OF_4X4_TOTAL = 16 // 4X4
let NUM_OF_6X6_TOTAL = 36 // 4X4

class Tile: UILabel
{
    var tileNumber: Int?
    
    func tileUpdate()
    {
        self.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        self.textAlignment = .center
        self.text = String(tileNumber ?? 0)
    }
}

extension ViewController
{
    func makeTiles()
    {
        tiles = []
        let tileCount = NUM_OF_4X4_TOTAL
            //gameModeSegmentedControl.selectedSegmentIndex == 0 ? NUM_OF_4X4_TOTAL : NUM_OF_6X6_TOTAL
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

