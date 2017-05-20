//
//  ViewController.swift
//  Sumus Analitics
//
//  Created by kassiano Resende on 15/03/17.
//  Copyright © 2017 MyBi. All rights reserved.
//

import UIKit
import Alamofire

class Login: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var txtLogin: UITextField!
    
    @IBOutlet weak var txtSenha: UITextField!
    
    @IBOutlet weak var switchConectado: UISwitch!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var btnLogin: UIButton!
    
    
    @IBOutlet weak var navItemTitulo: UINavigationItem!
    
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    
    var numeroDeSerie = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        scrollView.layer.cornerRadius = 10;
        btnLogin.layer.cornerRadius = 10;
        
        
        let usuario = UserDefaults.standard.string(forKey: "usuario")
        let senha = UserDefaults.standard.string(forKey: "senha")
        // let imagem = NSUserDefaults.standardUserDefaults().stringForKey("imagem")
        let save = UserDefaults.standard.bool(forKey: "save")
        let cor = UserDefaults.standard.string(forKey: "cor")
        
        
        if let nSerie = UserDefaults.standard.string(forKey: "numeroSerie")
        {
            numeroDeSerie = nSerie
        }
        
    
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "toolbar-background.png")!.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        
        
        let logo = UIImage(named: "toolbar_logo1")
        let imageView = UIImageView(image:logo)
        //navItemTitulo.titleView = imageView
        
        leftBarButtonItem.customView = imageView
    
        
        //VERIFICAR SE EXISTE NUMERO DE SERIE VALIDO
        
        
        ///
        
        txtLogin.delegate = self
        txtSenha.delegate = self
        
        
        scrollView.contentSize.height=400;
        
        
        txtLogin.text = usuario
        txtSenha.text = senha
        switchConectado.isOn = save
        
        
        if let corBarra = cor  {
            
            if !corBarra.isEmpty{
                
                UINavigationBar.appearance().barTintColor = Utils.hexStringToUIColor(hex: corBarra)
            }
        }
    }

   

    func falhaAutenticacao(){
        
        // contents could not be loaded
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Falha na autenticação"
        alertView.message = "Usuário ou senha inválidos"
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        alertView.show()
    }
    
        
    
    
    @IBAction func efetuarLogin(sender: UIButton) {
        
        
        if txtLogin!.text!.isEmpty || txtSenha!.text!.isEmpty{
        
            self.falhaAutenticacao()
            return
        }
        
        
        btnLogin.isEnabled = false
        
        
        let alert = DialogHelper();
        alert.create(titulo: "Conectando...", mensagem: nil)
        
        alert.addAction(acao: UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }));
        
        alert.showWithActivityIndicator(viewController: self)
        
        
        DispatchQueue.main.async {
            self.login(alert)
        
        }
    }
    
    
    func login(_ alert: DialogHelper){
        
        var linkConexao = UserDefaults.standard.string(forKey: "linkConexao")
        
        let parameters: Parameters = [
            "userLogin": txtLogin!.text!,
            "userPassword": txtSenha.text!,
            "page" : "Init"
        ]
        
        
        if !linkConexao!.hasPrefix("http"){
            linkConexao = "http://" + linkConexao!
        }
        
        print(linkConexao!)
        
        let dados = DadosCliente()
        
        Alamofire.request(linkConexao! + "/sumus-web/analytics" , method: .post, parameters: parameters)
        .response { response in
            
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            
            
                if utf8Text.trimmingCharacters(in: .whitespacesAndNewlines) == "ERRO"{
                    
                    alert.dismiss(viewController: self)
                    print("Falha autenticação")
                    self.falhaAutenticacao()
                    self.btnLogin.isEnabled = true
                    
                }else{
                
                    self.btnLogin.isEnabled = true
                    
                    dados.url = linkConexao! + "/sumus-web/analytics"
                    dados.usuario = self.txtLogin.text!
                    dados.senha = self.txtSenha.text!

                    if self.switchConectado.isOn {
                        
                        UserDefaults.standard.set(dados.usuario , forKey: "usuario")
                        UserDefaults.standard.set(dados.senha  , forKey: "senha")
                        UserDefaults.standard.set(true , forKey: "save")
                        
                    }else{
                        
                        UserDefaults.standard.set("", forKey: "usuario")
                        UserDefaults.standard.set("" , forKey: "senha")
                        UserDefaults.standard.set(false , forKey: "save")
                    }
                    
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ViewPrincipal") as! Principal
                    
                    vc.dados = dados
                    
                    
                    //self.navigationController?.pushViewController(vc, animated: true)
                    
                    alert.dismiss(viewController: self)
                    self.present(vc, animated: true, completion: nil)
                
                }
            
                
            }
            
        }
        
     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    

    

}

