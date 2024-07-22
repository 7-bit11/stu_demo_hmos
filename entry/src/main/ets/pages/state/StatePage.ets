import router from '@ohos.router';

@Entry
@Component
struct StatePage {
  //@State不能进行数据的传递
  //调用其他组件时传值过去无法触发更新
  @State _size: number = 0;
  @State title: string = "";
  @State obj: object = new Object(1);
  @State bool: boolean = false;
  @State stateEnum: StateEnum = StateEnum.up;
  @State stateEnum1: StateEnum1 = StateEnum1.up
  //如果使用@State修饰改实体对象的话
  //只能监听到当前子属性的修改
  //不能监听到子属性也是class中的属性
  //当前案例中Pet中的属性修改
  @State stateEntity: StateEntity = new StateEntity("7-bit", 20, new Pet("Cat"))
  params: object = router.getParams();

  aboutToAppear(): void {
    this.title = this.params['title'];

  }

  build() {
    Navigation() {
      Column({ space: 10 }) {
        Row() {
          Text("this._size").textStyle()
          Text(`${this._size}`).textStyle()
        }.justifyContent(FlexAlign.SpaceBetween)
        .width("100%")

        Row() {
          Text("this.checkAndReturn").textStyle()
          Text(`${checkAndReturn(this.obj)}`).textStyle()
        }.justifyContent(FlexAlign.SpaceBetween)
        .width("100%")


        Row() {
          Text("this.bool").textStyle()
          Text(`${this.bool}`).textStyle()
        }.justifyContent(FlexAlign.SpaceBetween)
        .width("100%")

        Row() {
          Text("this.stateEnum").textStyle()
          Text(`${this.stateEnum}`).textStyle()
        }.justifyContent(FlexAlign.SpaceBetween)
        .width("100%")

        Row() {
          Text("this.stateEnum1").textStyle()
          Text(`${this.stateEnum1}`).textStyle()
        }.justifyContent(FlexAlign.SpaceBetween)
        .width("100%")

        Row() {
          Text("this.stateEntity").textStyle()
          Text(`${this.stateEntity.name}`).textStyle()
        }.justifyContent(FlexAlign.SpaceBetween)
        .width("100%")

        Row() {
          Text("this.stateEntity").textStyle()
          Text(`${this.stateEntity.age}`).textStyle()
        }.justifyContent(FlexAlign.SpaceBetween)
        .width("100%")

        Row() {
          Text("this.stateEntity").textStyle()
          Text(`${this.stateEntity.pet.type}`).textStyle()
        }.justifyContent(FlexAlign.SpaceBetween)
        .width("100%")


        Blank()
        Button("点击覆盖数据").width("100%")
          .onClick(() => {
            this._size = 20
            this.obj = new Object(20)
            this.bool = true;
            this.stateEnum = StateEnum.down
            this.stateEnum1 = StateEnum1.down
            this.stateEntity.name = "bit-7"
            this.stateEntity.age = 22
            this.stateEntity.pet.type = "Dog"
          })
        Button("点击覆盖数据Pet").width("100%")
          .onClick(() => {
            this.stateEntity.pet = new Pet("MM")
            this._size++
          })
      }.padding(20)
      .height("100%")
    }.title(this.title)
  }

  @Builder
  item(title: string, value: string) {
    Row() {
      Text(title).textStyle()
      Text(value).textStyle()
    }.justifyContent(FlexAlign.SpaceBetween)
    .width("100%")
  }
}

//使用function
@Builder
function item(title: string, value: string) {
  Row() {
    Text(title).textStyle()
    Text(value).textStyle()
  }.justifyContent(FlexAlign.SpaceBetween)
  .width("100%")
}


@Extend(Text)
function textStyle() {
  .fontSize(18)
  .fontWeight(FontWeight.Bold)
}

enum StateEnum {
  up = 1,
  down = 2,
  left = 3,
  right = 4
}

enum StateEnum1 {
  up,
  down,
  left,
  right
}

//如果使用@State修饰改实体对象的话
//只能监听到当前子属性的修改
//不能监听到子属性也是class中的属性
//当前案例中Pet中的属性修改
class StateEntity {
  name: string;
  age: number;
  pet: Pet;

  constructor(name: string, age: number, pet: Pet) {
    this.name = name;
    this.age = age;
    this.pet = pet
  }
}

class Pet {
  type: string;

  constructor(type: string) {
    this.type = type
  }
}

function checkAndReturn(obj: object): string | number {
  if (typeof obj === "string") {
    return "The object is a string: " + obj;
  } else {
    return typeof obj === "number" ? obj : 99;
  }
}