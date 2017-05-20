//
//  VisualizarTermoUso.swift
//  Sumus Analitics
//
//  Created by kassiano Resende on 20/05/17.
//  Copyright © 2017 MyBi. All rights reserved.
//

import UIKit

class VisualizarTermoUso: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "toolbar-background.png")!.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        
    
        
        activity.startAnimating()
        self.webView.delegate = self
        
        
        let logo = UIImage(named: "toolbar_logo1")
        let imageView = UIImageView(image:logo)
        //navItemTitulo.titleView = imageView
        
        leftBarButtonItem.customView = imageView
        
        
        //load a file
        let testHTML = Bundle.main.url(forResource: "termo_adesao", withExtension: "html")
        
        let myRequest = NSURLRequest(url: testHTML!)
        webView.loadRequest(myRequest as URLRequest)
        
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView){
        
        print("init request")
        // self.webView.isHidden = true
        // self.progressBarDisplayer(msg: "Aguarde..", true)
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        
        activity.stopAnimating()
        print("finish request")
    
    }

    @IBAction func voltar(_ sender: Any) {
        let navHelper = NavHelper()
        navHelper.presentBemVindo(on: self)
    }

}
