import { PageEntry } from '../../entryability/PageEntry';
import router from '@ohos.router';
import { FramePage } from '../ItemComponent';

@Entry
@Component
struct FrameAnimatePage {
  params: object = router.getParams();
  @State title: string = "";
  index: number = 1;

  aboutToAppear(): void {
    this.title = this.params['title'];
  }

  pages: Array<PageEntry> = [
    new PageEntry("pages/animate/AnimatePage", "AnimateDemo"),
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