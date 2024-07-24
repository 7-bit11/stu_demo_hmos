import promptAction from '@ohos.promptAction';
import router from '@ohos.router';
import { display } from '@kit.ArkUI';

@Entry
@Component
struct AnimatePage {
  @State _fSize: number = 50;
  @State title: string = "";
  params: object = router.getParams();
  @State x: number = 0
  @State y: number = 0
  @State angle: number = 0

  aboutToAppear(): void {
    this.title = this.params['title'];
    let displayClass: display.Display | null = null;
    try {
      displayClass = display.getDefaultDisplaySync();
      console.log("===========================================")
      console.log(displayClass.width.toString())
      console.log(displayClass.height.toString())
      console.log("===========================================")
      this.x = displayClass.width / 2 - 100;
      this.y = displayClass.height / 2 - 100;
    } catch (exception) {
      console.error('Failed to obtain the default display object. Code: ' + JSON.stringify(exception));
    }
  }

  build() {
    Navigation() {
      Column() {
        Image($r("app.media.img"))
          .autoResize(true)
          .width(this._fSize)
          .height(this._fSize)
          .position({
            x: `${this.x - (this._fSize / 2 + 25)}px`, y: `${this.y - (this._fSize / 2 - 25)}px`
          })
          .rotate({
            angle: this.angle, //旋转角度
            centerX: "50%", //旋转时x轴点位
            centerY: "50%"//选择时y轴点位
          })
          .animation({
            duration: 1000,
            curve: Curve.EaseInOut
          })
        Row() {
          Text("图片大小")
          Text(this._fSize.toString())
        }


        this.getRowButton()
        this
          .getColumnButton()
      }
      .height('100%')
      .width('100%')
      .padding(20)
    }.title(this.title)
  }

  @Builder
  getRowButton() {
    Button('缩小').ButtonStyleMy()
      .onClick(() => {
        if (this._fSize <= 30) {
          this.showToast("到达最小值")
          return
        }
        this._fSize -= 10
      })

    Button('放大').ButtonStyleMy()
      .type(ButtonType.Normal)
      .onClick(() => {
        if (this._fSize >= 300) {
          this.showToast("到达最大值")
          return
        }
        this._fSize += 10
      })
  }

  @Builder
  getColumnButton() {
    Button('左位移').ButtonStyleMy()
      .onClick(() => {
        this.x -= 30
      })
    Button('右位移').ButtonStyleMy()
      .onClick(() => {
        this.x += 30
      })
    Button('上位移').ButtonStyleMy()
      .onClick(() => {
        this.y -= 30
      })
    Button('下位移').ButtonStyleMy()
      .onClick(() => {
        this.y += 30
      })
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