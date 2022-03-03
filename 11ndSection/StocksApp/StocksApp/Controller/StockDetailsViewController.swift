//
//  StockDetailsViewController.swift
//  Stocks
//
//  Created by Sabir Myrzaev on 25.11.2021.
//
import SafariServices
import UIKit

class StockDetailsViewController: UIViewController {

    // MARK: - Properties
     
    private let symbol: String
    private let companyName: String
    private var candleStickData: [CandleStick]
    
    private let tableView: UITableView = {
        let table = UITableView()

        return table
    }()
    
    private var metrics: Metrics?
    
    // MARK: - Init
    
    init(symbol: String, companyName: String, candleStickData: [CandleStick] = []) {
        self.symbol = symbol
        self.companyName = companyName
        self.candleStickData = candleStickData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = companyName
        setUpCloseButton()
        // Show View
        setUpTable()
        fetchFinancialData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Private
    
    private func setUpCloseButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapClose))
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setUpTable() {
        view.addSubview(tableView)

        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: (view.width * 0.7) + 100))
    }
    
    private func fetchFinancialData() {
        let group = DispatchGroup()
        
        // Fetch candle stick if needed
        if candleStickData.isEmpty {
            group.enter()
            APICaller.shared.marketData(for: symbol) { [weak self] result in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let response):
                    self?.candleStickData = response.candleStrick
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        // Fetch financial metrics
        group.enter()
        APICaller.shared.financialMetrics(for: symbol) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let response):
                let metrics = response.metric
                self.metrics  = metrics
            case .failure(let error):
                print(error)
            }
        }
        group.notify(queue: .main) {[weak self] in
            self?.renderChart()
        }
    }
    
    private func renderChart() {
        // Chart VM
        let headerView = StockDetailHeaderView(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: view.width,
                                                             height: (view.width * 0.7) + 100
            )
        )

        var viewModels = [MetricCollectionViewCell.ViewModel]()
        if let metrics = metrics {
            viewModels.append(.init(name: "52W High", value: "\(metrics.AnnualWeekHigh)"))
            viewModels.append(.init(name: "52W Low", value: "\(metrics.AnnualWeekLow)"))
            viewModels.append(.init(name: "52W Return", value: "\(metrics.AnnualWeekPriceReturnDaily)"))
            viewModels.append(.init(name: "Beta", value: "\(metrics.beta)"))
            viewModels.append(.init(name: "10D Vol.", value: "\(metrics.TenDayAverageTradingVolume)"))
        }
        
        // Configure
        let change = getchangePercentage(symbol: symbol, for: candleStickData)
        
        headerView.configure(
            chartViewModel: .init(data: candleStickData.reversed().map { $0.close },
                                  showLegend: true,
                                  showAxis: true,
                                  fillColor: change < 0 ? .systemRed : .systemGreen),
            metricViewModels: viewModels)
        tableView.tableHeaderView = headerView
    }
    
    private func getchangePercentage(symbol: String, for data: [CandleStick]) -> Double {
        let latestDate = data[0].date
        guard let latestClose = data.first?.close,
              let priorClose = data.first(where: {
                !Calendar.current.isDate($0.date, inSameDayAs: latestDate)
              })?.close else { return 0 }
        let diff = 1 - (priorClose/latestClose)
        print("\(symbol): \(diff)%")
        return diff
    }
}

