import SwiftUI

struct Arc: Shape {
    /// 円弧の開始角度
    var startAngle: Angle
    
    /// 円弧の終了角度
    var endAngle: Angle
    
    /// 描画方向（trueで時計回り）
    var clockwise: Bool = true

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        // パスに円弧を追加する
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            // SwiftUIのaddArcは反時計回りが基準のため、直感的な時計回りの指定とは逆にする
            clockwise: !clockwise
        )
        
        return path
    }
}
