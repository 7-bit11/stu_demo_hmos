import { router } from '@kit.ArkUI';

@Entry
@Component
struct ImagePage {
  @State title: string = "";
  params: object = router.getParams();

  aboutToAppear(): void {
    this.title = this.params['title'];
  }

  build() {
    Navigation() {
      List({ space: 10 }) {
        ListItem() {
          // net work image
          Image("https://konachan.net/sample/9d26338140a88eff00b47c05bc3ec54f/Konachan.com%20-%20379074%20sample.jpg")//展位图
            .alt($rawfile("loading.gif"))//拓展方式
            .objectFit(ImageFit.Auto)
        }

        ListItem() {
          // local media image
          Image($r("app.media.img"))
        }

        ListItem() {
          //local rawfile image
          Image($rawfile("img.png"))
        }
      }
    }.title(this.title)//.titleMode(NavigationTitleMode.Full)
    .onClick(()=>{
      router.back()
    })
  }
}