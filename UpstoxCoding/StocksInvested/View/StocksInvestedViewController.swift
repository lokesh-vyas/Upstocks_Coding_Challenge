//
//  StocksInvestedViewController.swift
//  UpstoxCoding
//
//  Created by Lokesh Vyas on 03/03/22.
//

import UIKit

class StocksInvestedViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var totalCurrentValue: UILabel!
    
    @IBOutlet weak var lblTotalPL: UILabel!
    @IBOutlet weak var lblTodayPL: UILabel!
    @IBOutlet weak var totalInvestment: UILabel!
    private var viewModel : SIViewModel = {
        let viewModel = SIViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
        viewModel.delegate = self
        viewModel.fetchAllData()
        // Do any additional setup after loading the view.
    }
    
    private func registerTableViewCells() {
        let holdingCell = UINib(nibName: "HoldingCell",
                                  bundle: nil)
        self.detailTableView.register(holdingCell,
                                forCellReuseIdentifier: "HoldingCell")
        self.detailTableView.dataSource = self
        self.detailTableView.delegate = self
        detailTableView.rowHeight = 80
        detailTableView.estimatedRowHeight = 80
        self.detailTableView.reloadData()
    }
}


extension StocksInvestedViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.listOfHoldingData?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HoldingCell", for: indexPath) as! HoldingCell
        cell.cellData = viewModel.listOfHoldingData?.data[indexPath.row]
        cell.setPLData = viewModel.getPL(row: indexPath.row)
        return cell
    }
}

extension StocksInvestedViewController : SIVMProtocol {
    func didSuccess() {
        DispatchQueue.main.async {
            self.detailTableView.reloadData()
            self.totalInvestment.text = "₹\(self.viewModel.totalInvestment)"
            self.totalCurrentValue.text = "₹\(self.viewModel.getSumOfCurrentValue)"
            self.lblTotalPL.text = "₹\(self.viewModel.totalPNL)"
            self.lblTodayPL.text = "₹\(self.viewModel.todayPNL)"
        }
    }
    
    func didFail() {
        // Failure condition
    }
}
