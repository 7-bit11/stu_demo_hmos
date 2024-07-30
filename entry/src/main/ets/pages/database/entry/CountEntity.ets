import MyTask from './MyTask';

@Observed
export default class CountEntity {
  num: number;
  completeNum: number;
  task: Array<MyTask>;
  //嵌套的对象想要被监听的话需要加上Observed

  constructor(num?: number, completeNum?: number, task?: Array<MyTask>) {
    this.num = num ?? 0;
    this.completeNum = completeNum ?? 0
    this.task = task ?? []
  }
}
