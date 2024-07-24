import router from '@ohos.router';

@Entry
@Component
struct TransAnimatePage {
  @State _fSize: number = 150;
  @State title: string = "";
  params: object = router.getParams();
  @State _isShow: boolean = false

  aboutToAppear(): void {
    this.title = this.params['title'];
  }

  build() {
    Navigation() {
      Column() {
        if (this._isShow) {
          Image($r("app.media.img"))
            .autoResize(true)
            .width(this._fSize)
            .height(this._fSize)
            .animation({
              duration: 1000,
              curve: Curve.EaseInOut
            })//transition 转场动画
              //opacity 默认显示状态 0=透明
              //rotate 旋转角度 end
              //scale 放大缩小倍率
              //translate 平移坐标
              //type TransitionType 有 insert和Delete类型
              //转场和入场动画需要分别添加
            .transition({
              opacity: 0,
              rotate: { angle: 0 },
              //scale: { x: this._fSize, y: this._fSize },
              translate: { x: -300 },
              type: TransitionType.Insert
            })
            .transition({
              opacity: 0,
              rotate: { angle: 0 },
              //scale: { x: this._fSize, y: this._fSize },
              translate: { x: -300 },
              type: TransitionType.Delete
            })
        }


        Button(`${this._isShow ? "隐藏" : "展示"}`).ButtonStyleMy()
          .onClick(() => {
            animateTo({ duration: 1000 }, () => {
              this._isShow = !this._isShow
            })
            // if (!this._isShow) {
            //   this._fSize = 150
            // } else {
            //   this._fSize = 0
            // }
          })
      }
      .height('100%')
      .width('100%')
      .padding(20)
    }.title(this.title)
  }
}

@Extend(Button)
function ButtonStyleMy() {
  .width(80)
  .fontWeight(20)
}