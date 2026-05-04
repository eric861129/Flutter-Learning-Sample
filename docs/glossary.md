# 術語表

## App Shell

App 的外殼，通常包含 `MaterialApp`、router、theme、全域 provider scope。

## Feature-first

依功能切分資料夾。相關的 domain、data、presentation 放在同一個 feature 裡。

## Layer-first

依技術層切分資料夾，例如 `models/`、`services/`、`views/`。小專案容易開始，但功能變多時相關檔案會分散。

## Domain Model

App 內部真正使用的資料模型。它不一定等於 API 回傳的 JSON 結構。

## Repository

資料入口。ViewModel 透過 repository 取得資料，不直接知道資料來自 HTTP、本地資料庫或快取。

## Service

和外部系統溝通的類別，例如 HTTP API、本地儲存、平台 API。

## View

畫面。負責 render UI，並把使用者事件轉交給 ViewModel。

## ViewModel

管理 UI state 與畫面事件。它把 repository 的資料轉成 View 可以呈現的狀態。

## AsyncValue

Riverpod 用來表示非同步狀態的型別，通常包含 loading、data、error 三種狀態。

## Provider Override

Riverpod 測試技巧。測試時用 fake implementation 取代真實 provider，避免打真實 API。
