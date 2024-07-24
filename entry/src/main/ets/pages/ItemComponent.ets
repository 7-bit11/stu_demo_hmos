import router from '@ohos.router';
import { PageEntry } from '../entryability/PageEntry';

@Entry
@Component
export  struct FramePage {
  @Prop page: PageEntry;
  @Prop index: number;

  build() {
    Row() {
      Text("Demo" + this.index.toString()).ItemTextStyle()
      Blank()
      Text(this.page.title).ItemTextStyle()
    }.CardStyle()
    .onClick((_) => {
      router.pushUrl({ url: this.page.path, params: { "title": this.page.title } },
        router.RouterMode.Single,
        error => {
          if (error) {
            console.log('跳转失败 code:' + error.code + ' msg:' + error.message)
          }
        }
      )
    })
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
