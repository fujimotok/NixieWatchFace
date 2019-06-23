# Nixie Watch Face
これはxcodeのprojectではありません。コード断片です。自分用のメモ。
# How to Build
## project新規作成
watchOS > iOS App with WatchKit App
next
product name入力
あとはデフォルトでもok
## Capabilities 設定
左上project設定ファイルをクリックして
targets > "product name" をクリック
Generalの隣のCapabilitiesをクリック
HealthKitをONに
同様に targets > "product name WatchKit Extensinon" をクリック
"product name"ディレクトリのinfo.plistを開く
追加(行のどこかで+マークをクリック)で"Privacy-Health share usage"を追加し理由を記述
## 実行してみる
左上再生マーク
再生マークの隣はターゲット
実機デバッグするなら接続していれば実機名がでるはず
設定 > 一般　> プロファイルとデバイス管理 に自分のディベロッパIDでると思うので許可
apple watch上で動かすと"信頼されていないデベロッパーうんぬん"がでるので許可
## リソースの準備
0−9.png,dot2.pngを"product name WatchKit App"の下にコピー
## Storyboardの編集
Interface Controller:InterfaceController FullScreen[true]
- BatteryGroup:Group
  - Battery100Img:Image mode[Aspect fit] size[w:Relative to Container:0.3, h:Relative to Container:1]
  - Battery010Img:Image mode[Aspect fit] size[w:Relative to Container:0.3, h:Relative to Container:1]
  - Battery001Img:Image mode[Aspect fit] size[w:Relative to Container:0.3, h:Relative to Container:1]
- DateGroup:Group
  - DateYear1000Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - DateYear0100Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - DateYear0010Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - DateYear0001Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - Dot2Img:Image img[dot2] mode[Aspect fit] size[w:Relative to Container:0.03, h:Relative to Container:1]
  - DateMonth10Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - DateMonth01Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - Dot2Img:Image img[dot2] mode[Aspect fit] size[w:Relative to Container:0.03, h:Relative to Container:1]
  - DateDay10Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - DateDay01Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - Dot2Img:Image img[dot2] mode[Aspect fit] size[w:Relative to Container:0.03, h:Relative to Container:1]
  - DateWeekDayImg:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
- ClockGroup:Group
  - ClockHour10Img:Image mode[Aspect fit] size[w:Relative to Container:0.15, h:Relative to Container:1]
  - ClockHour01Img:Image mode[Aspect fit] size[w:Relative to Container:0.15, h:Relative to Container:1]
  - Dot2Img:Image img[dot2] mode[Aspect fit] size[w:Relative to Container:0.05, h:Relative to Container:1]
  - ClockMin10Img:Image mode[Aspect fit] size[w:Relative to Container:0.15, h:Relative to Container:1]
  - ClockMin01Img:Image mode[Aspect fit] size[w:Relative to Container:0.15, h:Relative to Container:1]
  - Dot2Img:Image img[dot2] mode[Aspect fit] size[w:Relative to Container:0.05, h:Relative to Container:1]
  - ClockSec10Img:Image mode[Aspect fit] size[w:Relative to Container:0.15, h:Relative to Container:1]
  - ClockSec01Img:Image mode[Aspect fit] size[w:Relative to Container:0.15, h:Relative to Container:1]
- ActivityGroup:Group
  - ActivityMove1000Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - ActivityMove0100Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - ActivityMove0010Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - ActivityMove0001Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - Dot2Img:Image img[dot2] mode[Aspect fit] size[w:Relative to Container:0.03, h:Relative to Container:1]
  - ActivityExercize100Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - ActivityExercize010Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - ActivityExercize001Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - Dot2Img:Image img[dot2] mode[Aspect fit] size[w:Relative to Container:0.03, h:Relative to Container:1]
  - ActivityStand10Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
  - ActivityStand01Img:Image mode[Aspect fit] size[w:Relative to Container:0.1, h:Relative to Container:1]
- SpriteKit Scene:SpriteKit size[w:Size to Fit Content, h:Fixed:2]
## コードのコピー
"product name"のViewController.swiftを編集
"product name WatchKit Extensinon"のInterfaceController.swiftを編集
outletはコピペ後にコード側の○から張ることができる

# TODO
天気予報の表示
