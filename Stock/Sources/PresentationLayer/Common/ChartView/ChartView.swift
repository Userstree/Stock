//
// Created by Dossymkhan Zhulamanov on 04.08.2022.
//

import Charts

//    MARK: Render
struct ChartViewModel {
    let data: [Double]
    let showLegend: Bool
    let showAxis: Bool
    let fillColor: UIColor
    let timeInterval: [TimeInterval]
}

class StockChartView: UIView {

    // MARK: - Properties, aka Vars & Lets
    lazy var chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.pinchZoomEnabled = false
        chartView.setScaleEnabled(true)
        chartView.xAxis.enabled = false
        chartView.drawGridBackgroundEnabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false

        return chartView
    }()

    // MARK: - Controller lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        chartView.frame = bounds
    }

    // MARK: - Methods
    func reset() {
        chartView.data = nil
    }

    func configure(with viewModel: ChartViewModel) {
        var entries = [ChartDataEntry]()

        for (index, value) in viewModel.data.enumerated() {
            entries.append(.init(x: Double(index),
                    y: value))
        }
        chartView.rightAxis.enabled = viewModel.showAxis
        chartView.legend.enabled = viewModel.showLegend

        let gradientColors = [UIColor.systemRed.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)

        let dataSet = LineChartDataSet(entries: entries, label: "3 days ")
        dataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90)
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.fillAlpha = 0.2
        dataSet.lineWidth = 1
//        dataSet.fillColor = viewModel.fillColor
        dataSet.drawFilledEnabled = true
        dataSet.drawIconsEnabled = false
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.setColors(.red)

        let data = LineChartData(dataSet: dataSet)
        chartView.data = data
    }

    //    MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chartView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
