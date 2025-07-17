import Foundation
import Combine

class Stopwatch: ObservableObject {
    /// 経過時間（UIに変更を通知）
    @Published var time: Double = 0.0
    
    /// タイマーの実行状態（UIに変更を通知）
    @Published var isRunning: Bool = false
    
    private let timeInterval: Double = 0.01
    private var cancellable: AnyCancellable?


    /// タイマーを開始する
    func start() {
        print("start")
        // 実行中であれば何もしない
        guard isRunning else { return }
        
        isRunning = true
        
        cancellable = Timer.publish(every: timeInterval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                // メモリリークを避けるために weak self を使用
                guard let self = self else { return }
                self.time += self.timeInterval
            }
    }

    /// タイマーを停止する
    func stop() {
        isRunning = false
        cancellable?.cancel()
    }

    /// タイマーをリセットする
    func reset() {
        print("reset")
        stop()
        time = 0.0
    }
}
