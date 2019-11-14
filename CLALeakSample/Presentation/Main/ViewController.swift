//
//  ViewController.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// MARK: - TableView delegate

extension ViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let vc = BuilderImpl().build(.structType)
                present(vc, animated: true, completion: nil)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                let vc = BaseNavigationController(rootViewController: BuilderImpl().build(.structType))
                present(vc, animated: true, completion: nil)
            default:
                break
            }
        default:
            break
        }
    }
}
