import { relationalStore } from '@kit.ArkData';
import common from '@ohos.app.ability.common';
import CountEntity from '../pages/database/entry/CountEntity';
import MyTask from '../pages/database/entry/MyTask';

class BitDataBase {
  private store?: relationalStore.RdbStore = undefined;
  private tableName: string = "task"

  init(context: common.Context) {
    //配置数据库
    let config: relationalStore.StoreConfig = {
      name: "BitDataBase.db",
      securityLevel: relationalStore.SecurityLevel.S1
    };
    //sql创建表
    const sql = `create table if not exists ${this.tableName}(
      id integer primary key autoincrement,
      name text not null,
      selec bit
      )`;
    //获取
    relationalStore.getRdbStore(context, config, (error, store) => {
      //执行sql
      store.executeSql(sql)
      this.store = store;
      console.log("数据库成功初始化", "创建表task成功")
    });
  }

  async getTask(): Promise<CountEntity> {
    //构建查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    //开始查询数据
    let result = await this.store?.query(predicates, ["id", "name", "selec"])
    //判断是否是最后一行
    let countEntity = new CountEntity();
    let tasks: Array<MyTask> = [];
    console.log("getTask", "===================================", "最后一行吗", !result?.isAtLastRow)
    while (!result?.isAtLastRow) {
      result?.goToNextRow();
      countEntity.num++;
      let name = result?.getString(result?.getColumnIndex("name"));
      let id = result?.getLong(result?.getColumnIndex("id"));
      let select = result?.getLong(result?.getColumnIndex("selec"));
      let bool = !!select;
      if (bool) {
        countEntity.completeNum++
      }
      tasks.push(new MyTask(id, name, bool));
    }
    console.log("getTask", "查询到本地数据库中数据==", JSON.stringify(countEntity))
    countEntity.task = tasks;
    return countEntity;
  }

  async addTask(name: string): Promise<MyTask> {
    console.log("开始添加Task  name=", name)
    let value = await this.store?.insert(this.tableName, { name, selec: false })
    console.log("开始添加完成  value=", value)
    return new MyTask(value, name, false);
  }

  async updateTask(id: number, selec: boolean): Promise<number> {
    //构建查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    //修改条件id
    predicates.equalTo("id", id)

    return await this.store?.update({ selec }, predicates) ?? -1
  }

  async deleteTask(id: number): Promise<number> {
    //构建查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    //删除条件id
    predicates.equalTo("id", id)

    return this.store?.delete(predicates) ?? -1;
  }
}

const bitDataBase = new BitDataBase();

export default bitDataBase as BitDataBase;