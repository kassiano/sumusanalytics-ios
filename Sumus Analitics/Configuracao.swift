//
//  ConfigViewController.swift
//  Sumus Analitics
//
//  Created by kassiano Resende on 16/03/17.
//  Copyright © 2017 MyBi. All rights reserved.
//


import UIKit
import Alamofire

class Configuracao: UIViewController
{

    @IBOutlet weak var logoLeftButton: UIBarButtonItem!
    @IBOutlet weak var btnConectar: UIButton!
    
    @IBOutlet weak var txtNumeroSerie: UITextField!
    var progressBarHelper:ProgressBarHelper!

    @IBOutlet weak var btnDesconectar: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
   
    @IBOutlet weak var btnVoltar: UIBarButtonItem!
    
    
    var navHelper : NavHelper?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navHelper = NavHelper()
        
        scrollView.layer.cornerRadius = 10;
        btnConectar.layer.cornerRadius = 10;
        btnDesconectar.layer.cornerRadius = 10;
        
        self.progressBarHelper = ProgressBarHelper(self.view)
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "toolbar-background.png")!.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        
       
        let logo = UIImage(named: "toolbar_logo1")
        let imageView = UIImageView(image:logo)
        logoLeftButton.customView = imageView
        
        
        
        if let linkConexao = UserDefaults.standard.string(forKey: "linkConexao")
        {
            if !linkConexao.isEmpty {
            
                btnDesconectar.isHidden = false
                btnConectar.isHidden = true
            
                enableDisableVoltar(disable: false)
            }else{
                    enableDisableVoltar(disable: true)
            }
        }else{
            enableDisableVoltar(disable: true)
        }
        
        if let numeroSerie = UserDefaults.standard.string(forKey: "numeroSerie"){
            
            if !numeroSerie.isEmpty{
                self.txtNumeroSerie.text = numeroSerie
            }
            
        }
        
        
        print ("Running did load")
    }
    
    
    
    @IBAction func actionConectar(_ sender: Any) {
    
        //btnConectar.isEnabled = false
    
        
        if txtNumeroSerie.text!.isEmpty {
            numeroInvalido()
            return
        }
        
        
        let alert = DialogHelper();
        alert.create(titulo: "Conectando...", mensagem: nil)
        
        alert.addAction(acao: UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }));
        
        alert.showWithActivityIndicator(viewController: self)
        
        
        
        self.checkSerialNumber(alert: alert)
        
        /*
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
        
            group.leave()
            /*
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                // Put your code which should be executed with a delay here
            })
             */
        }
        
        group.notify(queue: .main) {
            alert.dismiss(viewController: self)
        }
        */
        
    }
    
    
    func checkSerialNumber(alert:DialogHelper){
        
        
        
        //Alamofire.request("http://ativacao.sumusti.com.br:8081/?serie=\(txtNumeroSerie.text!)").
        
        Alamofire.request("http://services.sumusti.com.br/app/analytics/customer/\(txtNumeroSerie.text!)").response { response in
           
            //{"success":true,"data":{"serverAddress":"192.168.100.200","serverPort":8080}}
            alert.dismiss(viewController: self)
        
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            
            if let data = response.data, let retornoServer = String(data: data, encoding: .utf8) {
            
                
                //let result = retornoServer.trimmingCharacters(in: .whitespacesAndNewlines)
            
                let dicionario =  DictionaryHelper.convertStringToDictionary(text: retornoServer)
                
        
                if dicionario?["data"] as? String == "ERRO" {
                    
                    self.numeroInvalido()
                    
                }else{
                
        
                    let serverAddress:String = (dicionario?["data"]?["serverAddress"] as? String)!
                    let serverPort:String = (dicionario?["data"]?["serverPort"] as? NSNumber)!.description
                    let linkConexao = serverAddress + ":" + serverPort
                    
                    UserDefaults.standard.set(self.txtNumeroSerie.text , forKey: "numeroSerie")
                    UserDefaults.standard.set(linkConexao , forKey: "linkConexao")
                    UserDefaults.standard.set(false , forKey: "primeiroAcesso")
                    
                    self.btnConectar.isHidden = true
                    self.btnDesconectar.isHidden = false
                    
                    self.numeroValido()
                
                    
                    print("serverAddress: \(serverAddress)")
                    print("serverPort: \(linkConexao)")
                
                }
                
                
            }else{
                self.falhaConexao()
            }
        }
    
    }
    
    
    func falhaConexao(){
        
        let alert = DialogHelper();
        alert.create(titulo: "Falha na conexão!", mensagem: "Verifique se você está conectado a internet e tente novamente.")
        
        alert.addAction(acao: UIAlertAction(title: "ok", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }));
        
        alert.show(viewController: self)
    }
    
    func numeroValido(){
        
        let alert = DialogHelper();
        alert.create(titulo: "Sucesso!", mensagem: "Número de série válido. Conexão realizada com êxito.")
        
        alert.addAction(acao: UIAlertAction(title: "ok", style: .cancel, handler: { (action: UIAlertAction!) in
            

            self.navHelper?.presentLogin(on : self)
            
        }));
        
        alert.show(viewController: self)
        
    }
    
    func numeroInvalido(){
        
        let alert = DialogHelper();
        alert.create(titulo: "Número inválido!", mensagem: "Número de série incorreto. Favor inserir um número de série válido.")
        
        alert.addAction(acao: UIAlertAction(title: "cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }));
        
        alert.show(viewController: self)
        
    }
    
    @IBAction func actionVoltar(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func desconectar(_ sender: UIButton) {
        
        let alert = DialogHelper();
        alert.create(titulo: "Deconectando...", mensagem: nil)
        
        alert.addAction(acao: UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }));
        
        alert.showWithActivityIndicator(viewController: self)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            // Put your code which should be executed with a delay here
            
            
            alert.dismiss(viewController: self)
            
            UserDefaults.standard.set("", forKey: "numeroSerie")
            UserDefaults.standard.set("" , forKey: "linkConexao")
            
            self.txtNumeroSerie.text = ""
            
            self.btnConectar.isHidden = false
            self.btnDesconectar.isHidden = true
            
            alert.create(titulo: "Desconectado!", mensagem: "O Sumus Analytics não está mais conectado a sua base de dados.")
            
            alert.addAction(acao: UIAlertAction(title: "ok", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }));
            
            alert.show(viewController: self)
            
            self.enableDisableVoltar(disable: true)
          
            
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
