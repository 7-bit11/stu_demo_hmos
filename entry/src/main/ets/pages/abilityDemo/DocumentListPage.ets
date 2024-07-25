import router from '@ohos.router';
import { FramePage } from '../ItemComponent';

@Entry
@Component
struct DocumentListPage {
  params: object = router.getParams();
  @State title: string = "";
  index: number = 1;
  @State docs: Array<number> = [];

  aboutToAppear(): void {
    this.title = this.params['title'];
  }

  build() {
    Navigation() {
      Column() {
        Button('添加文档').onClick(() => {
          this.docs.push(this.index++)
        })
        List({ space: 10 }) {
          ForEach(this.docs, (id: number) => {
            ListItem() {
              Row() {
                Text(`文档：${id}` ).ItemTextStyle()
                Blank()
              }.CardStyle()
            }
          })
        }.padding(20)
      }
    }.title(this.title) //.titleMode(NavigationTitleMode.Full)

  }
}

@Extend(Text)
function ItemTextStyle() {
  .fontColor(Color.White)
  .fontSize(16)
  .fontWeight(FontWeight.Bold)
}

@Extend(Row)
function CardStyle() {
  .padding(15)
  .backgroundColor("#3f85ff")
  .borderRadius(10)
  .width("100%")
}
