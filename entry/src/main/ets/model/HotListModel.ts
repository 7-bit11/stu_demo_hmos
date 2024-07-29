import HotListEntity from '../entrys/hot_list_entity';
import http from '@ohos.net.http';

class HotListModel {
  private url: string = "https://www.kuaikanmanhua.com/v2/pweb/daily/topics";

  getHotListAsHttp(): Promise<HotListEntity> {
    return new Promise((res, rej) => {
      let httpRequest = http.createHttp();
      httpRequest.request(this.url, {
        method: http.RequestMethod.GET
      }).then(rps => {
        if (rps.responseCode === 200) {
          console.log("==============================================================")
          console.log(rps.result.toString())
          res(JSON.parse(rps.result.toString()));
        } else {
          console.log("失败的请求++++++++++++++++++++++++++++", rps)
          rej("失败的请求")
        }
      }).catch(error => {
        rej(`${error} 错误`)
        console.log("失败的请求==============================", error)
      });
    });
  }
}

const hotListModel = new HotListModel();

export default hotListModel as HotListModel;