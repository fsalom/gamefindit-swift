//
//  ViewController.swift
//  memorize
//
//  Created by Fernando Salom Carratala on 23/6/22.
//

import UIKit

class GameController: UIViewController {
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var gameButton: UIButton!
  @IBOutlet weak var collectionView: UICollectionView!

  var viewModel: GameViewModel!

  let flowLayout: UICollectionViewFlowLayout = {
      let layout = UICollectionViewFlowLayout()
      layout.minimumInteritemSpacing = 1
      layout.minimumLineSpacing = 1
      layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
      return layout
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.viewReady()
    fillUI()
    setupUI()
    collectionView.register(UINib(nibName: "EmojiCell", bundle: nil), forCellWithReuseIdentifier: "EmojiCell")
    collectionView.delegate = self
    collectionView.dataSource = self
    // Do any additional setup after loading the view.
  }

  func maxRows() -> Int{
    let height = collectionView.bounds.height
    let width = collectionView.bounds.width
    let numberOfItemsPerRow: CGFloat = 5
    let spacing: CGFloat = flowLayout.minimumInteritemSpacing * 2 * 5
    let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
    let itemDimension = floor(availableWidth / numberOfItemsPerRow)

    return Int(height / (itemDimension + 5))
  }

  func setupUI(){
    switch viewModel.currentStatus {
    case .start:
      viewModel.isFinished = false
      viewModel.rounds = []
      viewModel.emojis = maxRows() * 5
      viewModel.newRound()
      titleLabel.text = ""
      timerLabel.text = ""
      scoreLabel.text = ""
      gameButton.setTitle("Empezar", for: .normal)
    case .playing:
      newRound()
      timerLabel.text = ""
      gameButton.setTitle("Finalizar", for: .normal)
      viewModel.timer = Timer.scheduledTimer(timeInterval:1, target:self, selector:#selector(setTime), userInfo: nil, repeats: true)
    case .score:
      titleLabel.text = "Acertaste \(viewModel.rounds.filter({$0.result == true}).count) / \(viewModel.rounds.count) rondas"
      scoreLabel.text = "FIN"
      gameButton.setTitle("Reiniciar", for: .normal)
      viewModel.resetTimer()
    }
  }

  func fillUI(){
    gameButton.backgroundColor = .blue
    gameButton.setTitleColor(.white, for: .normal)
    gameButton.layer.cornerRadius = 5.0
    gameButton.titleLabel?.font = .systemFont(ofSize: 12)

    titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
    scoreLabel.font = .systemFont(ofSize: 12)
    timerLabel.font = .systemFont(ofSize: 12)
  }

  func check(this emoji: String){
    viewModel.checkResult(this: emoji)
    newRound()
    collectionView.reloadData()
  }

  func newRound() {
    if !viewModel.isFinished {
      viewModel.newRound()
      scoreLabel.text = "\(viewModel.rounds.filter({$0.result == true}).count) / \(viewModel.rounds.count)"
      titleLabel.text = "Busca \(viewModel.selectedEmoji)"
      collectionView.reloadData()
    }
  }

  @objc func setTime(){
    let (minutes, seconds, finish) = viewModel.getTime()
    timerLabel.text = "\(String(format: "%02i:%02i", minutes, seconds))"
    if finish{
      setupUI()
    }
  }

  @IBAction func buttonPressed(_ sender: Any) {
    viewModel.changeStatus()
    setupUI()
  }
}

extension GameController: UICollectionViewDelegate, UICollectionViewDataSource{
      func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }

      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.board.count
      }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as? EmojiCell else {
          fatalError("algo has hecho mal")
        }
        cell.emoji = viewModel.board[indexPath.row]
        cell.setupUI()
        return cell
      }
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        check(this: viewModel.board[indexPath.row])
      }
}

extension GameController: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 5
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing * 2 * 5
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)
    }
}
