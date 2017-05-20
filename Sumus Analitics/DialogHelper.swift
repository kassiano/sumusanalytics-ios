//
//  DialogHelper.swift
//  Sumus Analitics
//
//  Created by kassiano Resende on 20/03/17.
//  Copyright © 2017 MyBi. All rights reserved.
//

import Foundation
import UIKit

class DialogHelper{

    var alert:UIAlertController?
    var titulo:String?
    var mensagem:String?
    
    func create(titulo:String? , mensagem:String?) {
        alert = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert);
    }
    
    
    func  addAction(acao:UIAlertAction ) {
        alert!.addAction(acao)
    }
    
    func showWithActivityIndicator(viewController: UIViewController )  {
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        indicator.frame = CGRect(x: 5, y: 5, width: 50, height: 50)

        indicator.isUserInteractionEnabled = false
        indicator.startAnimating()
        
        alert!.view.addSubview(indicator)
    
        viewController.present(alert!, animated: true, completion: nil)
        
    }
    
    
    func show(viewController: UIViewController )  {
        viewController.present(alert!, animated: true, completion: nil)
    }
    
    
    func dismiss(viewController: UIViewController){
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
