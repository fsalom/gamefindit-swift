//
//  ViewModel.swift
//  memorize
//
//  Created by Fernando Salom Carratala on 23/6/22.
//

import Foundation

enum Status {
  case start
  case playing
  case score
}

enum TypeOfGame {
  case timer
  case bulleyes
  case endurance
}

final class GameViewModel {
    // MARK: - Properties
    var emojis = 25
    var isFinished = false
    var board: [String] = []
    var selectedEmoji = ""
    var selectedEmojiPosition = 0
    var rounds :  [Round] = []
    var seconds = 0
    var timer : Timer?
    var currentStatus: Status = .start
    var type: TypeOfGame = .endurance
}

// MARK: - Life cycle
extension GameViewModel {
  func viewReady() {
    switch type {
    case .timer:
      seconds = 60
    default:
      seconds = 0
    }
  }

  func viewDidAppear() {
  }
}

// MARK: - Functions
extension GameViewModel {
  func newRound(){
    selectedEmoji = randomEmoji()
    selectedEmojiPosition = Int.random(in: 0..<emojis)

    board = []
    for index in 0...emojis - 1 {
      let emoji = index == selectedEmojiPosition ? selectedEmoji : randomEmoji()
      board.append(emoji)
    }
  }

  func resetTimer(){
    timer?.invalidate()
    self.timer = nil
    switch type{
    case .timer:
      seconds = 60
    default:
      seconds = 0
    }
  }

  func checkResult(this emoji: String){
    let success = selectedEmoji == emoji
    rounds.append(Round(result: success))
    newRound()
  }

  func getTime() -> (Int, Int, Bool){
    var finish = false
    switch type {
    case .timer:
      seconds -= 1
      if seconds == 0{
        finish = true
      }
    case .endurance:
      seconds += 1
    case .bulleyes:
      seconds += 1
      if rounds.filter({$0.result == true}).count == 3 {
        finish = true
      }
    }
    if finish {
      isFinished = true
      changeStatus()
    }
    let minute = Int(seconds) / 60 % 60
    let second = Int(seconds) % 60
    return (minute, second, finish)
  }

  func changeStatus() {
    switch currentStatus {
    case .start:
      currentStatus = .playing
    case .playing:
      currentStatus = .score
    case .score:
      currentStatus = .start
    }
  }

  func randomEmoji() -> String {
      let emojiStart = 0x1F601
      let ascii = emojiStart + Int(arc4random_uniform(UInt32(35)))
      let emoji = UnicodeScalar(ascii)?.description
      return emoji ?? "x"
  }
}

