import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var rouletteImageView: UIImageView! // 룰렛 이미지
    @IBOutlet weak var colorLabel: UILabel! // 색상 라벨
    @IBOutlet weak var fortuneLabel: UILabel! // 메시지 라벨
    @IBOutlet weak var spinButton: UIButton! // 확인하기/다시하기 버튼

    private var isSpinning = false // 회전 상태 확인
    private let colors = ["레몬", "노랑", "주황", "다홍", "빨강", "자주", "보라", "남색", "파랑", "하늘", "초록", "연두"] // 색상 배열
    private let fortunes = [
        "레몬": "새로운 기회가 찾아올 거예요!",
        "노랑": "웃음이 가득한 하루를 보낼 수 있어요.",
        "주황": "열정으로 가득 찬 하루가 될 거예요!",
        "다홍": "주변 사람들과 좋은 관계를 맺게 될 거예요.",
        "빨강": "오늘은 열정이 넘치는 하루가 될 거예요!",
        "자주": "행복한 소식이 찾아올 거예요.",
        "보라": "창의력이 빛을 발하는 하루가 될 거예요.",
        "남색": "평화롭고 차분한 하루를 보낼 수 있어요.",
        "파랑": "문제가 순조롭게 해결될 거예요.",
        "하늘": "자유롭게 당신의 꿈을 펼쳐 보세요.",
        "초록": "긍정적인 에너지가 가득한 하루가 될 거예요!",
        "연두": "희망찬 일이 생길 거예요. 기대해 보세요!"
    ] // 색상별 운세
    private let sectionAngle: CGFloat = 360.0 / 12.0 // 섹션 각도 (360도 / 12색상)

    @IBAction func spinRoulette(_ sender: UIButton) {
        if isSpinning {
            resetRoulette() // 다시하기 클릭 시 초기화
        } else {
            startSpin() // 확인하기 클릭 시 룰렛 회전
        }
    }

    private func startSpin() {
        isSpinning = true
        spinButton.setTitle("다시하기", for: .normal) // 버튼 텍스트 변경

        let fullRotation = CGFloat(360.0) // 한 바퀴(360도)
        let additionalRotations = CGFloat(5) * fullRotation // 5바퀴 추가 회전
        let randomOffset = CGFloat.random(in: 0...(fullRotation)) // 0 ~ 360도 범위의 랜덤 각도

        let finalAngle = additionalRotations + randomOffset // 최종 회전 각도

        // 회전 애니메이션
        UIView.animate(withDuration: 3.0, delay: 0, options: .curveEaseOut, animations: {
            self.rouletteImageView.transform = CGAffineTransform(rotationAngle: finalAngle * CGFloat.pi / 180) // 각도를 라디안으로 변환
        }) { _ in
            self.calculateColor(from: randomOffset) // 회전 완료 후 색상 계산
        }
    }

    private func calculateColor(from angle: CGFloat) {
        // 각도를 정규화 (0 ~ 360도)
        let normalizedAngle = angle.truncatingRemainder(dividingBy: 360.0)

        // 섹션 인덱스 계산
        let adjustedAngle = 360.0 - normalizedAngle // 시계 방향 보정
        let selectedIndex = Int(adjustedAngle / sectionAngle) % colors.count

        // 선택된 색상과 운세 메시지
        let selectedColor = colors[selectedIndex]
        let fortuneMessage = fortunes[selectedColor] ?? "행운이 함께할 거예요!" // 기본 메시지

        // 결과 업데이트
        colorLabel.text = selectedColor
        fortuneLabel.text = fortuneMessage
    }

    private func resetRoulette() {
        isSpinning = false
        spinButton.setTitle("확인하기", for: .normal) // 버튼 텍스트 초기화
        colorLabel.text = "?" // 색상 초기화
        fortuneLabel.text = "행운의 메시지 기다리는 중..." // 메시지 초기화

        // 룰렛 위치 초기화
        UIView.animate(withDuration: 0.5) {
            self.rouletteImageView.transform = .identity
        }
    }
}
