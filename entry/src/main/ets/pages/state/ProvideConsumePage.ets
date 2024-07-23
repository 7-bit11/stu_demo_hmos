import router from '@ohos.router';

@Entry
@Component
struct ProvideConsumePage {
  @Provide count: CountEntity = new CountEntity();
  @State tasks: Array<MyTask> = []
  @State title: string = "";
  params: object = router.getParams();

  aboutToAppear(): void {
    this.title = this.params['title'];

  }

  build() {
    Navigation() {
      Column({ space: 10 }) {
        TitleCard()
        BodyWidget({ tasks: $tasks })
      }.padding(20)
    }
    .title(this.title)
  }
}


class MyTask {
  name?: string;
  select: boolean;

  constructor(name?: string, select?: boolean) {
    this.name = name;
    this.select = select ?? false;
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
  @Link tasks: Array<MyTask>
  @Consume count: CountEntity

  tasksChange() {
    this.count.num = this.tasks.length
    this.count.completeNum = this.tasks.filter(item => item.select).length
  }

  build() {
    Column() {
      Button("新增任务").onClick(() => {
        this.tasks.push(new MyTask(`${this.count.num++}`))
        this.tasksChange()
      }).width("100%")

      List({ space: 10 }) {
        ForEach(this.tasks, (item: MyTask, index: number) => {
          ListItem() {
            Row() {
              Text(`任务 ${item.name}`)
              Blank()
              Checkbox().select(item.select).onChange((value) => {
                item.select = value;
                this.tasksChange()
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
      this.tasks.splice(index, 1);
      this.tasksChange()
    })
  }
}

class CountEntity {
  num: number;
  completeNum: number;

  constructor(num?: number, completeNum?: number) {
    this.num = num ?? 0;
    this.completeNum = completeNum ?? 0
  }
}