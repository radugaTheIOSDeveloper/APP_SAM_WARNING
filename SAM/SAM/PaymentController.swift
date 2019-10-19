//
//  PaymentController.swift
//  SAM
//
//  Created by Георгий Зуев on 14/10/2019.
//  Copyright © 2019 freshtech. All rights reserved.
//

import UIKit
import WebKit
import YandexCheckoutPaymentsApi
import YandexCheckoutPayments


/// <#Description#>
@objcMembers class PaymentController: UIViewController, WKUIDelegate {
    
    
    @objc dynamic var value = 0
    @IBOutlet weak var resultTokenLabel: UILabel!
    let clientApplicationKey = "live_NjI5ODE47cquPSD7939_gasmXhbT0ccjlnABYEq9rHg"
    let amount = Amount(value: 1.00, currency: .rub)
    var token: Tokens?
    var paymentMethodType: PaymentMethodType?
    
    @objc dynamic var count:String = String()
    

    private let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    var webView: WKWebView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("123213 = " ,count);
       
        moveIn()
    }
    
    
   

    
    @IBAction func buyButtonPressed(_ sender: UIButton) {
        
        let paymentTypes: PaymentMethodTypes = [.bankCard, .applePay]
        let tokenSettings = TokenizationSettings(paymentMethodTypes: paymentTypes,
                             showYandexCheckoutLogo: true)
        let inputData: TokenizationFlow = .tokenization(TokenizationModuleInputData(
            clientApplicationKey: clientApplicationKey,
            shopName: "Космические объекты",
            purchaseDescription: "\"Комета повышенной яркости, период обращения — 112 лет\"",            
            amount: amount,
            tokenizationSettings: tokenSettings,
            testModeSettings: nil,
            cardScanning: nil,
            applePayMerchantIdentifier: "merchant.sam",
            isLoggingEnabled: true,
            userPhoneNumber: "+7",
            customizationSettings: CustomizationSettings(mainScheme:UIColor(red: 228/255, green: 0, blue: 11/255, alpha: 1))
        ))
        let viewController = TokenizationAssembly.makeModule(inputData: inputData,
                                                             moduleOutput: self)
        present(viewController, animated: true, completion: nil)

    }
}




extension PaymentController {
    private func moveIn() {
        self.view.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        self.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.24) {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0
        }
    }
    
    private func moveOut() {
        UIView.animate(withDuration: 0.24, animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            self.view.alpha = 0.0
        }) { _ in
            self.view.removeFromSuperview()
        }
    }
}

extension PaymentController: TokenizationModuleOutput {
    
    func didFinish(on module: TokenizationModuleInput) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.dismiss(animated: true)
        }
    }

    func tokenizationModule(_ module: TokenizationModuleInput,
                            didTokenize token: Tokens,
                            paymentMethodType: PaymentMethodType) {
        self.token = token
        self.paymentMethodType = paymentMethodType
        
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.dismiss(animated: true)
        }

        // Отправьте токен в вашу систему
//        print("Token: \(self.token!.paymentToken)")
//        let tokenInfo: [String: String] = ["token": self.token!.paymentToken]
////        Отправим сообщение
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tokenChanged"), object: nil, userInfo: tokenInfo)
////        Теперь можно вернуться
//        DispatchQueue.main.async {
//            self.moveOut()
//        }
        //Все остальное можно не использовать
        sendRequest()
        

    }
    
    private func sendRequest() {
        DispatchQueue.main.async {
            self.resultTokenLabel.text = self.token!.paymentToken
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let params: NSDictionary = ["app_token": self.token!.paymentToken, "oleg":"helllow"]
            self.processExternalPayment(userParameters: params, completion: {(code, data, error) -> Void in
                if (error != nil) {
                    DispatchQueue.main.async {
                        print(error?.localizedDescription as Any)
                    }
                }
                else {
                    if let dict = self.convertDataToDict(JSONData: data), let url = dict["confirmation_url"] {
                        print(url)
                        DispatchQueue.main.async {
                            let webConfiguration = WKWebViewConfiguration()
                            self.webView = WKWebView(frame: .zero, configuration: webConfiguration)
                            self.webView.uiDelegate = self
                            self.view = self.webView
                            let myURL = URL(string: url as! String)
                            let myRequest = URLRequest(url: myURL!)
                            self.webView.load(myRequest)
                        }
                    }
                }
            })
            
        }

    }
}

extension PaymentController: URLSessionTaskDelegate, URLSessionDataDelegate {
    
    func processExternalPayment(userParameters: NSDictionary, completion: @escaping (Int, Data?, Error?) -> ()) {
        let requestString = "https://app.pomoysam.ru/api/v0/payment/"
        let requestUrl = URL(string: requestString)
        let postString = bodyStringWithParams(postParams: userParameters)
        let request = self.getRequest(requestUrl: requestUrl!, postString: postString)
        
        let dataTask = self.defaultSession.dataTask(with: request as URLRequest) {
            data, response, error in
            DispatchQueue.main.async() {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            if let error = error {
                //Завершилось с ошибкой
                print(error.localizedDescription)
                completion(0, nil, error)
            } else if let httpResponse = response as? HTTPURLResponse {
                
                completion(httpResponse.statusCode, data, nil)
            }
        }
        dataTask.resume()
    }
    
    private func getRequest(requestUrl: URL, postString: String) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
        request.setValue("Yandex.Money.SDK/iOS", forHTTPHeaderField: "User-Agent")
        request.setValue("ru", forHTTPHeaderField: "Accept-Language")
        let value = String(request.httpBody!.count)
    //    print(request.httpBody);
        request.setValue(value, forHTTPHeaderField: "Content-Length")
        
        return request
    }
    
    private func addPercentEscapesForString(string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!
    }
    
    private func bodyStringWithParams(postParams: NSDictionary?) -> String {
        if (postParams == nil) {
            return ""
        }
        
        let bodyParams = NSMutableArray()
        for key in postParams!.allKeys {
            let value = postParams![key]
            let stringValue = formatToStringValue(value: value)
            if (stringValue != nil) {
                let encodedValue = addPercentEscapesForString(string: stringValue!)
                let encodedKey = addPercentEscapesForString(string: key as! String)
                bodyParams.add(String(format: "%@=%@", encodedKey, encodedValue))
            }
        }
        
        return bodyParams.componentsJoined(by: "&")
    }
    
    func formatToStringValue(value: Any?) -> String? {
        if (value == nil || value is NSNull) {
            return nil
        }
        
        var stringValue: String?
        if (value is NSString) {
            stringValue = value as? String
        }
        else if (value is NSNumber) {
            stringValue = String(describing: value)
        }
        else if (value is NSArray) {
            let mutableString = NSMutableString()
            let array = value as! NSArray
            mutableString.append("[")
            array.enumerateObjects({ object, idx, stop in
                if (idx > 0) {
                    mutableString.append(",")
                }
                mutableString.append(self.formatToStringValue(value: object)!)
            })
            mutableString.append("]")
            stringValue = mutableString.copy() as? String
        }
        else if (value is NSDictionary) {
            let mutableString = NSMutableString()
            let dictionary = value as! NSDictionary
            mutableString.append("{")
            var dictionaryHasValues = false
            dictionary.enumerateKeysAndObjects({ key, obj, stop in
                if (dictionaryHasValues) {
                    mutableString.append(",")
                }
                mutableString.appendFormat("%@:%@", key as! CVarArg, self.formatToStringValue(value: obj)!)
                dictionaryHasValues = true
            })
            mutableString.append("}")
        }
        return stringValue
    }
    
    private func convertDataToDict(JSONData: Data?) -> NSDictionary? {
        if (JSONData != nil) {
            let parsedObject: AnyObject?
            do {
                // Convert the returned data into a dictionary.
                parsedObject = try JSONSerialization.jsonObject(with: JSONData!, options: JSONSerialization.ReadingOptions.mutableContainers) as Any as AnyObject
                if let returnedDict = parsedObject as? NSDictionary {
                    return returnedDict
                }
            }
            catch let parseError as NSError {
                print("Error: \(parseError.domain)")
                return nil
            }
        }
        else {
            //Надо сообщить, что все вообще плохо
            return nil
        }
        
        return nil
    }

}
