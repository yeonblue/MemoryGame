//
//  ViewController.swift
//  MemoryGame
//
//  Created by yeonBlue on 2021/03/01.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Vars
    var tiles = [Tile]()
    var cellWidth: CGFloat = 0.0
    var firstTile: Tile? = nil
    var secondTile: Tile? = nil
    var foundTiles = [Tile]()
    
    var gameMode = 4 // 4, 6, 8
    var isTileFlipping = false // 타일 애니메이션이 일어나고 있는지 확인할 변수
    var gameTime: Int = 0
    var gameTimer: Timer?
    
    let collectionViewCellId = "MemoryGameCollectionViewCell"
    
    //MARK:- IBOutlet
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameModeSegmentedControl: UISegmentedControl!
    
    //MARK:- IBAction
    @IBAction func gameModeSegmentedControlChanged(_ sender: UISegmentedControl) {
        sender.selectedSegmentIndex == 0 ? ( gameMode = 4 ) : ( gameMode = 6 )
        self.resetButtonClicked(nil)
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton?) {
        
        makeTiles()
        gameCollectionView.reloadData()
        layoutGameCollectionView()
        
        firstTile = nil
        secondTile = nil
        foundTiles = []
        isTileFlipping = false
        timeLabel.backgroundColor = .lightGray
        
        gameTime = 0
        if gameTimer != nil {
            gameTimer?.invalidate()
            timeLabel.text = "0 : 00"
        }

        gameTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateGameTimer),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.resetButtonClicked(nil)
    }
    
    //MARK:- Function
    func layoutGameCollectionView()
    {
        //뷰 로드 후 바로 게임을 업데이트 시키기 위함
        self.view.layoutIfNeeded()
        self.gameCollectionView.layoutIfNeeded()
        
        cellWidth = gameCollectionView.bounds.width / CGFloat(gameMode)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        
        gameCollectionView.collectionViewLayout = flowLayout
        gameCollectionView.reloadData()
    }
    
    //MARK:- Helper
    @objc func updateGameTimer(){
        gameTime += 1
        
        let minutes = String(gameTime / 60)
        let seconds = String(format: "%02d", gameTime % 60)
        
        timeLabel.text = "\(minutes) : \(seconds)"
    }
}

