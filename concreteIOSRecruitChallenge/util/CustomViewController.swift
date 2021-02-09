//
//  CustomViewController.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 08-02-21.
//

import UIKit

class CustomViewController: UIViewController {
    
    //MARK: Outlets

    @IBOutlet var loadingView: UIView?
    @IBOutlet var noDataLabel: UILabel?
    @IBOutlet var netErrorLabel: UILabel?
    @IBOutlet var reloadButton: UIButton?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    //MARK: Global Variables

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func onLoading(_ mainView: UIView){
        self.loadingView?.isHidden = false
        self.activityIndicator?.isHidden = false
        self.reloadButton?.isHidden = true
        self.noDataLabel?.isHidden = true
        self.netErrorLabel?.isHidden = true
        mainView.isHidden = true
    }
    func onSuccess(_ mainView: UIView){
        self.loadingView?.isHidden = true
        self.activityIndicator?.isHidden = true
        self.reloadButton?.isHidden = true
        self.noDataLabel?.isHidden = true
        self.netErrorLabel?.isHidden = true
        mainView.isHidden = false
    }
    func onNoData(_ mainView: UIView){
        self.loadingView?.isHidden = false
        self.activityIndicator?.isHidden = true
        self.reloadButton?.isHidden = false
        self.noDataLabel?.isHidden = false
        self.netErrorLabel?.isHidden = true
        mainView.isHidden = true
    }
    func onFailure(_ mainView: UIView){
        self.loadingView?.isHidden = false
        self.activityIndicator?.isHidden = true
        self.reloadButton?.isHidden = false
        self.noDataLabel?.isHidden = true
        self.netErrorLabel?.isHidden = false
        mainView.isHidden = true
    }

}
