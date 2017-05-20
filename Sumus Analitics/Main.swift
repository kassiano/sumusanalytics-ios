//
//  Main.swift
//  Sumus Analitics
//
//  Created by kassiano Resende on 04/05/17.
//  Copyright © 2017 MyBi. All rights reserved.
//

import UIKit

class Main: UIViewController {

    
    let navHelper : NavHelper!
    
    required init?(coder aDecoder: NSCoder) {
        
        navHelper =  NavHelper()
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let numSerieArmazenado = UserDefaults.standard.string(forKey: "numeroSerie")
        let termosDeUsoAceito = UserDefaults.standard.bool(forKey: "termosDeUsoAceito")
        
        
        
        if termosDeUsoAceito {
            
            if numSerieArmazenado == nil || (numSerieArmazenado?.isEmpty)! {
                
                navHelper.presentConfig(on: self)
                
            }else{
                navHelper.presentLogin(on: self)
            }
            
            
        }else{
            
            navHelper.presentBemVindo(on: self)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
