import router from '@ohos.router';

@Entry
@Component
struct ForEachPage {
  @State _fSize: number = 200;
  @State title: string = "";
  params: object = router.getParams();
  private items: Array<number> = [1, 2, 3, 4, 5, 6, 7, 8];

  aboutToAppear(): void {
    this.title = this.params['title'];
  }

  build() {
    Navigation() {
      List({ space: 10 }) {
        ForEach(this.items, (item: number, index: number) => {
          ListItem() {
            itemWidget(index.toString(), this._fSize);
          }
        })
      }.alignListItem(ListItemAlign.Center)
    }.title(this.title)
  }
}

@Builder
function itemWidget(_str: string, _fSize: number) {
  Row() {
    Image($r("app.media.img"))
      .autoResize(true)
      .width(_fSize)
      .height(_fSize)
      .borderRadius(10)
    Column() {
      Text(_str)
      Text("图片")
    }
  }.justifyContent(FlexAlign.SpaceAround)
  .width("100%")
}