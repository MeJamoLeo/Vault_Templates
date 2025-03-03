---
tags:
  - "#web-development"
  - "#web-scraping"
  - "#real-estate-data"
  - "#javascript"
---
# **JavaScript ドキュメント: 不動産データ取得スクリプト**

```js
function extractPropertyData() {
	let data = {};

	// h2 タグの下のすべてのデータを取得する関数
	function getSectionData(h2Text) {
		let sections = document.querySelectorAll("h2");
		for (let h2 of sections) {
			if (h2.innerText.trim() === h2Text) {
				let sectionData = {};
				let nextElement = h2.nextElementSibling;

				while (nextElement && nextElement.tagName !== "H2") {
					if (nextElement.classList.contains("card")) {
						let labels = nextElement.querySelectorAll(".p-label-title");
						labels.forEach(label => {
							let valueElement = label.closest(".p-label").nextElementSibling;
							sectionData[label.innerText.trim()] = valueElement ? valueElement.innerText.trim() : "";
						});
					}
					nextElement = nextElement.nextElementSibling;
				}
				return sectionData;
			}
		}
		return {};
	}

	// 各セクションごとにデータを取得
	data["基本情報"] = getSectionData("基本情報");
	data["分類"] = getSectionData("分類");
	data["取引"] = getSectionData("取引");
	data["担当"] = getSectionData("担当");
	data["価格"] = getSectionData("価格");
	data["面積・不動産ＩＤ"] = getSectionData("面積・不動産ＩＤ");
	data["所在"] = getSectionData("所在");
	data["交通"] = getSectionData("交通");
	data["間取"] = getSectionData("間取");
	data["建物"] = getSectionData("建物");
	data["維持"] = getSectionData("維持");
	data["駐車場"] = getSectionData("駐車場");
	data["現況"] = getSectionData("現況");
	data["引渡"] = getSectionData("引渡");
	data["報酬・負担割合"] = getSectionData("報酬・負担割合");
	data["法規"] = getSectionData("法規");
	data["権利"] = getSectionData("権利");
	data["土地"] = getSectionData("土地");
	data["接道"] = getSectionData("接道");
	data["環境"] = getSectionData("環境");
	data["設備・条件・住宅性能等"] = getSectionData("設備・条件・住宅性能等");
	data["備考"] = getSectionData("備考");

	// 画像取得
	data.images = [];
	document.querySelectorAll(".col-image").forEach(el => {
		let fileEl = el.querySelector(".p-label-title");
		if (fileEl && fileEl.innerText.includes("ファイル名")) {
			let file = fileEl.closest(".p-label").nextElementSibling?.innerText.trim();
			let img = el.querySelector("div[style*='background']")?.style.backgroundImage;
			let url = img ? img.match(/url\("(.*?)"\)/)[1] : null;
			if (file && url) {
				data.images.push({ file, url });
			}
		}
	});

	// PDF図面取得
	data.documents = [];
	let pdfFile = getSectionData("物件図面")["ファイル名"];
	if (pdfFile) {
		data.documents.push({ file: pdfFile, url: "#" });
	}

	return data;
}
```


## **概要**

このスクリプトは、不動産物件情報の HTML 構造からデータを抽出し、JSON 形式で整理するためのものです。 `h2` タグの下にある情報をすべて取得し、分類ごとにオブジェクトへ格納します。

---

## **コードの動作**

1. `h2` タグを検索し、その下の `.card` 要素に含まれるデータを取得。
2. 各カテゴリのデータを JSON 形式で整理。
3. 画像および PDF 図面の情報も取得。
4. `console.log()` で JSON データを出力。

---

## **関数の詳細**

### **`extractPropertyData()`**

スクリプトのメイン関数。すべてのデータを収集し、最終的な JSON オブジェクトを生成。

### **`getSectionData(h2Text)`**

#### **機能**

指定された `h2` タグの下にあるデータを取得し、オブジェクトとして返す。

#### **処理フロー**

1. `h2` タグを検索。
2. 次の要素 (`nextElementSibling`) を探索。
3. `.card` クラスを持つ要素内の `.p-label-title` をキーにし、対応する値を取得。
4. `h2` タグが再び現れるまで探索。

#### **引数**

- `h2Text` (文字列): 探索対象の `h2` タグのテキスト。

#### **戻り値**

- `Object`: キーがデータラベル、値が取得した内容のオブジェクト。

**例:**

```json
{
    "物件番号": "300133144482",
    "登録年月日": "令和 7年 2月21日",
    "変更年月日": "令和 7年 3月 3日",
    "更新年月日": "令和 7年 2月21日"
}
```

### **画像取得処理**

#### **処理フロー**

1. `.col-image` クラスを持つ要素を探索。
2. `.p-label-title` の内容が `ファイル名` を含む場合、その次の要素の内容を取得。
3. `background-image` スタイルから URL を抽出。
4. 画像情報の配列を生成。

#### **戻り値 (例)**

```json
{
    "file": "IMG_0353.JPG",
    "url": "/main/api/KG/GKG010100/findBkknGzuThm?id=100104886807&gzuBngu=1"
}
```

### **PDF図面取得処理**

#### **処理フロー**

1. `getSectionData("物件図面")` を呼び出し、"ファイル名" を取得。
2. 取得できた場合、ドキュメント情報として格納。

#### **戻り値 (例)**

```json
{
    "file": "300133144482.pdf",
    "url": "#"
}
```

---

## **出力される JSON 構造 (例)**

```json
{
    "basic_info": {
        "物件番号": "300133144482",
        "登録年月日": "令和 7年 2月21日",
        "変更年月日": "令和 7年 3月 3日",
        "更新年月日": "令和 7年 2月21日"
    },
    "category": {
        "物件種目": "中古戸建",
        "広告転載区分": "不可"
    },
    "transaction": {
        "取引態様": "一般",
        "媒介契約年月日": "",
        "取引状況": "",
        "取引状況の補足": ""
    },
    "contact": {
        "商号": "（株）福屋不動産販売 京田辺店",
        "代表電話番号": "0774-68-0660",
        "Ｅメールアドレス": "kyotanabe@fukuya-k.co.jp"
    },
    "price": {
        "価格": "1,180万円",
        "変更前価格": "1,280万円"
    },
    "images": [
        {
            "file": "061002336000-01.JPG",
            "url": "/main/api/KG/GKG010100/findBkknGzuThm?id=100108425552&gzuBngu=1"
        }
    ],
    "documents": [
        {
            "file": "300133144482.pdf",
            "url": "#"
        }
    ]
}
```

---

## **実行方法**

1. **ブラウザの DevTools を開く (F12)**
2. **Console にスクリプトを貼り付けて実行**
3. **`console.log(extractPropertyData())` を実行してデータを取得**

🚀 **これで不動産情報を JSON 形式で取得できます！**