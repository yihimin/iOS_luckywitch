//
//  ViewController.swift
//  nameLove
//
//  Created by Dahyun on 11/28/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var yourName: UITextField! // 내 이름 입력 필드
    @IBOutlet weak var partnerName: UITextField! // 상대 이름 입력 필드
    @IBOutlet weak var resultLabel: UILabel! // 결과 표시 라벨
    
    @IBAction func nameButtonTapped(_ sender: UIButton) {
        // 이름 입력 여부 확인
        guard let yourName = yourName.text, !yourName.isEmpty,
              let partnerName = partnerName.text, !partnerName.isEmpty else {
            resultLabel.text = "이름을 모두 입력해주세요!"
            return
        }
        
        // 궁합 점수 계산
        let compatibility = calculateCompatibility(yourName: yourName, partnerName: partnerName)
        resultLabel.text = "궁합 점수는 \(compatibility)%입니다!"
    }
    
    // 궁합 점수 계산 메서드
    func calculateCompatibility(yourName: String, partnerName: String) -> Int {
        let yourValue = yourName.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        let partnerValue = partnerName.unicodeScalars.reduce(0) { $0 + Int($1.value) }
        return (yourValue + partnerValue) % 101
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
