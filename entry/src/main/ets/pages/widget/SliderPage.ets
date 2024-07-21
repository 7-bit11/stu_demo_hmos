import router from '@ohos.router';

@Entry
@Component
struct SliderPage {
  @State _fSize: number = 50;
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
          .borderRadius(10)
        Text($r("app.string.text_page"))
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            router.back()
          })
        Row() {
          Text("图片大小")
          Text(this._fSize.toString())
        }

        Text("OutSet")
        Slider({
          min: 20, //最小
          max: 300, //最大
          value: this._fSize, //当前值
          step: 5, //步长
          style: SliderStyle.OutSet,
          direction: Axis.Horizontal, //滑动方向
          reverse: false //是否反向
        }).onChange(value => this._fSize = Math.floor(value))
        //onChange 滑动值改变时触发
        Text("InSet")
        Slider({
          min: 20, //最小
          max: 300, //最大
          value: this._fSize, //当前值
          step: 5, //步长
          style: SliderStyle.InSet,
          direction: Axis.Horizontal, //滑动方向
          reverse: false //是否反向
        })
          .onChange(value => this._fSize = Math.floor(value))
          .blockColor("#36d")  //已经滑动的
          .trackColor(Color.White)  //未滑动到的
          .trackThickness(20) //滑轨的粗细
          .showSteps(true)//显示步长
          .showTips(true) //显示百分比进度
        //onChange 滑动值改变时触发
      }
      .height('100%')
      .width('100%')
      .padding(20)
    }.title(this.title)
  }
}