import router from '@ohos.router';
import { Font } from '@ohos.arkui.UIContext';

@Entry
@Component
struct BuilderStylesPage {
  @State _fSize: number = 200;
  @State title: string = "";
  params: object = router.getParams();

  aboutToAppear(): void {
    this.title = this.params['title'];
  }

  build() {
    Column() {
      Appbar(this.title)
      Image($r("app.media.img"))
    }.height("100%").height("100%")

  }
}

@Builder
function Appbar(title: string) {
  Row() {
    Text("返回").onClick(() => router.back()).AppbarTextStyle()
    Text(title).AppbarTextStyle1()
    Image($rawfile("img.png")).width(40).height(40)
  }.justifyContent(FlexAlign.SpaceBetween)
  .width("100%")
}

@Styles
function AppbarTextStyle() {
  .width(50)
}

@Extend(Text)
function AppbarTextStyle1() {
  .fontSize(18)
  .fontWeight(FontWeight.Bold)
  .fontColor(Color.Red)
}