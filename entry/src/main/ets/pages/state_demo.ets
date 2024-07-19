@Entry
@Component
struct StateDemo {
  @State data: People = new People("?", 0, []);

  build() {
    Column() {
      Row() {
        Text("任务完成度")
        Blank()
        Stack() {
          Progress({ value: this.data.ok, total: this.data.task.length, type: ProgressType.Ring })
          Text(this.data.ok.toString() + "/" + this.data.task.length.toString())
        }
      }.cardStyle()

      Button('新增任务').onClick(() => {
        //this.data.ok++
        this.data.task.push(new Task())
      })
      List() {
        ForEach(this.data.task, (item: Task) => {
          ListItem() {
            SaveButton()
          }
        })
      }
    }.padding(20)
    // .justifyContent(FlexAlign.Center)
    .height('100%')
    .width('100%')
  }
}


@Styles
function cardStyle() {
  .width("100%")
  .padding(20)
  .margin(10)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({
    radius: 5,
    color: '#1F000000',
    offsetX: 2,
    offsetY: 4
  })
}
@Observed
class Task {
  static id: number = 0
  name: string = "任务" + Task.id
  finished: boolean = false
}
@Observed
class People {
  name: string;
  ok: number;
  task: Array<Task>;

  constructor(name: string, ok: number, task: Array<Task>) {
    this.name = name;
    this.ok = ok;
    this.task = task
  }
}