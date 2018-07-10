//
//  ViewController.swift
//  print
//
//  Created by Stanislav Astakhov on 10.07.2018.
//  Copyright © 2018 Stanislav Astakhov. All rights reserved.
//

import UIKit
import WebKit

final class ViewController: UIViewController {

    //MARK: Private Properties

    @IBOutlet weak private var webView: WKWebView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!

    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        webView.navigationDelegate = self
    }

    //MARK: Actions

    @IBAction func printView(_ sender: UIBarButtonItem) {
        presentPrintControllerForWebView(webView)
    }

    //MARK: Private Methods

    private func setupUI() {
        let urlString = "https://www.apple.com"
        let title = "Apple inc."

        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)

            self.title = title
            webView.load(request)
            webView.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            activityIndicator.hidesWhenStopped = true
            activityIndicator.color = UIColor.darkGray

        } else {
            print("error")
        }
    }

    private func presentPrintControllerForWebView(_ webView: WKWebView) {
        guard let urlCheck = webView.url
            else {return}

        let pi = UIPrintInfo.printInfo()
        pi.outputType = .general
        pi.jobName = urlCheck.absoluteString
        pi.orientation = .portrait
        pi.duplex = .longEdge

        let printController = UIPrintInteractionController.shared
        printController.printInfo = pi
        printController.printFormatter = webView.viewPrintFormatter()
        printController.present(animated: true, completionHandler: nil)
    }
}

//MARK: Web view methods

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}



