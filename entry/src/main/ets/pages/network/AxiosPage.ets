import HotListEntity, { Topic } from '../../entrys/hot_list_entity';
import HotListAxiosModel from '../../model/HotListAxiosModel';
import { promptAction, router } from '@kit.ArkUI';
import { it } from '@ohos/hypium';

@Entry
@Component
struct HttpPage {
  @State hotListEntry: HotListEntity = new HotListEntity();
  @State title: string = "";
  params: object = router.getParams();

  aboutToAppear(): void {
    this.title = this.params['title'];
    HotListAxiosModel.getHotListAsHttp().then(rps => {
      this.hotListEntry = rps;
    }).catch(() => {
      promptAction.showToast({
        message: "暂无内容", duration: 2000
      })
    })
  }

  build() {
    Navigation() {
      Column() {
        Grid() {
          ForEach(this.hotListEntry.data?.topics, (item: Topic, index: number) => {
            GridItem() {
              this.getGridItem(item)
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(10)
        .rowsGap(10)
        .scrollBar(BarState.Off)
      }.height('100%')
      .width('100%')
      .padding(20)
    }.title(this.title)
  }

  @Builder
  getGridItem(item: Topic) {
    Column() {
      Image(item.vertical_image_url)
        .height(250)//.borderRadius(borderRadiuses(10))
        .alt($rawfile('loading.gif'))
        .width("100%")
        .objectFit(ImageFit.Fill)
        .border({
          radius: {
            topLeft: 6,
            topRight: 6
          }
        })
      Text(item.title).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis }).padding(5)
      Text(item.tags?.join("|")).maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis }).padding(5)
    }
    .borderRadius(6)
  }
}