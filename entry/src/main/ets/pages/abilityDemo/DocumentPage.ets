@Entry
@Component
struct DocumentPage {
  build() {


  }

  @Builder
  appBar() {
    Column() {
      Row() {
        Image($r("app.media.back")).width(24).height(24)
        Text("文档中心")
      }

      TextInput().defaultFocus(true)
    }.height('100%')
    .width('100%')

  }
}