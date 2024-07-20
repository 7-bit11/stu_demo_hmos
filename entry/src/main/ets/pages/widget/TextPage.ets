import router from '@ohos.router';

@Entry
@Component
struct TextPage {
  @State _fSize: number = 50;
  textController: TextInputController = new TextInputController();
  @State title: string = "";
  params: object = router.getParams();

  aboutToAppear(): void {
    this.title = this.params['title'];
  }

  build() {
    Navigation() {
      Column() {
        Image($r("app.media.img"))
          .autoResize(true)
          .width(this._fSize)
          .height(this._fSize)
        Text($r("app.string.text_page"))
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            router.back()
          })
        Row() {
          Text("图片大小")
          TextInput({ text: this._fSize.toString() })
            .type(InputType.Number).onChange(value => {
            this._fSize = parseInt(value)
          })
        }

        Slider({ value: this._fSize, min: 20, max: 200 })
          .onChange(value => {
            this._fSize = Math.floor(value);
          })
      }
      .height('100%')
      .width('100%')
      .padding(20)
    }.title(this.title) //.titleMode(NavigationTitleMode.Full)

  }
}