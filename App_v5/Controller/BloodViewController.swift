//
//  BloodViewController.swift
//  App_v5
//
//  Created by 葉上輔 on 2020/8/3.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class BloodViewController: UIViewController {
    let text1 = "血糖升高   0h~2h\n    \n血糖升高您在禁食的前幾個小時不會感到任何異狀，因\n為此時身體仍正常分泌肝醣。血糖升高，胰臟\n分泌胰島素以分解葡萄糖，作為能量來源，並\n儲存多餘葡萄糖以備後用"
    let text2 = "血糖下降   2h~5h\n \n由於胰島素的作用，血糖飆升後會回到正常水\n平，通常不會在繼續攀升，因為進食後，胰島\n素會立即進入您的循環系統。"
    let text3 = "肝糖儲存量下降  5h~8h\n  \n感到飢餓？肚子提醒您距離上一餐已有一段時\n間，不過其實您沒有那麼餓。\n身體會繼續消化最後攝取的食物，開始使用儲\n存的葡萄糖作為能量來源，並持續正常工作，\n好像您待會就會繼續進食。"
    let text4 = "糖值新生   8h~10h\n \n最後用餐後經過8小時，肝臟會消耗最後的葡\n萄糖儲存量。現在身體進入糖值新生狀態，代\n表身體已經進入禁食狀態。"
    let text5 = "剩下少量肝糖   10h~12h\n \n您的肝醣儲存量快不夠了！因此，您有可能會\n感到煩躁或飢腸轆轆。放輕鬆，這只是身體燃\n燒脂肪現象！\n因為剩餘肝糖不多，肥胖細胞(脂肪細胞)會釋\n放脂肪到血液中，同時也會直接進到肝臟，轉\n換成身體所需能量。其實，這只是在欺騙身體為\n了生存而燃燒脂肪。"
    let text6 = "酮症狀態   12h~18h\n \n現在輪到脂肪為身體提供燃料。您進入酮症的\n代謝狀態，肝醣幾乎用盡，肝臟將脂肪轉化為\n酮體(身體的一種替代能量來源)。\n酮症有時又稱為燃燒脂肪模式。"
    let text7 = "燃燒脂肪   18h~24h\n \n禁食時間越長，越進入酮症狀態。到18個小\n時，身體已轉變為脂肪燃燒模式。研究顯示空\n腹12至24小時後，脂肪能量供應將增加60%，且在18小時後顯著增加。"
    let text8 = "自噬   24h~48h\n \n此時，身體會誘發自噬(字面意思是「自我吞\n噬」)。細胞開始清理他們的房子，刪除不必要\n或功能失調的元件。這是一件好事，能夠有次\n序的降解並回收胞器。\n自噬過程中，細胞會分解病毒，細菌和受損成\n分，您會獲得製造新細胞的能量，而這對細胞的健康，更新與生存相當重要。自噬最為人所\n知的主要好處即是能倒轉時鐘，讓身體產生更\n年輕的細胞。"
    let text9 = "生長激素上升   48h~56h\n \n生長激素含量遠高於禁食前的含量，這得益於\n禁食期間酮體的產生和飢餓激素的分泌。生長\n激素有助於增加肌肉質量，並改善心血管健\n康。"
    let text10 = "對胰島素敏感   56h~72h\n \n胰島素處於禁食後的最低含量，讓您對胰島素\n更加敏感，若您罹患糖尿病的風險很高，這絕\n對是一大福音。\n不管從短期或長期來看，降低胰島素含量對於\n健康都有許多好處，例如啟動自噬作用和減少\n炎症"
    let text11 = "免疫細胞再生   72h~\n \n「適者生存。」身體會拒絕細胞生存訊息傳遞\n路徑，並回收在對抗病毒，細菌和微生物時受\n損的免疫細胞。\n為了填補「守衛空缺」，身體會快速再生新的\n免疫細胞，開啟免疫系統再生，並將細胞轉換\n為自我更新的狀態，因此免疫系統變得越來越\n強大。"
    var textList = [String]()
    
    @IBOutlet weak var textDispay: UITextView!
    @IBOutlet weak var one: UIImageView!
    @IBOutlet weak var two: UIImageView!
    @IBOutlet weak var three: UIImageView!
    @IBOutlet weak var four: UIImageView!
    @IBOutlet weak var five: UIImageView!
    @IBOutlet weak var six: UIImageView!
    @IBOutlet weak var seven: UIImageView!
    @IBOutlet weak var eight: UIImageView!
    @IBOutlet weak var nine: UIImageView!
    @IBOutlet weak var ten: UIImageView!
    @IBOutlet weak var eleven: UIImageView!
    
    
    var back = UIButton(type: .close)
    override func viewDidLoad() {
        super.viewDidLoad()
        textDispay.text = ""
        setupSubviews()
        let list = [one,two,three,four,five,six,seven,eight,nine,ten,eleven]
        textList = [text1,text2,text3,text4,text5,text6,text7,text8,text9,text10,text11]
        for view in list {
            let tapper = UITapGestureRecognizer(target: self , action: #selector(tapHandler(_:)))
            view?.addGestureRecognizer(tapper)
        }
        
        
    }
    @objc func tapHandler(_ reco: UITapGestureRecognizer) {
        print(reco.view?.tag)
        textDispay.text = textList[reco.view!.tag]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BloodViewController {
    func setupSubviews() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bloodBackground")!)
        textDispay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        back.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        back.center = CGPoint(x: 40, y: 50)
        back.addTarget(self, action: #selector(backHandler), for: .touchUpInside)
        self.view.addSubview(back)
        
        one.isUserInteractionEnabled = true
        two.isUserInteractionEnabled = true
        three.isUserInteractionEnabled = true
        four.isUserInteractionEnabled = true
        five.isUserInteractionEnabled = true
        six.isUserInteractionEnabled = true
        seven.isUserInteractionEnabled = true
        eight.isUserInteractionEnabled = true
        nine.isUserInteractionEnabled = true
        ten.isUserInteractionEnabled = true
        eleven.isUserInteractionEnabled = true
    }
    
    @objc func backHandler() {
        dismiss(animated: true, completion: nil)
    }
}
