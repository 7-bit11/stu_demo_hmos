import Want from '@ohos.app.ability.Want'
import common from '@ohos.app.ability.common';

@Entry
@Component
struct DocumentPage {
  build() {
    Column() {
      this.appBar()
    }

  }

  private context = getContext(this) as common.UIAbilityContext;

  @Builder
  appBar() {
    Column() {
      Row() {
        Image($r("app.media.back")).width(24).height(24).backgroundColor(Color.Black).onClick(() => {
          let want: Want = {
            deviceId: "",
            bundleName: "com.bit.stu_demo",
            moduleName: "entry",
            abilityName: "EntryAbility"
          }
          this.context.startAbility(want)
        })
        Blank()
        Text("文档中心")
      }

      TextInput().defaultFocus(true)
    }.height('100%')
    .width('100%')
    .padding(20)

  }
}