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
    let collectionViewCellId = "MemoryGameCollectionViewCell"
    
    //MARK:- IBOutlet
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameModeSegmentedControl: UISegmentedControl!
    
    //MARK:- IBAction
    @IBAction func gameModeSegmentedControlChanged(_ sender: UISegmentedControl) {
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
    }
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeTiles()
        layoutGameCollectionView()

    }
    
    //MARK:- Function
    func layoutGameCollectionView()
    {
        //뷰 로드 후 바로 게임을 업데이트 시키기 위함
        self.view.layoutIfNeeded()
        self.gameCollectionView.layoutIfNeeded()
        
        cellWidth = gameCollectionView.bounds.width / CGFloat(4)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        
        gameCollectionView.collectionViewLayout = flowLayout
        gameCollectionView.reloadData()
    }
    

}

