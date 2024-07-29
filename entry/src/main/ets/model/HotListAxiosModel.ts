import HotListEntity from '../entrys/hot_list_entity';
import axios from '@ohos/axios'

class HotListAxiosModel {
  private url: string = "https://www.kuaikanmanhua.com/v2/pweb/daily/topics";

  getHotListAsHttp(): Promise<HotListEntity> {
    return new Promise((ret, rej) => {
      axios.get(this.url, {
        params: {},
        data: {}
      }).then(rps => {
        if (rps.status === 200) {
          console.log("==============================================================")
          console.log(JSON.stringify(rps.data))
          ret(rps.data);
        } else {
          console.log("失败的请求++++++++++++++++++++++++++++", rps)
          rej("失败的请求")
        }
      }).then(error => {
        rej(`${error} 错误`)
        console.log("失败的请求==============================", error)
      })
    });
  }
}

const hotListAxiosModel = new HotListAxiosModel();

export default hotListAxiosModel as HotListAxiosModel;