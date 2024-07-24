import router from '@ohos.router';

@Entry
@Component
struct ObjectLinkObservedPage {
  @Provide count: CountEntity = new CountEntity();
  // @State tasks: Array<MyTask> = []
  @State title: string = "";
  params: object = router.getParams();

  tasksChange(boo: boolean) {
    this.count.num = this.count.task.length
    this.count.completeNum = this.count.task.filter(item => item.select).length
    console.log("****************************************")
    console.log(`${boo}`)
    console.log("****************************************")
  }

  aboutToAppear(): void {
    this.title = this.params['title'];

  }

  build() {
    Navigation() {
      Column({ space: 10 }) {
        TitleCard()
        BodyWidget({ count: this.count, onTasksChange: this.tasksChange.bind(this) })
      }.padding(20)
    }
    .title(this.title)
  }
}

//嵌套的对象想要被监听的话需要加上Observed
//@Observed
class MyTask {
  name?: string;
  select: boolean;

  constructor(name?: string, select?: boolean) {
    this.name = name;
    this.select = select ?? false;
  }
}

//嵌套的对象想要被监听的话需要加上Observed
@Observed
class CountEntity {
  num: number;
  completeNum: number;
  task: Array<MyTask>;

  constructor(num?: number, completeNum?: number, task?: Array<MyTask>) {
    this.num = num ?? 0;
    this.completeNum = completeNum ?? 0
    this.task = task ?? []
  }
}

@Styles
function Card() {
  .backgroundColor("#fafafa")
  .borderRadius(10)
  .width("100%")
  .padding({
    left: 20,
    right: 20,
    top: 10,
    bottom: 10
  })
  //.shadow({ radius: 1, offsetX: 2, offsetY: 2 })
}

@Component
struct TitleCard {
  @Consume count: CountEntity

  build() {
    Row() {
      Text("任务进度")
      Blank()
      Stack() {
        Progress({ value: this.count.completeNum, total: this.count.num, type: ProgressType.Ring })
        Text(`${this.count.completeNum}/${this.count.num}`)
      }
    }.Card()
  }
}

@Component
struct BodyWidget {
  @ObjectLink count: CountEntity

  onTasksChange: Function = (boo: boolean) => {};

  // Function = () => {}
  build() {
    Column() {
      Button("新增任务").onClick(() => {
        this.count.task.push(new MyTask(`${this.count.num++}`))
        this.onTasksChange()
      }).width("100%")

      List({ space: 10 }) {
        ForEach(this.count.task, (item: MyTask, index: number) => {
          ListItem() {
            Row() {
              Text(`任务 ${item.name}`)
              Blank()
              Checkbox().select(item.select).onChange((value) => {
                item.select = value;
                this.onTasksChange(value)
              }
              )
            }.Card()
          }.swipeAction({ end: this.getDeleteButton(index) })
        })
      }.layoutWeight(1)
    }.layoutWeight(1)
  }

  @Builder
  getDeleteButton(index: number) {
    Button({ type: ButtonType.Circle }) {
      Image($r("app.media.img")).borderRadius(20)
    }.width(30).height(30)
    .onClick(() => {
      this.count.task.splice(index, 1);
      this.onTasksChange()
    })
  }
}

