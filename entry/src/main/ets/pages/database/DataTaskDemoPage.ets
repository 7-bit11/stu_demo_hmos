import router from '@ohos.router';
import BitDataBase from '../../database/BitDataBase';
import CountEntity from './entry/CountEntity';
import MyTask from './entry/MyTask';

@Entry
@Component
struct DataTaskDemoPage {
  @Provide count: CountEntity = new CountEntity();
  // @State tasks: Array<MyTask> = []
  @State title: string = "";
  params: object = router.getParams();

  tasksChange(id: number, boo: boolean) {
    console.log("消息队列更新中....", "id=", id)
    BitDataBase.updateTask(id, boo)
      .then(id => {
        console.log("消息队列成功!!!!", "id=", id)
        this.getTaskList(id)
      })
  }

  tasksDelete(id: number) {
    console.log("删除消息队列中....", "id=", id)
    BitDataBase.deleteTask(id)
      .then(id => {
        console.log("删除消息队列成功!!!!", "id=", id)
        this.getTaskList(id)
      })
  }

  addTask(name: string) {
    BitDataBase.addTask(name).then(value => {
      this.count.task.push(value)
      this.count.num = this.count.task.length
    })
  }

  getTaskList(id: number) {
    if (id >= 0) {
      console.log("更新成功后重新查询", "id=", id)
      BitDataBase.getTask().then(value => {
        this.count = value
        console.log("更新成功后重新查询成功!!!!", "id=", id, "value==", value)
      })
    }
  }

  //初始化
  async aboutToAppear(): Promise<void> {
    this.title = this.params['title'];
    console.log("初始化加载title==", this.title)
    this.count = await BitDataBase.getTask()
    console.log("初始化加载value", JSON.stringify(this.count))
  }

  build() {
    Navigation() {
      Column({ space: 10 }) {
        TitleCard()
        BodyWidget({
          count: this.count,
          onTasksChange: this.tasksChange.bind(this),
          onTasksAdd: this.addTask.bind(this),
          onTasksDelete: this.tasksDelete.bind(this)
        })
      }.padding(20)
    }
    .title(this.title)
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
  onTasksChange: Function = (id: number, boo: boolean) => {
  };
  onTasksAdd: Function = (name: string) => {
  };
  onTasksDelete: Function = (id: number) => {
  };
  build() {
    Column({ space: 10 }) {
      Button("新增任务").onClick(() => {
        this.onTasksAdd("任务")
      }).width("100%")

      List({ space: 10 }) {
        ForEach(this.count.task, (item: MyTask, index: number) => {
          ListItem() {
            Row() {
              Text(`任务 ${item.name} / ${item.id}`)
              Blank()
              Checkbox().select(item.select).onChange((value) => {
                item.select = value;
                this.onTasksChange(item.id, value)
              })
            }.Card()
          }.swipeAction({ end: this.getDeleteButton(item.id) })
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
      this.onTasksDelete(index)
    })
  }
}

