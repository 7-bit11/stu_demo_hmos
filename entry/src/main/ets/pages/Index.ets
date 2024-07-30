import { router } from '@kit.ArkUI';
import { PageEntry } from '../entrys/PageEntry';
import { FramePage } from './ItemComponent';

@Entry
@Component
struct Index {
  pages: Array<PageEntry> = [
    new PageEntry("pages/widget/FrameWidgetPage", "WidgetPage"),
    new PageEntry("pages/state/FrameStatePage", "StatePage"),
    new PageEntry("pages/animate/FrameAnimatePage", "AnimatePage"),
    new PageEntry("pages/abilityDemo/DocumentListPage", "AbilityDocumentPage"),
    new PageEntry("pages/network/FrameNetWorkPage", "NetWorkPage"),
    new PageEntry("pages/preferences/PreferencesPage", "PreferencesPageDemo"),
    new PageEntry("pages/database/DataTaskDemoPage", "DataTaskDemoPage"),
  ];
  index: number = 1;

  build() {
    Navigation() {
      List({ space: 10 }) {
        ForEach(this.pages, (item: PageEntry) => {
          ListItem() {
            FramePage({ page: item, index: this.index++ })
          }
        })
      }.padding(20)
    }.title("bitDemo")
    .titleMode(NavigationTitleMode.Full)
  }
}

