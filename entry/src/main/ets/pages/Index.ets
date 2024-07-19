import { router } from '@kit.ArkUI';
import { PageEntry } from '../entryability/PageEntry';

@Entry
@Component
struct Index {
  pages: Array<PageEntry> = [
    new PageEntry("pages/widget/ImagePage", "ImageDemo")
  ];

  build() {

  }
}


