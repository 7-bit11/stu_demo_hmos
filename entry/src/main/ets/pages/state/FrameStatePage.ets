import { PageEntry } from '../../entrys/PageEntry';
import router from '@ohos.router';
import { FramePage } from '../ItemComponent';

@Entry
@Component
struct FrameStatePage {
  params: object = router.getParams();
  @State title: string = "";
  index: number = 1;

  aboutToAppear(): void {
    this.title = this.params['title'];
  }

  pages: Array<PageEntry> = [
    new PageEntry("pages/state/StatePage", "StateDemo"),
    new PageEntry("pages/state/StateDemoPage", "StateDemoPageDemo"),
    new PageEntry("pages/state/PropLinkPage", "PropLinkPageDemo"),
    new PageEntry("pages/state/ProvideConsumePage", "ProvideConsumePageDemo"),
    new PageEntry("pages/state/ObjectLinkObservedPage", "ObjectLinkObservedPageDemo")
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