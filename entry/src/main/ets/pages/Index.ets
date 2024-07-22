import { router } from '@kit.ArkUI';
import { PageEntry } from '../entryability/PageEntry';

@Entry
@Component
struct Index {
  pages: Array<PageEntry> = [
    new PageEntry("pages/widget/ImagePage", "ImageDemo"),
    new PageEntry("pages/widget/TextPage", "TextDemo"),
    new PageEntry("pages/widget/ButtonPage", "ButtonDemo"),
    new PageEntry("pages/widget/SliderPage", "SliderDemo"),
    new PageEntry("pages/widget/ColumnRowPage", "Column&RowDemo"),
    new PageEntry("pages/widget/ForEachPage", "ForeachDemo"),
    new PageEntry("pages/widget/ListPage", "ListDemo"),
    new PageEntry("pages/widget/BuilderStylesPage", "BuilderStylesExtendDemo")
  ];
  index: number = 1;

  build() {
    Navigation() {
      List({ space: 10 }) {
        ForEach(this.pages, (item: PageEntry) => {
          ListItem() {
            Item({ page: item, index: this.index++ })
          }
        })
      }.padding(20)
    }.title("bitDemo")
    .titleMode(NavigationTitleMode.Full)

  }

  //Builder只能在Component中使用
  @Builder
  Item1() {

  }
}

@Component
struct Item {
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
