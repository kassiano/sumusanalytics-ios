//
//  BemVindo.swift
//  Sumus Analitics
//
//  Created by kassiano Resende on 20/05/17.
//  Copyright © 2017 MyBi. All rights reserved.
//

import UIKit

class BemVindo: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "toolbar-background.png")!.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        

        
    }

    @IBAction func ver_termo_uso(_ sender: UIButton) {
        
        let navHelper = NavHelper()
        navHelper.presentTermoUso(on : self)
    }
    
    
    

    
    @IBAction func concordar_continuar(_ sender: UIButton) {
        
        UserDefaults.standard.set(true, forKey: "termosDeUsoAceito")
        
        let navHelper = NavHelper()
        navHelper.presentConfig(on: self)
        
    }
    
    @IBAction func sair(_ sender: UIBarButtonItem) {
    }
    
}
