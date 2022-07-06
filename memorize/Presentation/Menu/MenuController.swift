//
//  MenuController.swift
//  memorize
//
//  Created by Fernando Salom Carratala on 23/6/22.
//

import UIKit

class MenuController: UIViewController {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var option1Button: UIButton!
  @IBOutlet weak var option2Button: UIButton!
  @IBOutlet weak var option3Button: UIButton!

  var viewModel: MenuViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    fillUI()
    animateTitle()
    // Do any additional setup after loading the view.
  }
  @IBAction func option1Pressed(_ sender: Any) {
    let game = Container.shared.gameBuilder().build()
    game.viewModel.type = .timer
    Container.shared.window?.rootViewController = game
    Container.shared.window?.makeKeyAndVisible()
  }
  @IBAction func option2Pressed(_ sender: Any) {
    let game = Container.shared.gameBuilder().build()
    game.viewModel.type = .bulleyes
    Container.shared.window?.rootViewController = game
    Container.shared.window?.makeKeyAndVisible()
  }
  @IBAction func option3Pressed(_ sender: Any) {
    let game = Container.shared.gameBuilder().build()
    game.viewModel.type = .endurance
    Container.shared.window?.rootViewController = game
    Container.shared.window?.makeKeyAndVisible()
  }
}
//MARK: - UI
extension MenuController{
  func fillUI() {
    custom(this: option1Button, with: "Contrareloj")
    custom(this: option2Button, with: "Acierto")
    custom(this: option3Button, with: "Resistencia")
    titleLabel.text = "Empieza \nel juego"
  }

  func animateTitle(){
    UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveLinear, animations: {
        self.titleLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }) { _ in
      UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveLinear, animations: {
          self.titleLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
      }) { _ in
        self.animateTitle()
      }

    }
  }

  func custom(this button: UIButton, with title: String){
    button.layer.cornerRadius = 5.0
    button.setTitle(title, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 12)
    button.backgroundColor = .blue
    button.setTitleColor(.white, for: .normal)
  }
}

//MARK: - actions
extension MenuController{

}
