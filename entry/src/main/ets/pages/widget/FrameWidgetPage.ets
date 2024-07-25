import router from '@ohos.router';
import { PageEntry } from '../../entrys/PageEntry';
import { FramePage } from '../ItemComponent';

@Entry
@Component
struct FrameWidgetPage {
  params: object = router.getParams();
  @State title: string = "";
  index: number = 1;

  aboutToAppear(): void {
    this.title = this.params['title'];
  }

  pages: Array<PageEntry> = [
    new PageEntry("pages/widget/ImagePage", "ImageDemo"),
    new PageEntry("pages/widget/TextPage", "TextDemo"),
    new PageEntry("pages/widget/ButtonPage", "ButtonDemo"),
    new PageEntry("pages/widget/SliderPage", "SliderDemo"),
    new PageEntry("pages/widget/ColumnRowPage", "Column&RowDemo"),
    new PageEntry("pages/widget/ForEachPage", "ForeachDemo"),
    new PageEntry("pages/widget/ListPage", "ListDemo"),
    new PageEntry("pages/widget/BuilderStylesPage", "BuilderStylesExtendDemo"),
  ];

  build() {
    Navigation() {
      List({ space: 10 }) {
        ForEach(this.pages, (item: PageEntry) => {
          ListItem() {
            FramePage({ page: item, index: this.index++ })
          }
        })
      }.padding(20)
    }.title(this.title) //.titleMode(NavigationTitleMode.Full)

  }
}