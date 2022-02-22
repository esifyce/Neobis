import UIKit
import SnapKit

class TimerStopwatchViewController: UIViewController {
    
    // MARK: - properties
    private var isActive = false
    
    var viewModel: TimerModelType?
    
    // MARK: - Views and Layout properties
    private lazy var timerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "timer")
        imageView.tintColor = .black
       
        return imageView
    }()
    
    private lazy var segmentedControlView: UISegmentedControl = {
        let items = ["Stopwatch", "Timer"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = .zero
        
        segmentedControl.addTarget(self, action: #selector(suitDidChange(_:)), for: .valueChanged)
        
        return segmentedControl
    }()
    
    private lazy var clockLabelView: UILabel = {
        let clockLabel = UILabel()
        clockLabel.text = "00:00:00"
        clockLabel.font = UIFont.systemFont(ofSize: 75)
        clockLabel.textAlignment = .center
                
        return clockLabel
    }()
    
    private lazy var stopButtonView: UIButton = {
        let stopButton = UIButton(type: .system)
        stopButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 80), forImageIn: .normal)
        stopButton.tintColor = .black
        stopButton.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
        
        stopButton.addTarget(self, action: #selector(toggleStatusButton), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopCountingTimer), for: .touchUpInside)
        
        return stopButton
    }()
    
    private lazy var pauseButtonView: UIButton = {
        let pauseButton = UIButton(type: .system)
        pauseButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 80), forImageIn: .normal)
        pauseButton.tintColor = .black
        pauseButton.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        
        pauseButton.addTarget(self, action: #selector(toggleStatusButton), for: .touchUpInside)
        pauseButton.addTarget(self, action: #selector(pauseCountingTimer), for: .touchUpInside)
        
        return pauseButton
    }()
    
    private lazy var playButtonView: UIButton = {
        let playButton = UIButton(type: .system)
        playButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 80), forImageIn: .normal)
        playButton.tintColor = .black
        playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        
        playButton.addTarget(self, action: #selector(toggleStatusButton), for: .touchDown)
        playButton.addTarget(self, action: #selector(startCountingStopwatch), for: .touchUpInside)
        
        return playButton
    }()
    
    private lazy var datePickerView: UIPickerView = {
        let timePicker = UIPickerView()
                
        timePicker.delegate = self
        timePicker.dataSource = self
        
        return timePicker
    }()
    
    // MARK: - lifecycle vc
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        // pass to every elements for show on screen
        setSubviews()
        setConstraints()
        
        // first view timer therefore isHidden = true
        datePickerView.isHidden = true
        
        viewModel = TimerViewModel()
    }
    
    // add subviews in view
    private func setSubviews() {
        view.addSubview(timerImageView)
        view.addSubview(segmentedControlView)
        view.addSubview(clockLabelView)
        view.addSubview(stopButtonView)
        view.addSubview(pauseButtonView)
        view.addSubview(playButtonView)
        view.addSubview(datePickerView)
    }
    
    // assign contraints in subviews
    private func setConstraints() {
        
        timerImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(80)
        }
        
        segmentedControlView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(timerImageView.snp.top).inset(100)
        }
        
        clockLabelView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(segmentedControlView.snp.top).inset(50)
        }
        
        stopButtonView.snp.makeConstraints {
            $0.left.equalTo(40)
            $0.width.height.equalTo(80)
            $0.top.equalTo(datePickerView.snp.bottom).offset(10)
        }
        
        pauseButtonView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(80)
            $0.top.equalTo(datePickerView.snp.bottom).offset(10)
        }
        
        playButtonView.snp.makeConstraints {
            $0.right.equalToSuperview().inset(40)
            $0.width.height.equalTo(80)
            $0.top.equalTo(datePickerView.snp.bottom).offset(10)
        }
        
        datePickerView.snp.makeConstraints {
            $0.top.equalTo(clockLabelView.snp.top).inset(60)
            $0.right.left.equalToSuperview().inset(20)
        }
        
    }
    
    // MARK: - Active @objc func
    
    @objc func suitDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            viewModel?.resetInval()
            timerImageView.image = UIImage(systemName: "stopwatch")
            datePickerView.isHidden = true
            
            // for replace new target
            self.playButtonView.removeTarget(self, action: .none, for: .touchUpInside)
            
            // add new target
            playButtonView.addTarget(self, action: #selector(startCountingStopwatch), for: .touchUpInside)
        default:
            viewModel?.resetInval()
            timerImageView.image = UIImage(systemName: "timer")
            datePickerView.isHidden = false
            
            // for replace new target
            self.playButtonView.removeTarget(self, action: .none, for: .touchUpInside)
            
            // add new target
            playButtonView.addTarget(self, action: #selector(startCountingTimer), for: .touchUpInside)
        }
    }
    
    // for changes button when clicked
    @objc func toggleStatusButton() {
        
        if stopButtonView.isTouchInside {
            stopButtonView.setImage(UIImage(systemName: "stop.circle"), for: .normal)
            pauseButtonView.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            playButtonView.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        } else if pauseButtonView.isTouchInside {
            stopButtonView.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
            pauseButtonView.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            playButtonView.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        } else if playButtonView.isTouchInside {
            stopButtonView.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
            pauseButtonView.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            playButtonView.setImage(UIImage(systemName: "play.circle"), for: .normal)
        } else {
            stopButtonView.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
            pauseButtonView.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            playButtonView.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
    }
    
    // MARK: - start Stopwatch
    @objc func startCountingStopwatch() {
        viewModel?.stopCount()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.viewModel?.startStopwatch()
        }
        
        viewModel?.clockText.bind { [weak self] str in
            self?.clockLabelView.text = str
        }
}
    
    // MARK: - start Timer
    @objc func startCountingTimer() {
        isActive.toggle()
        
        if isActive == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.viewModel?.startTimer()
            }
            viewModel?.clockText.bind { [weak self] str in
                self?.clockLabelView.text = str
            }
        }
    }
    
    // MARK: - stop and pause
    @objc func pauseCountingTimer() {
        viewModel?.stopCount()
        isActive = false
    }
    
    @objc func stopCountingTimer() {
        viewModel?.resetInval()
        
    }
}
