```toml
# 日時を取得
# 変数に保存（YYYY.MMを保存）
# 既存のスプレッドシートを取得 - 新規帳 2025（高の原）
# セルの値を取得
+get_cells_1:
  action>: GetCells
  display_name>: 'セルの値を取得'
  spreadsheet: +get_spreadsheet_2
  range: '${sheetname}!C7:AJ'
  findAll: true
  private: false

# テーブルデータ（二次元配列）を変換
+convert_table_1:
  action>: ConvertTable
  display_name>: 'テーブルデータ（二次元配列）を変換'
  header: false
  table: +get_cells_1
  transform: [{"type":"filter","column":"0","operator":"==","operand":"資料到着","include_blank":false},{"type":"filter","column":"6","operator":"~","operand":"戸建","include_blank":false},{"type":"column","columns":{"0":"0","1":"1","2":"2","3":"3","4":"4","5":"5","6":"6","7":"7","8":"8","9":"9","10":"10","11":"11","12":"12","13":"13","14":"14","15":"15","16":"16","17":"17","18":"18","19":"19","20":"20","21":"21","22":"22","23":"23","24":"24","25":"25","26":"26","27":"27","28":"28","29":"29","30":"30","31":"31","32":"32","33":"33"}}]
  private: false

# 各要素について繰り返す - ループ
    # try
    # catch
+for_each_1:
  for_each>:
    reinsnumber: +convert_table_1
    private: false
    display_name>: '各要素について繰り返す'
  _do:

    # エラーを捕捉する
    +try_1:
      try>:
        display_name>: 'エラーを捕捉する'
        errorObjectName: error
        private: false
      _do:

        # 変数に保存 レインズ番号
        +store_value_1:
          action>: StoreValue
          display_name>: '変数に保存 レインズ番号'
          key: log
          value: ${reinsnumber}
          setIfNotDefined: false
          private: false

        # ブラウザを開く　レインズ
        +open_browser_2:
          action>: OpenBrowser
          display_name>: 'ブラウザを開く　レインズ'
          url: 'https://system.reins.jp/login/main/KG/GKG001200'
          lang: 'ja-JP'
          headless: false
          confirm: true
          windowSize: '1920 x 1080'
          useShadowDomSelector: false
          private: false

        # 文字入力　レインズ　ユーザID
        +type_text_3:
          action>: TypeText
          display_name>: '文字入力　レインズ　ユーザID'
          browser: +open_browser_2
          selector: 'input[type="text"][inputmode="text"]'
          text: '029100412910'
          clearValue: true
          waitBefore: 4000
          ignoreError: false
          private: false

        # パスワード入力　レインズ
        +type_password_2:
          action>: TypePassword
          display_name>: 'パスワード入力　レインズ'
          browser: +type_text_3
          selector: 'input[type="password"]'
          password: '********'
          ignoreError: false
          private: false

        # クリック　レインズ　ガイドラインを遵守チェック
        +click_8:
          action>: Click
          display_name>: 'クリック　レインズ　ガイドラインを遵守チェック'
          browser: +type_password_2
          selector: '.noRobot input[type="checkbox"]'
          confirm: true
          ignoreError: false
          timeout: 5000
          private: false

        # クリック　レインズ　ログイン
        +click_7:
          action>: Click
          display_name>: 'クリック　レインズ　ログイン'
          browser: +type_password_2
          selector: 'button[type="button"]'
          confirm: true
          waitAfter: 4000
          ignoreError: false
          timeout: 5000
          private: false

        # クリック　レインズ　物件番号検索
        +click_9:
          action>: Click
          display_name>: 'クリック　レインズ　物件番号検索'
          browser: +click_7
          selector: '.card:nth-child(2) .d-none .btn'
          confirm: true
          waitAfter: 1000
          ignoreError: false
          timeout: 5000
          private: false

        # 要素を見つける
        +find_element_1:
          action>: FindElement
          display_name>: '要素を見つける'
          browser: +click_7
          find_by: xpath
          value: '//span[text()="物件番号１"]/../following-sibling::div/input'
          timeout: 30000
          visible: true
          private: false

        # 文字入力　レインズ　物件番号入力
        +type_text_4:
          action>: TypeText
          display_name>: '文字入力　レインズ　物件番号入力'
          browser: +click_9
          selector: +find_element_1
          text: ${reinsnumber[8]}
          clearValue: false
          ignoreError: false
          private: false

        # クリック レインズ　検索
        +click_10:
          action>: Click
          display_name>: 'クリック レインズ　検索'
          browser: +type_text_4
          selector: 'button.btn.p-button'
          confirm: true
          waitAfter: 500
          ignoreError: false
          timeout: 5000
          private: false

        # クリック　レインズ　詳細ボタン
        +click_11:
          action>: Click
          display_name>: 'クリック　レインズ　詳細ボタン'
          browser: +click_10
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div.card.p-card > div > div.p-table.small > div.p-table-body > div > div:nth-child(25) > button'
          confirm: true
          waitAfter: 500
          ignoreError: false
          timeout: 5000
          private: false

        # テキストを取得　物件番号
        +get_text_68:
          action>: GetText
          display_name>: 'テキストを取得　物件番号'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(3) > div > div:nth-child(1) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　物件種目
        +get_text_69:
          action>: GetText
          display_name>: 'テキストを取得　物件種目'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(5) > div > div:nth-child(1) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　取引態様
        +get_text_70:
          action>: GetText
          display_name>: 'テキストを取得　取引態様'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(7) > div > div:nth-child(1) > div.col-auto > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　商号
        +get_text_71:
          action>: GetText
          display_name>: 'テキストを取得　商号'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(10) > div > div:nth-child(2) > div:nth-child(1) > div > div.row > div > span'
          ignoreError: true
          private: false

        # テキストを取得　レインズ　代表者電話番号
        +get_text_1:
          action>: GetText
          display_name>: 'テキストを取得　レインズ　代表者電話番号'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(10) > div > div:nth-child(2) > div:nth-child(2) > div:nth-child(1) > div.row > div'
          ignoreError: false
          private: false

        # テキストを取得　レインズ　物件問い合わせ担当者
        +get_text_2:
          action>: GetText
          display_name>: 'テキストを取得　レインズ　物件問い合わせ担当者'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(10) > div > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > div.row > div'
          ignoreError: false
          private: false

        # テキストを取得　物件担当者電話番号
        +get_text_72:
          action>: GetText
          display_name>: 'テキストを取得　物件担当者電話番号'
          browser: +click_11
          selector: '#__layout>div>div.p-frame-main>div.p-frame-content>div>div:nth-child(10)>div>div:nth-child(5)>div:nth-child(1)>div.mt-3.mt-sm-0.col-sm-6>div.row>div'
          ignoreError: true
          private: false

        # テキストを取得　レインズ　価格
        +get_text_3:
          action>: GetText
          display_name>: 'テキストを取得　レインズ　価格'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(12) > div > div > div:nth-child(1) > div:nth-child(1) > div.row > div'
          ignoreError: false
          private: false

        # 検索して置換　価格の「万円」を除く
        +replace_text_2:
          action>: ReplaceText
          display_name>: '検索して置換　価格の「万円」を除く'
          text: +get_text_3
          find: '万円'
          use_regex: false
          replace_with: ''
          private: false

        # 検索して置換　価格のカンマを除く
        +replace_text_1:
          action>: ReplaceText
          display_name>: '検索して置換　価格のカンマを除く'
          text: +replace_text_2
          find: ','
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　レインズ　土地面積
        +get_text_4:
          action>: GetText
          display_name>: 'テキストを取得　レインズ　土地面積'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(14) > div > div > div:nth-child(1) > div.col-sm-6 > div.row > div'
          ignoreError: false
          private: false

        # 検索して置換　土地面積の㎡を除く
        +replace_text_3:
          action>: ReplaceText
          display_name>: '検索して置換　土地面積の㎡を除く'
          text: +get_text_4
          find: '㎡'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　レインズ　面積計測方式　公募？実測？
        +get_text_5:
          action>: GetText
          display_name>: 'テキストを取得　レインズ　面積計測方式　公募？実測？'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(14) > div > div > div:nth-child(3) > div > div.row > div'
          ignoreError: false
          private: false

        # テキストを取得　レインズ　建物面積
        +get_text_6:
          action>: GetText
          display_name>: 'テキストを取得　レインズ　建物面積'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(14) > div > div > div:nth-child(2) > div.col-sm-6 > div.row > div'
          ignoreError: false
          private: false

        # 検索して置換　建物面積の㎡を除く
        +replace_text_4:
          action>: ReplaceText
          display_name>: '検索して置換　建物面積の㎡を除く'
          text: +get_text_6
          find: '㎡'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　セットバック区分
        +get_text_73:
          action>: GetText
          display_name>: 'テキストを取得　セットバック区分'
          browser: +click_11
          selector: '#__layout>div>div.p-frame-main>div.p-frame-content>div>div:nth-child(14)>div>div>div:nth-child(4)>div>div.row>div'
          ignoreError: true
          private: false

        # テキストを取得　私道負担有無
        +get_text_74:
          action>: GetText
          display_name>: 'テキストを取得　私道負担有無'
          browser: +click_11
          selector: '#__layout>div>div.p-frame-main>div.p-frame-content>div>div:nth-child(14)>div>div>div:nth-child(5)>div:nth-child(1)>div.row>div'
          ignoreError: true
          private: false

        # テキストを取得　建物面積１F
        +get_text_8:
          action>: GetText
          display_name>: 'テキストを取得　建物面積１F'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(14) > div > div > div:nth-child(6) > div:nth-child(1) > div.row > div'
          ignoreError: false
          private: false

        # 検索して置換　建物面積１Fの㎡を除く
        +replace_text_5:
          action>: ReplaceText
          display_name>: '検索して置換　建物面積１Fの㎡を除く'
          text: +get_text_8
          find: '㎡'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　レインズ　建物面積2F
        +get_text_9:
          action>: GetText
          display_name>: 'テキストを取得　レインズ　建物面積2F'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(14) > div > div > div:nth-child(6) > div.mt-3.mt-sm-0.col-sm-6 > div.row > div'
          ignoreError: false
          private: false

        # 検索して置換　建物面積2Fの㎡を除く
        +replace_text_6:
          action>: ReplaceText
          display_name>: '検索して置換　建物面積2Fの㎡を除く'
          text: +get_text_9
          find: '㎡'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　建物面積その他
        +get_text_19:
          action>: GetText
          display_name>: 'テキストを取得　建物面積その他'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(14) > div > div > div:nth-child(7) > div > div.row > div'
          ignoreError: true
          private: false

        # 検索して置換　建物面積その他の㎡を除く
        +replace_text_11:
          action>: ReplaceText
          display_name>: '検索して置換　建物面積その他の㎡を除く'
          text: +get_text_19
          find: '㎡'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　レインズ　所在地名１
        +get_text_10:
          action>: GetText
          display_name>: 'テキストを取得　レインズ　所在地名１'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(16) > div > div:nth-child(2) > div:nth-child(1) > div.row > div'
          ignoreError: false
          private: false

        # テキストを取得　レインズ　所在地名２
        +get_text_11:
          action>: GetText
          display_name>: 'テキストを取得　レインズ　所在地名２'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(16) > div > div:nth-child(2) > div.mt-3.mt-sm-0.col-sm-6 > div.row > div'
          ignoreError: false
          private: false

        # テキストを取得　所在地名３
        +get_text_20:
          action>: GetText
          display_name>: 'テキストを取得　所在地名３'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(16) > div > div:nth-child(3) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　その他所在地表示
        +get_text_21:
          action>: GetText
          display_name>: 'テキストを取得　その他所在地表示'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(16) > div > div:nth-child(4) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　交通１　沿線名
        +get_text_22:
          action>: GetText
          display_name>: 'テキストを取得　交通１　沿線名'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(2) > div:nth-child(1) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　交通１　駅名
        +get_text_23:
          action>: GetText
          display_name>: 'テキストを取得　交通１　駅名'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(2) > div:nth-child(2) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　交通１　駅より徒歩○分
        +get_text_18:
          action>: GetText
          display_name>: 'テキストを取得　交通１　駅より徒歩○分'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(2) > div:nth-child(3) > div:nth-child(1) > div.row > div'
          ignoreError: true
          private: false

        # 検索して置換　交通１　駅より徒歩○　分を除く
        +replace_text_10:
          action>: ReplaceText
          display_name>: '検索して置換　交通１　駅より徒歩○　分を除く'
          text: +get_text_18
          find: '分'
          use_regex: true
          replace_with: ''
          private: false

        # テキストを取得　交通１　駅よりバス〇分
        +get_text_12:
          action>: GetText
          display_name>: 'テキストを取得　交通１　駅よりバス〇分'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(2) > div:nth-child(4) > div:nth-child(1) > div.row > div'
          ignoreError: false
          private: false

        # 検索して置換　交通１　駅よりバス　分を除く
        +replace_text_7:
          action>: ReplaceText
          display_name>: '検索して置換　交通１　駅よりバス　分を除く'
          text: +get_text_12
          find: '分'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　交通１　レインズ　バス停名称
        +get_text_13:
          action>: GetText
          display_name>: 'テキストを取得　交通１　レインズ　バス停名称'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(2) > div:nth-child(6) > div > div.row > div'
          ignoreError: false
          private: false

        # テキストを取得　交通2　沿線名
        +get_text_24:
          action>: GetText
          display_name>: 'テキストを取得　交通2　沿線名'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(5) > div:nth-child(1) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　交通2　駅名
        +get_text_25:
          action>: GetText
          display_name>: 'テキストを取得　交通2　駅名'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(5) > div:nth-child(2) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　交通2　駅より徒歩○分
        +get_text_26:
          action>: GetText
          display_name>: 'テキストを取得　交通2　駅より徒歩○分'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(5) > div:nth-child(3) > div:nth-child(1) > div.row'
          ignoreError: true
          private: false

        # 検索して置換　交通2　駅より徒歩○　分を除く
        +replace_text_12:
          action>: ReplaceText
          display_name>: '検索して置換　交通2　駅より徒歩○　分を除く'
          text: +get_text_25
          find: '分'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　交通2　駅よりバス〇分
        +get_text_27:
          action>: GetText
          display_name>: 'テキストを取得　交通2　駅よりバス〇分'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(5) > div:nth-child(4) > div:nth-child(1) > div.row > div'
          ignoreError: true
          private: false

        # 検索して置換　交通2　駅よりバス　分を除く
        +replace_text_13:
          action>: ReplaceText
          display_name>: '検索して置換　交通2　駅よりバス　分を除く'
          text: +get_text_27
          find: '分'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　交通2　レインズ　バス停名称
        +get_text_28:
          action>: GetText
          display_name>: 'テキストを取得　交通2　レインズ　バス停名称'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(5) > div:nth-child(6) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　交通3　沿線名
        +get_text_29:
          action>: GetText
          display_name>: 'テキストを取得　交通3　沿線名'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(8) > div:nth-child(1) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　交通3　駅名
        +get_text_30:
          action>: GetText
          display_name>: 'テキストを取得　交通3　駅名'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(8) > div:nth-child(2) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　交通3　駅より徒歩○分
        +get_text_31:
          action>: GetText
          display_name>: 'テキストを取得　交通3　駅より徒歩○分'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(8) > div:nth-child(3) > div:nth-child(1) > div.row'
          ignoreError: true
          private: false

        # 検索して置換　交通3　駅より徒歩○　分を除く
        +replace_text_14:
          action>: ReplaceText
          display_name>: '検索して置換　交通3　駅より徒歩○　分を除く'
          text: +get_text_31
          find: '分'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　交通3　駅よりバス〇分
        +get_text_32:
          action>: GetText
          display_name>: 'テキストを取得　交通3　駅よりバス〇分'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(8) > div:nth-child(4) > div:nth-child(1) > div.row > div'
          ignoreError: true
          private: false

        # 検索して置換　交通3　駅よりバス　分を除く
        +replace_text_15:
          action>: ReplaceText
          display_name>: '検索して置換　交通3　駅よりバス　分を除く'
          text: +get_text_32
          find: '分'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　交通3　レインズ　バス停名称
        +get_text_33:
          action>: GetText
          display_name>: 'テキストを取得　交通3　レインズ　バス停名称'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(8) > div:nth-child(6) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　交通その他　その他交通手段
        +get_text_34:
          action>: GetText
          display_name>: 'テキストを取得　交通その他　その他交通手段'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(11) > div > div:nth-child(1) > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　交通その他　交通
        +get_text_35:
          action>: GetText
          display_name>: 'テキストを取得　交通その他　交通'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(18) > div > div:nth-child(11) > div > div.mt-3.mt-sm-0.col-sm-6 > div.row'
          ignoreError: true
          private: false

        # テキストを取得　間取タイプ
        +get_text_36:
          action>: GetText
          display_name>: 'テキストを取得　間取タイプ'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(20) > div > div:nth-child(1) > div:nth-child(1) > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　間取部屋数
        +get_text_37:
          action>: GetText
          display_name>: 'テキストを取得　間取部屋数'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(20) > div > div:nth-child(1) > div.mt-3.mt-sm-0.col-sm-6 > div.row > div'
          ignoreError: true
          private: false

        # 検索して置換　間取部屋数の室を除く
        +replace_text_16:
          action>: ReplaceText
          display_name>: '検索して置換　間取部屋数の室を除く'
          text: +get_text_37
          find: '室'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　レインズ　築年月
        +get_text_17:
          action>: GetText
          display_name>: 'テキストを取得　レインズ　築年月'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(23) > div > div:nth-child(1) > div > div.row > div'
          ignoreError: false
          private: false

        # 正規表現で検索
        +match_text_1:
          action>: MatchText
          display_name>: '正規表現で検索'
          text: +get_text_17
          regex: '^.+(?=年（)|(?<=）).+(?=月)'
          global: true
          private: false

        # テキストを取得　レインズ　建物構造
        +get_text_16:
          action>: GetText
          display_name>: 'テキストを取得　レインズ　建物構造'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(23) > div > div:nth-child(2) > div > div.row > div'
          ignoreError: false
          private: false

        # テキストを取得　レインズ　地上階層
        +get_text_14:
          action>: GetText
          display_name>: 'テキストを取得　レインズ　地上階層'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(23) > div > div:nth-child(4) > div:nth-child(1) > div.row > div'
          ignoreError: false
          private: false

        # 検索して置換　地上階層　階を除く
        +replace_text_8:
          action>: ReplaceText
          display_name>: '検索して置換　地上階層　階を除く'
          text: +get_text_14
          find: '階'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　レインズ　地下階層
        +get_text_15:
          action>: GetText
          display_name>: 'テキストを取得　レインズ　地下階層'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(23) > div > div:nth-child(4) > div.mt-3.mt-sm-0.col-sm-6 > div.row > div'
          ignoreError: false
          private: false

        # 検索して置換　地下階層　階を除く
        +replace_text_9:
          action>: ReplaceText
          display_name>: '検索して置換　地下階層　階を除く'
          text: +get_text_15
          find: '階'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　その他一時金なし
        +get_text_38:
          action>: GetText
          display_name>: 'テキストを取得　その他一時金なし'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(25) > div > div:nth-child(1) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　その他一時金名称１
        +get_text_39:
          action>: GetText
          display_name>: 'テキストを取得　その他一時金名称１'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(25) > div > div:nth-child(2) > div:nth-child(1) > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　金額１
        +get_text_40:
          action>: GetText
          display_name>: 'テキストを取得　金額１'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(25) > div > div:nth-child(2) > div.mt-3.mt-sm-0.col-sm-6 > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　その他一時金名称２
        +get_text_41:
          action>: GetText
          display_name>: 'テキストを取得　その他一時金名称２'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(25) > div > div:nth-child(3) > div:nth-child(1) > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得  金額２
        +get_text_42:
          action>: GetText
          display_name>: 'テキストを取得  金額２'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(25) > div > div:nth-child(3) > div.mt-3.mt-sm-0.col-sm-6 > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得 その他月額費名称
        +get_text_43:
          action>: GetText
          display_name>: 'テキストを取得 その他月額費名称'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(25) > div > div:nth-child(4) > div:nth-child(1) > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得 その他月額費金額
        +get_text_44:
          action>: GetText
          display_name>: 'テキストを取得 その他月額費金額'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(25) > div > div:nth-child(4) > div.mt-3.mt-sm-0.col-sm-6 > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得 駐車場在否
        +get_text_45:
          action>: GetText
          display_name>: 'テキストを取得 駐車場在否'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(27) > div > div:nth-child(1) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　駐車場月額
        +get_text_46:
          action>: GetText
          display_name>: 'テキストを取得　駐車場月額'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(27) > div > div:nth-child(2) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　現況
        +get_text_47:
          action>: GetText
          display_name>: 'テキストを取得　現況'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(30) > div > div > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　引渡時期
        +get_text_48:
          action>: GetText
          display_name>: 'テキストを取得　引渡時期'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(32) > div > div > div:nth-child(1) > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　報酬形態
        +get_text_49:
          action>: GetText
          display_name>: 'テキストを取得　報酬形態'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(34) > div > div:nth-child(1) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　都市計画
        +get_text_50:
          action>: GetText
          display_name>: 'テキストを取得　都市計画'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(36) > div > div:nth-child(1) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　登記簿地目
        +get_text_51:
          action>: GetText
          display_name>: 'テキストを取得　登記簿地目'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(36) > div > div:nth-child(2) > div:nth-child(1) > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　用途地域
        +get_text_52:
          action>: GetText
          display_name>: 'テキストを取得　用途地域'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(36) > div > div:nth-child(3) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　建ぺい率
        +get_text_53:
          action>: GetText
          display_name>: 'テキストを取得　建ぺい率'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(36) > div > div:nth-child(5) > div:nth-child(1) > div.row > div'
          ignoreError: true
          private: false

        # 検索して置換　建ぺい率%を削除
        +replace_text_17:
          action>: ReplaceText
          display_name>: '検索して置換　建ぺい率%を削除'
          text: +get_text_53
          find: '％'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　容積率
        +get_text_54:
          action>: GetText
          display_name>: 'テキストを取得　容積率'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(36) > div > div:nth-child(5) > div.mt-3.mt-sm-0.col-sm-6 > div:nth-child(2) > div'
          ignoreError: true
          private: false

        # 検索して置換　容積率%を削除
        +replace_text_18:
          action>: ReplaceText
          display_name>: '検索して置換　容積率%を削除'
          text: +get_text_54
          find: '％'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　その他の法令上の制限
        +get_text_55:
          action>: GetText
          display_name>: 'テキストを取得　その他の法令上の制限'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(36) > div > div:nth-child(6) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　建築確認番号
        +get_text_7:
          action>: GetText
          display_name>: 'テキストを取得　建築確認番号'
          browser: +click_11
          selector: '#__layout>div>div.p-frame-main>div.p-frame-content>div>div:nth-child(36)>div>div:nth-child(9)>div.mt-3.mt-sm-0.col-sm-9>div.row>div'
          ignoreError: true
          private: false

        # テキストを取得　土地権利
        +get_text_56:
          action>: GetText
          display_name>: 'テキストを取得　土地権利'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(38) > div > div:nth-child(1) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　地勢
        +get_text_75:
          action>: GetText
          display_name>: 'テキストを取得　地勢'
          browser: +click_11
          selector: '#__layout>div>div.p-frame-main>div.p-frame-content>div>div:nth-child(40)>div>div>div>div.row>div'
          ignoreError: true
          private: false

        # テキストを取得　接道１　接道種別
        +get_text_57:
          action>: GetText
          display_name>: 'テキストを取得　接道１　接道種別'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(43) > div > div:nth-child(5) > div:nth-child(1) > div:nth-child(1) > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　接道１　接道方向
        +get_text_58:
          action>: GetText
          display_name>: 'テキストを取得　接道１　接道方向'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(43) > div > div:nth-child(5) > div:nth-child(2) > div.mt-3.mt-sm-0.col-sm-6 > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　接道１　接道幅員
        +get_text_59:
          action>: GetText
          display_name>: 'テキストを取得　接道１　接道幅員'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(43) > div > div:nth-child(5) > div:nth-child(3) > div > div.row > div'
          ignoreError: true
          private: false

        # 検索して置換　接道１接道幅員mを削除
        +replace_text_19:
          action>: ReplaceText
          display_name>: '検索して置換　接道１接道幅員mを削除'
          text: +get_text_59
          find: 'ｍ'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　接道１　接道接面
        +get_text_60:
          action>: GetText
          display_name>: 'テキストを取得　接道１　接道接面'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(43) > div > div:nth-child(5) > div:nth-child(1) > div.mt-3.mt-sm-0.col-sm-6 > div.row > div'
          ignoreError: true
          private: false

        # 検索して置換　接道１接道接面mを削除
        +replace_text_20:
          action>: ReplaceText
          display_name>: '検索して置換　接道１接道接面mを削除'
          text: +get_text_60
          find: 'ｍ'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　接道２　接道種別
        +get_text_61:
          action>: GetText
          display_name>: 'テキストを取得　接道２　接道種別'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(43) > div > div:nth-child(8) > div:nth-child(1) > div:nth-child(1) > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　接道２　接道方向
        +get_text_62:
          action>: GetText
          display_name>: 'テキストを取得　接道２　接道方向'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(43) > div > div:nth-child(8) > div:nth-child(2) > div.mt-3.mt-sm-0.col-sm-6 > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　接道２　接道幅員
        +get_text_63:
          action>: GetText
          display_name>: 'テキストを取得　接道２　接道幅員'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(43) > div > div:nth-child(8) > div:nth-child(3) > div > div.row > div'
          ignoreError: true
          private: false

        # 検索して置換　接道２接道幅員mを削除
        +replace_text_21:
          action>: ReplaceText
          display_name>: '検索して置換　接道２接道幅員mを削除'
          text: +get_text_63
          find: 'ｍ'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　接道２　接道接面
        +get_text_64:
          action>: GetText
          display_name>: 'テキストを取得　接道２　接道接面'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(43) > div > div:nth-child(8) > div:nth-child(1) > div.mt-3.mt-sm-0.col-sm-6 > div.row > div'
          ignoreError: true
          private: false

        # 検索して置換　接道２接道接面mを削除
        +replace_text_22:
          action>: ReplaceText
          display_name>: '検索して置換　接道２接道接面mを削除'
          text: +get_text_64
          find: 'ｍ'
          use_regex: false
          replace_with: ''
          private: false

        # テキストを取得　備考１
        +get_text_65:
          action>: GetText
          display_name>: 'テキストを取得　備考１'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(49) > div > div:nth-child(1) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　備考２
        +get_text_66:
          action>: GetText
          display_name>: 'テキストを取得　備考２'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(49) > div > div:nth-child(2) > div > div.row > div'
          ignoreError: true
          private: false

        # テキストを取得　備考３
        +get_text_67:
          action>: GetText
          display_name>: 'テキストを取得　備考３'
          browser: +click_11
          selector: '#__layout > div > div.p-frame-main > div.p-frame-content > div > div:nth-child(49) > div > div:nth-child(3) > div > div.row > div'
          ignoreError: true
          private: false

        # リストを作成
        +create_list_2:
          action>: CreateList
          display_name>: 'リストを作成'
          items: ["+get_text_68","+get_text_69","+get_text_70","+get_text_71","+get_text_1","+get_text_2","+get_text_72","+replace_text_1","+replace_text_3","+get_text_5","+replace_text_4","+get_text_73","+get_text_74","+replace_text_5","+replace_text_6","+replace_text_11","+get_text_10","+get_text_11","+get_text_20","+get_text_21","+get_text_22","+get_text_23","+replace_text_10","+replace_text_7","+get_text_13","+get_text_24","+get_text_25","+replace_text_12","+replace_text_13","+get_text_28","+get_text_29","+get_text_30","+replace_text_14","+replace_text_15","+get_text_33","+get_text_34","+get_text_35","+get_text_36","+replace_text_16","+get_text_17","+get_text_16","+replace_text_8","+replace_text_9","+get_text_38","+get_text_39","+get_text_40","+get_text_41","+get_text_42","+get_text_43","+get_text_44","+get_text_45","+get_text_46","+get_text_47","+get_text_48","+get_text_49","+get_text_50","+get_text_51","+get_text_52","+replace_text_17","+replace_text_18","+get_text_55","+get_text_7","+get_text_56","+get_text_75","+get_text_57","+get_text_58","+replace_text_19","+replace_text_20","+get_text_61","+get_text_62","+replace_text_21","+replace_text_22","+get_text_65","+get_text_66","+get_text_67"]
          private: false

        # テキストを作成
        +text_1:
          action>: Text
          display_name>: 'テキストを作成'
          text: +create_list_2
          private: false

        # 既存のスプレッドシートを取得
        +get_spreadsheet_1:
          action>: GetSpreadsheet
          display_name>: '既存のスプレッドシートを取得'
          provider: gsheet_6fc388c1b905e2a7b918
          spreadsheet_id: 'https://docs.google.com/spreadsheets/d/15cR5bgkbzMZaK8sc91L0N8zzxeTEmk1f-fFs3qZ1P4c/edit?gid=0#gid=0'
          private: false
          meta:
            display:
              provider:
                type: chip
                label: 'Google Spreadsheet (awane@kaedekoumuten.jp)'
                icon: googlespreadsheet

        # 末尾に値を追加
        +append_values_1:
          action>: AppendValues
          display_name>: '末尾に値を追加'
          spreadsheet: +get_spreadsheet_1
          range: "'本店エリア'!A2"
          values: +create_list_2
          private: false

    # 真のとき
    +if_1:
      if>:
        display_name>: '真のとき'
        condition: ${error}
        private: false
      _do:

        # Chatworkにメッセージを送信
        +send_chatwork_message_1:
          action>: SendChatworkMessage
          display_name>: 'Chatworkにメッセージを送信'
          provider: chatwork_93512c51cdcb76333d0a
          room_id: 376178437
          body: '[To:3783567]新規登録　中古戸建でエラーが出ました'
          self_unread: false
          private: false
          meta:
            display:
              provider:
                type: chip
                label: 'Chatwork (andy@kaedekoumuten.jp)'
                icon: chatwork

# 正常終了
+exit_2:
  exit>:
    display_name>: '正常終了'
    message: ''
    private: false

# ブラウザを開く　物件王ログイン画面
+open_browser_1:
  action>: OpenBrowser
  display_name>: 'ブラウザを開く　物件王ログイン画面'
  url: 'https://new.bukken1.com/member/login'
  lang: 'ja-JP'
  headless: false
  confirm: true
  windowSize: '1920 x 1080'
  useShadowDomSelector: false
  private: false

# 文字入力　物件王　会社ID
+type_text_1:
  action>: TypeText
  display_name>: '文字入力　物件王　会社ID'
  browser: +open_browser_1
  selector: '.form-group:nth-child(2) .form-control'
  text: U0145
  clearValue: false
  waitBefore: 1000
  ignoreError: false
  private: false

# 文字入力　物件王　ログインID
+type_text_2:
  action>: TypeText
  display_name>: '文字入力　物件王　ログインID'
  browser: +type_text_1
  selector: '.form-group:nth-child(3) .form-control'
  text: AUTORO
  clearValue: true
  ignoreError: false
  private: false

# パスワード入力　物件王　
+type_password_1:
  action>: TypePassword
  display_name>: 'パスワード入力　物件王　'
  browser: +type_text_2
  selector: 'div:nth-of-type(4) .form-control'
  password: '********'
  ignoreError: false
  private: false

# クリック　物件王　ログインボタン
+click_1:
  action>: Click
  display_name>: 'クリック　物件王　ログインボタン'
  browser: +type_password_1
  selector: '.bg-black'
  confirm: true
  waitAfter: 10000
  ignoreError: false
  timeout: 5000
  private: false

# 新規登録画面を開く
+go_to_1:
  action>: GoTo
  display_name>: '新規登録画面を開く'
  browser: +click_1
  url: 'https://new.bukken1.com/member/bukken/regist'
  private: false

# クリック　物件王　種別選択　戸建
+click_4:
  action>: Click
  display_name>: 'クリック　物件王　種別選択　戸建'
  browser: +go_to_1
  selector: '#tab_kodate b'
  confirm: true
  waitAfter: 2000
  ignoreError: false
  timeout: 5000
  private: false

# クリック　物件王　中古
+click_5:
  action>: Click
  display_name>: 'クリック　物件王　中古'
  browser: +click_4
  selector: "//label[translate(normalize-space(.), '　', '') = \"中古\"]"
  confirm: true
  ignoreError: false
  timeout: 5000
  private: false

# クリック　物件王　登録画面へ
+click_6:
  action>: Click
  display_name>: 'クリック　物件王　登録画面へ'
  browser: +click_5
  selector: 'button.btn'
  confirm: true
  waitAfter: 6000
  ignoreError: false
  timeout: 5000
  private: false

# 文字入力　物件王　レインズ番号
+type_text_5:
  action>: TypeText
  display_name>: '文字入力　物件王　レインズ番号'
  browser: +click_6
  selector: '#bukken-kihon > div > div:nth-child(1) > div:nth-child(2) > div > div > input'
  text: ${reinsnumber[8]}
  clearValue: false
  ignoreError: false
  private: false

# クリック　【条件・設備」タブ
+click_12:
  action>: Click
  display_name>: 'クリック　【条件・設備」タブ'
  browser: +type_text_5
  selector: '#bukken-setsubi-btn'
  confirm: true
  ignoreError: false
  timeout: 5000
  private: false

# クリック　構造
+click_13:
  action>: Click
  display_name>: 'クリック　構造'
  browser: +click_12
  selector: '#bukken-setsubi > div > div:nth-child(2) > div:nth-child(1) > div > div:nth-child(2) > span > span.selection > span > span.select2-selection__arrow > b'
  confirm: true
  ignoreError: false
  timeout: 5000
  private: false

# 文字入力　構造
+type_text_6:
  action>: TypeText
  display_name>: '文字入力　構造'
  browser: +click_13
  selector: '#parent > span > span > span.select2-search.select2-search--dropdown > input'
  text: +get_text_16
  clearValue: false
  ignoreError: false
  private: false

# スクリーンショットを撮る
+take_screenshot_2:
  action>: TakeScreenshot
  display_name>: 'スクリーンショットを撮る'
  browser: +send_keys_1
  full_page: false
  type: png
  waitBefore: 500
  private: false

# 正常終了
+exit_1:
  exit>:
    display_name>: '正常終了'
    message: ''
    private: false

# キーを送信
+send_keys_1:
  action>: SendKeys
  display_name>: 'キーを送信'
  browser: +type_text_6
  selector: '#parent > span > span > span.select2-search.select2-search--dropdown > input'
  keys: ["Enter"]
  ignoreError: false
  private: false