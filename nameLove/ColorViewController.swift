import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var rouletteImageView: UIImageView! // 룰렛 이미지
    @IBOutlet weak var resultLabel: UILabel! // 결과 라벨

    @IBAction func spinRoulette(_ sender: UIButton) {
        let fullRotation = CGFloat(Double.pi * 2) // 한 바퀴(360도)
        let randomRotation = CGFloat.random(in: 0...(fullRotation)) // 랜덤 회전 각도
        
        // 회전 애니메이션
        UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseOut, animations: {
            self.rouletteImageView.transform = CGAffineTransform(rotationAngle: randomRotation)
        }) { _ in
            self.calculateColor(from: randomRotation) // 회전이 끝난 후 결과 계산
        }
    }

    func calculateColor(from angle: CGFloat) {
        // 룰렛 색상 배열 (색상 순서대로 설정)
        let colors = ["초록", "노랑", "연노랑", "주황", "빨강", "진빨강", "보라", "파랑", "연파랑"]
        let sectionAngle = CGFloat(Double.pi * 2) / CGFloat(colors.count) // 한 섹션의 각도
        
        // 현재 각도에서 색상 인덱스 계산
        let normalizedAngle = angle.truncatingRemainder(dividingBy: CGFloat(Double.pi * 2)) // 0 ~ 2π로 정규화
        let selectedIndex = Int(normalizedAngle / sectionAngle) % colors.count // 색상 인덱스 계산
        
        // 결과 업데이트
        let selectedColor = colors[selectedIndex]
        resultLabel.text = "오늘의 행운의 색깔은 \(selectedColor)입니다!"
    }
}
