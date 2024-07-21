import router from '@ohos.router';

@Entry
@Component
struct ColumnRowPage {
  @State _fSize: number = 100;
  @State title: string = "";
  params: object = router.getParams();

  aboutToAppear(): void {
    this.title = this.params['title'];
  }

  build() {
    Navigation() {
      Column({ space: 20 }) {
        Text("Column")
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Image($r("app.media.img"))
          .autoResize(true)
          .width(this._fSize)
          .height(this._fSize)
          .borderRadius(10)
        Text("Row")
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Row({ space: 20 }) {
          Image($r("app.media.img"))
            .autoResize(true)
            .width(this._fSize)
            .height(this._fSize)
            .borderRadius(10)
          Image($r("app.media.img"))
            .autoResize(true)
            .width(this._fSize)
            .height(this._fSize)
            .borderRadius(10)
        }

        Row({space:10}) {
          Image($r("app.media.img"))
            .autoResize(true)
            .width(this._fSize)
            .height(this._fSize)
            .borderRadius(10)
          Image($r("app.media.img"))
            .autoResize(true)
            .width(this._fSize)
            .height(this._fSize)
            .borderRadius(10)
          Image($r("app.media.img"))
            .autoResize(true)
            .width(this._fSize)
            .height(this._fSize)
            .borderRadius(10)
        }.justifyContent(FlexAlign.End)
        .alignItems(VerticalAlign.Bottom)
        .width("100%")
      }
      .height('100%')
      .width('100%')
      .padding(20)
    }.title(this.title)

    // .onClick(() => {
    //   router.back()
    // })
  }
}