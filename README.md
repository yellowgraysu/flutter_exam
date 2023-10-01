# flutter_exam

## 6. Design widget

如設計圖所示，講師清單畫面可以看到所有講師的資訊，將講師資訊卡片點開後能看到該講師所開授的課程列表，每個課程可以再導去各自的課程內容頁。

**請根據設計圖設計出實作時所需要的 widget 及 class**

## 7. Design sqlite schema
請設計一個關連式資料庫（[設計參考](https://support.microsoft.com/zh-hk/office/%E8%B3%87%E6%96%99%E5%BA%AB%E8%A8%AD%E8%A8%88%E7%9A%84%E5%9F%BA%E6%9C%AC%E6%A6%82%E5%BF%B5-eb2159cf-1e30-401a-8084-bd4f9c9ca1f5)）可對應此選課系統內容，補充需求如下：

講師
- 持有帳號密碼可登入系統
- 講師可管理名下管理課程 (CRUD)
- 講師可查詢指定課程選課學生清單

學生
- 持有帳號密碼可登入系統
- 學生可查詢課程清單
- 學生可查詢講師清單
- 學生可即時選課或修改選課結果 (CRUD)

**請設計出所有必須資料表，包含但不限於以下資料**
- table name
- table columns
	- name
	- type
- table indexes
	- index 對應欄位與目的

## 8. Design service class
請設計如下 API：
- 課程列表 API (Read)
- 授課講師列表 API (Read)
- 授課講師所開課程列表 API (Read)
- 建立新講師 API (Create)
- 建立新課程 API (Create)
- 更新課程內容 API (Update)
- 刪除課程 API (Delete)
- 請提供 service class 與 response


## 9. Write test for service
在前面兩題的系統 API 設計中請試著隨意設計三個 API Test case，請列出
- Test case 的名稱與目的
- 途中建立的測資
- 對應完成測試所需的 assertion

如無測試相關經驗，可參考
1. https://docs.flutter.dev/testing#widget-tests
2. https://tw.alphacamp.co/blog/tdd-test-driven-development-example
3. https://medium.com/%E6%88%91%E6%83%B3%E8%A6%81%E8%AE%8A%E5%BC%B7/tdd-test-driven-development-%E6%B8%AC%E8%A9%A6%E9%A9%85%E5%8B%95%E9%96%8B%E7%99%BC-%E5%85%A5%E9%96%80%E7%AF%87-e3f6f15c6651 
