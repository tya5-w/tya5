import UIKit
import NCMB




class thirdViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = NCMBUser.currentUser {
            Swift.print("ログイン中のユーザー: \(user.userName!)")
        } else {
            Swift.print("未ログインまたは取得に失敗")
        }

    

    //HighScoreクラスを検索するクエリを作成
    var query = NCMBQuery.getQuery(className: "TotalScore")

    //Scoreの降順でデータを取得するように設定
    query.order = ["Score"]

    //検索件数を5件に設定
    query.limit = 5;

    //データストアでの検索を行う
    query.findInBackground(callback: { result in
        
        switch result {
        case let .success(array):
            print("取得に成功しました 件数: \(array)")
        case let .failure(error):
            print("取得に失敗しました: \(error)")
        }
    })
    }

}
