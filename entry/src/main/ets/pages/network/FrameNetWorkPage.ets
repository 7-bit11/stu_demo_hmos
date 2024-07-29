import router from '@ohos.router';
import { PageEntry } from '../../entrys/PageEntry';
import { FramePage } from '../ItemComponent';

@Entry
@Component
struct FrameNetWorkPage {
  params: object = router.getParams();
  @State title: string = "";
  index: number = 1;

  aboutToAppear(): void {
    this.title = this.params['title'];
  }

  pages: Array<PageEntry> = [
    new PageEntry("pages/network/HttpPage", "HttpDemo"),
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