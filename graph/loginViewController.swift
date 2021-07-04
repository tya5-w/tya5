import UIKit
import Charts
import NCMB



    
class loginViewController: UIViewController{
        @IBOutlet weak var userEmailTextfield: UITextField!
        @IBOutlet weak var PasswordTextfield: UITextField!
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
   
    // クラスのNCMBObjectを作成

    @IBAction func signup(_ sender : Any) {
        
    //　Userインスタンスの生成
        let user = NCMBUser()
    // ユーザー名・パスワードを設定
        user.userName = userEmailTextfield.text
        user.password = PasswordTextfield.text
        
    // ユーザーの新規登録
        user.signUpInBackground(callback: { result in
            switch result {
                case .success:
                // 新規登録に成功した場合の処理
                    print("新規登録に成功しました")
                case let .failure(error):
                // 新規登録に失敗した場合の処理
                    print("新規登録に失敗しました: \(error)")
            }
            
        })
    }
    @IBAction func login(_ sender : Any) {
        if let Email = userEmailTextfield.text ,let Pass = PasswordTextfield.text{
        NCMBUser.logInInBackground(userName:Email , password: Pass, callback: { result in
            switch result {
                case .success:
                    // ログインに成功した場合の処理
                    print("ログインに成功しました")
                    if let user = NCMBUser.currentUser {
                        print("ログイン中のユーザー: \(user.userName!)")
                    } else {
                        print("未ログインまたは取得に失敗")
                    }

                case let .failure(error):
                    // ログインに失敗した場合の処理
                    print("ログインに失敗しました: \(error)")
            }
        })
    }
    }
}




