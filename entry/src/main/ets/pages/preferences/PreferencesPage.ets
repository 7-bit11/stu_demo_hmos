import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import PreferencesUtil from '../../component/PreferencesUtil';

@Entry
@Component
struct PreferencesPage  {
  @State _fSize: number = 50;
  @State title: string = "";
  params: object = router.getParams();

  async aboutToAppear() {
    this.title = this.params['title'];
    this._fSize = await PreferencesUtil.getValue("size", 50) as number;
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
          Text(this._fSize.toString())
        }

        Button('缩小').ButtonStyleMy()
          .onClick( () => {
            if (this._fSize <= 30) {
              this.showToast("到达最小值")
              return
            }
            this._fSize -= 10
            PreferencesUtil.putValue("size", this._fSize);
          })

        Button('放大').ButtonStyleMy()
          .type(ButtonType.Normal)
          .onClick(() => {
            if (this._fSize >= 300) {
              this.showToast("到达最大值")
              return
            }
            this._fSize += 10
            PreferencesUtil.putValue("size", this._fSize);
          })
        Slider({
          min: 20, //最小
          max: 300, //最大
          value: this._fSize, //当前值
          step: 5, //步长
          style: SliderStyle.OutSet,
          direction: Axis.Horizontal, //滑动方向
          reverse: false //是否反向
        }).onChange(value => {
          this._fSize = Math.floor(value)
          PreferencesUtil.putValue("size", this._fSize);
        })
      }
      .height('100%')
      .width('100%')
      .padding(20)
    }.title(this.title)
  }

  showToast(msg: string | Resource): void {
    promptAction.showToast({
      message: msg, duration: 2000
    })
  }
}

@Extend(Button)
function ButtonStyleMy() {
  .width(80)
  .fontWeight(20)
}