//嵌套的对象想要被监听的话需要加上Observed
//@Observed
export default class MyTask {
  name?: string;
  select: boolean;
  id?: number

  constructor(id?: number, name?: string, select?: boolean) {
    this.name = name;
    this.select = select ?? false;
    this.id = id;
  }
}

