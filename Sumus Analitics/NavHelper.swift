//
//  NavHelper.swift
//  Sumus Analitics
//
//  Created by kassiano Resende on 04/05/17.
//  Copyright © 2017 MyBi. All rights reserved.
//

import UIKit

class NavHelper{


    let storyboard:UIStoryboard
    
    init() {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
    }
    
    
    func presentLogin(on viewController: UIViewController){

        let view = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! Login
        
        viewController.present(view, animated: true, completion: nil)
    }
    
    func presentConfig(on viewController: UIViewController){
    
        let view = storyboard.instantiateViewController(withIdentifier: "ConfigViewController") as! Configuracao
    
        viewController.present(view, animated: true, completion: nil)
    }

    
    func presentBemVindo(on viewController: UIViewController){
        
        let view = storyboard.instantiateViewController(withIdentifier: "BemVindoViewController") as! BemVindo
        
        viewController.present(view, animated: true, completion: nil)
    }
    
    
    func presentTermoUso(on viewController: UIViewController){
        
        let view = storyboard.instantiateViewController(withIdentifier: "VisualizarTermoUso") as! VisualizarTermoUso
        
        viewController.present(view, animated: true, completion: nil)
    }
    
    
}
