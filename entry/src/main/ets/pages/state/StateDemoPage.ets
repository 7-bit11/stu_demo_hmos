@Entry
@Component
struct StateDemoPage {
  @State num: number = 0;
  @State completeNum: number = 0;
  @State tasks: Array<MyTask> = []

  tasksChange() {
    this.num = this.tasks.length
    this.completeNum = this.tasks.filter(item => item.select).length
  }

  build() {
    Column({ space: 10 }) {
      Row() {
        Text("任务进度")
        Blank()
        Stack() {
          Progress({ value: this.completeNum, total: this.num, type: ProgressType.Ring })
          Text(`${this.completeNum}/${this.num}`)
        }
      }.Card()

      Button("新增任务").onClick(() => {
        this.tasks.push(new MyTask(`${this.num++}`))
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
                this.tasksChange();
              }
              )
            }.Card()
          }.swipeAction({ end: this.getDeleteButton(index) })
        })
      }.layoutWeight(1)
    }.padding(20)
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