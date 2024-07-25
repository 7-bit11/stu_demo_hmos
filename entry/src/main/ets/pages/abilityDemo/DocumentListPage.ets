import router from '@ohos.router';
import { FramePage } from '../ItemComponent';
import common from '@ohos.app.ability.common';
import Want from '@ohos.app.ability.Want';

@Entry
@Component
struct DocumentListPage {
  params: object = router.getParams();
  @State title: string = "";
  index: number = 1;
  @State docs: Array<number> = [];
  private context = getContext(this) as common.UIAbilityContext;

  aboutToAppear(): void {
    this.title = this.params['title'];
  }

  build() {
    Navigation() {
      Column() {
        Button('添加文档').onClick(() => {
          this.docs.push(this.index)
          let want: Want = {
            deviceId: "",
            bundleName: "com.bit.stu_demo",
            moduleName: "entry",
            abilityName: "DocumentAbility",
            parameters: {
              instanceKey: `ide_${this.index++}`
            }
          }
          this.context.startAbility(want)
        })
        List({ space: 10 }) {
          ForEach(this.docs, (id: number) => {
            ListItem() {
              Row() {
                Text(`文档：${id}`).ItemTextStyle()
                Blank()
              }.CardStyle()
            }.onClick(() => {
              let want: Want = {
                deviceId: "",
                bundleName: "com.bit.stu_demo",
                moduleName: "entry",
                abilityName: "DocumentAbility",
                parameters: {
                  instanceKey: `ide_${id}`
                }
              }
              this.context.startAbility(want)
            })
          })
        }.padding(20)
      }
    }.title(this.title) //.titleMode(NavigationTitleMode.Full)

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
