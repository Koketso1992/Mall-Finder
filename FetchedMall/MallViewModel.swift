//
//  MallViewModel.swift
//  FetchedMall
//
//  Created by Koketso Motsikwe (ZA) on 2020/03/11.
//  Copyright © 2020 Koketso Motsikwe (ZA). All rights reserved.
//

import Foundation
import UIKit


class MallViewModel {
    var delegate: MallDelegate?
    var mallsList = [mall]()
    var dispatchGroup = DispatchGroup()
    
    
    func fetchData() {
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-25.7303449,28.2984622&rankBY=distance&radius=40000&keyword=malls&key=AIzaSyBIVwQipko0-MFW8hK7mcpFYZOOxr3yr-4") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? [String: Any]
                if let resonpse = jsonResponse {
                    let malls = MallListModel(with: resonpse)
                    self.mallsList = malls.mallList
                     self.delegate?.dataFetched()
                    if !self.mallsList.isEmpty {
                      self.fetchImage()
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    func fetchImage(){
        for var mall in mallsList {
            dispatchGroup.enter()
            guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=960&photoreference=\(mall.imageRef ?? "")&key=AIzaSyBIVwQipko0-MFW8hK7mcpFYZOOxr3yr-4") else {
                return
            }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let dataResponse = data,error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
                }
                mall.image = UIImage(data: dataResponse) ?? UIImage()
                self.dispatchGroup.leave()
            }
            task.resume()
        }
        dispatchGroup.notify(queue: DispatchQueue.main){
               self.delegate?.dataFetched()
           }
    }
}
