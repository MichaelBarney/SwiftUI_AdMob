import SwiftUI
import GoogleMobileAds
import UIKit
    
final class Interstitial:NSObject, GADInterstitialDelegate{
    var interstitial:GADInterstitial = GADInterstitial(adUnitID: interstitialID)
    
    override init() {
        super.init()
        LoadInterstitial()
    }
    
    func LoadInterstitial(){
        let req = GADRequest()
        self.interstitial.load(req)
        self.interstitial.delegate = self
    }
    
    func showAd(){
        if self.interstitial.isReady{
           let root = UIApplication.shared.windows.first?.rootViewController
           self.interstitial.present(fromRootViewController: root!)
        }
       else{
           print("Not Ready")
       }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.interstitial = GADInterstitial(adUnitID: interstitialID)
        LoadInterstitial()
    }
}

struct ContentView:View{
    var interstitial:Interstitial
    
    init(){
        self.interstitial = Interstitial()
    }
    
    var body : some View{
      Button(action: {self.interstitial.showAd()}){
        Text("My Button")
      }
    }
}