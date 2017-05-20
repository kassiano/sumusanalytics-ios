//
//  ViewPrincipal.swift
//  HelloWorld
//
//  Created by kassiano Resende on 15/07/16.
//  Copyright © 2016 kassiano Resende. All rights reserved.
//

import Foundation
import UIKit


class Principal : UIViewController, UIWebViewDelegate{
    
    @IBOutlet weak var webView: UIWebView!
    
    var dados =  DadosCliente()
    
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var btnSair: UIBarButtonItem!
    @IBOutlet weak var btnVoltar: UIBarButtonItem!
    
    let navHelper = NavHelper()
    let alert = DialogHelper()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        self.webView.delegate = self
        
    
        let logo = UIImage(named: "toolbar_logo1")
        let imageView = UIImageView(image:logo)
    
        
        leftBarButtonItem.customView = imageView
    
        print(dados.url)
        
        var request = URLRequest(url: URL(string: dados.url)!)
        request.httpMethod = "POST"
        let postString = "userLogin=\(dados.usuario)&userPassword=\(dados.senha)&page=Init"
        request.httpBody = postString.data(using: .utf8)
        webView.loadRequest(request) //if your `webView` is `UIWebView`
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView){

        
        print("init request")
       
        alert.create(titulo: "Carregando...", mensagem: nil)
        
        alert.addAction(acao: UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
            
            self.webView.stopLoading()
            
            if webView.canGoBack {
                
             //  webView.goBack()
              
            }
            
        }));
        
        alert.showWithActivityIndicator(viewController: self)
    
    
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        
        print("finish request")
        alert.dismiss(viewController: self)
        
    }
    
    
    @IBAction func voltar(_ sender: Any) {
        
        print(webView.request?.url ?? "URL vazia")
        
        
        if webView.canGoBack {
            print("voltando")
            webView.goBack()
        
        }
        
    }
    
    
    
    @IBAction func logOut(_ sender: Any) {
        
        
        alert.create(titulo: "Saindo...", mensagem: nil)
        alert.showWithActivityIndicator(viewController: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            
            self.alert.dismiss(viewController: self)
            self.navHelper.presentLogin(on: self)
        })
        
        
        
    }
    
    
    func enableDisableVoltar(disable:Bool){
        
        if disable{
            btnVoltar.isEnabled = false
            btnVoltar.tintColor = .clear
        }else{
            btnVoltar.isEnabled = true
            btnVoltar.tintColor = .white
        }
    }
    
    
    
}


