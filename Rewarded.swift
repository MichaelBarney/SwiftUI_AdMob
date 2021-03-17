import SwiftUI
import GoogleMobileAds
import UIKit
    

//In v8 of Google Ads SDK GADFullScreenContentDelegate combines some functionality of GADInterstitialDelegate and GADRewardedAdDelegate
final class Rewarded: NSObject, GADFullScreenContentDelegate {
    
    var rewardedAd: GADRewardedAd?
    
    override init() {
        super.init()
        LoadRewarded()
    }
    
    let req = GADRequest()
        GADRewardedAd.load(withAdUnitID: Constants.shared.rewardAdUnitId, request: req) { rewardedAd, err in
            if let err = err {
                print("Failed to load ad with error: \(err)")
                return
            }
            
            self.rewardedAd = rewardedAd
            self.rewardedAd?.fullScreenContentDelegate = self
        }
    
    func showAd(rewardFunction: @escaping () -> Void) {
        
        if let ad = rewardedAd {
            guard let rootVC = UIApplication.shared.windows.first?.rootViewController else { return }
            
            ad.present(fromRootViewController: rootVC) {
                rewardFunction()
            }
        } else {
            print("Ad not ready")
        }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        LoadRewarded()
        
        //Dissmiss VCs from here if needed
    }
}

struct ContentView:View{
    var rewardAd:Rewarded
    
    init(){
         self.rewardAd = Rewarded()
    }
    
    var body : some View{
      Button(action: {
        self.rewardAd.showAd(rewardFunction: {
          print("Give Reward")
        }
      }){
        Text("My Button")
      }
    }
}
