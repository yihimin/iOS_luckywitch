import UIKit

class NumberViewController: UIViewController {

    @IBOutlet weak var tensLabel: UILabel! // 십의 자리 라벨
    @IBOutlet weak var onesLabel: UILabel! // 일의 자리 라벨
    @IBOutlet weak var resultLabel: UILabel! // 최종 숫자 라벨
    @IBOutlet weak var spinButton: UIButton! // 확인하기/다시하기 버튼

    private var isSpinning = false // 회전 상태 확인

    @IBAction func spinNumbers(_ sender: UIButton) {
        if isSpinning {
            resetNumbers() // 다시하기 클릭 시 초기화
        } else {
            startSpin() // 확인하기 클릭 시 숫자 회전 시작
        }
    }

    private func startSpin() {
        isSpinning = true
        spinButton.setTitle("다시하기", for: .normal) // 버튼 텍스트 변경
        resultLabel.text = "행운의 숫자는?" // 최종 숫자 라벨 초기화

        // 십의 자리 애니메이션
        spinLabel(label: tensLabel, duration: 2.0) { [weak self] finalTens in
            guard let self = self else { return }
            // 일의 자리 애니메이션
            self.spinLabel(label: self.onesLabel, duration: 2.0) { finalOnes in
                // 최종 숫자 결정
                let finalNumber = finalTens * 10 + finalOnes
                self.resultLabel.text = "\(finalNumber)!" // 최종 숫자 업데이트
            }
        }
    }

    private func spinLabel(label: UILabel, duration: Double, completion: @escaping (Int) -> Void) {
        var timer: Timer?
        var currentValue = 0
        let startTime = Date()
        let endTime = startTime.addingTimeInterval(duration) // 종료 시간

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            currentValue = (currentValue + 1) % 10 // 0~9 반복
            label.text = "\(currentValue)"

            let elapsedTime = Date().timeIntervalSince(startTime)
            if elapsedTime >= duration { // 종료 시간 도달
                timer?.invalidate()
                let finalValue = Int.random(in: 0...9) // 랜덤 최종 값
                label.text = "\(finalValue)"
                completion(finalValue)
            }
        }
    }

    private func resetNumbers() {
        isSpinning = false
        spinButton.setTitle("확인하기", for: .normal) // 버튼 텍스트 초기화
        tensLabel.text = "0" // 십의 자리 초기화
        onesLabel.text = "0" // 일의 자리 초기화
        resultLabel.text = "행운의 숫자는?" // 결과 초기화
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        resetNumbers() // 초기화
    }
}
