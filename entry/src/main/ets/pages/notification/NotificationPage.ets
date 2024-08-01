import router from '@ohos.router';
import { notificationManager } from '@kit.NotificationKit';
import image from '@ohos.multimedia.image';

import fs from '@ohos.file.fs';
import { wantAgent } from '@kit.AbilityKit';

@Entry
@Component
struct NotificationPage {
  @State title: string = "";
  params: object = router.getParams();
  picture?: image.PixelMap = undefined;
  isSupport: boolean = false;
  template?: notificationManager.NotificationTemplate;
  @State progressValue: number = 0
  @State stateNotification: StateNotification = StateNotification.W
  timeId: number = -1;
  request?: notificationManager.NotificationRequest

  async aboutToAppear() {
    this.title = this.params['title'];
    //this.getPicture()
    //初始化时判断是否支持下载模板
    this.isSupport = await notificationManager.isSupportTemplate("downloadTemplate")


  }

  ///文本通知事件
  requestText: notificationManager.NotificationRequest = {

    id: 123,
    content: {
      notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
      normal: {
        title: "通知标题",
        text: "通知内容",
        additionalText: "附加内容"
      }
    }
  }
  ///长文本通知事件
  requestTextLong: notificationManager.NotificationRequest = {
    id: 456,
    content: {
      notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
      longText: {
        title: "长文本通知标题",
        text: "长文本通知内容",
        additionalText: "长文本附加内容",
        longText: "长文本中的数据.长文本中的数据.长文本中的数据.长文本中的数据.长文本中的数据.长文本中的数据.",
        briefText: "通知概要",
        expandedTitle: "长文本通知时候的标题"
      }
    }
  }
  ///多行文本通知
  requestTextLines: notificationManager.NotificationRequest = {
    id: 789,
    content: {
      notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
      multiLine: {
        title: "多行文本通知标题",
        text: "多行文本通知内容",
        additionalText: "多行文本通知附加内容",
        briefText: "通知概要多行文本通知",
        longTitle: "多行标题",
        lines: [
          '第一行第一行第一行第一行',
          '第二行第二行第二行第二行',
          '第三行第三行第三行第三行'
        ]
      }
    }
  }
  ///图片类型通知
  requestTextImage: notificationManager.NotificationRequest = {
    id: 9121,
    content: {
      notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_PICTURE,
      picture: {
        title: "图片类型通知标题",
        text: "图片类型通知内容",
        additionalText: "图片类型通知附加内容",
        briefText: "通知概要",
        expandedTitle: "展开标题",
        picture: this.picture!
      }
    }
  }

  async getPicture() {
    console.log("=====================21323112132123", JSON.stringify("12312312312"))
    const context = getContext(this).resourceManager;
    let file = await context.getMediaContent($r("app.media.img"))
    console.log("=====================file", JSON.stringify(file))
    let buffer = file.buffer
    console.log("=====================filebuffer", JSON.stringify(file.buffer.byteLength))
    image.createImageSource(file.buffer).createPixelMap()
      .then(value => {
        console.log("=====================value", JSON.stringify(value.getPixelBytesNumber()))
        this.picture = value
        console.log("=====================picture", JSON.stringify(this.picture))
      })
      .catch(() => console.log("获取失败"));

  }

  async click(request: notificationManager.NotificationRequest) {
    console.log("是否支持下载模板", this.isSupport)
    if (this.isSupport) {
      notificationManager.publish(request).then(() => {
        console.log("推送通知成功")
      }).catch(() => console.log("推送通知失败"))
    }

  }

  id1: number = 99;
  wantInfo?: wantAgent.WantAgentInfo = undefined

  //开始
  starPublish() {

    ///下载模板通知
    this.timeId = setInterval(() => {

      if (this.progressValue < 100) {
        this.progressValue += 2
      } else {
        clearInterval(this.timeId)
        this.timeId = -1;
        this.stateNotification = StateNotification.C

      }
      let want: wantAgent.WantAgentInfo = {
        requestCode: 1,
        actionType: wantAgent.OperationType.START_ABILITY,
        wants: [
          {
            bundleName: "com.bit.stu_demo",
            abilityName: "DocumentAbility",
            parameters: {
              instanceKey: "1"
            }
          }
        ]
      }
      wantAgent.getWantAgent(want).then(v => {
        this.wantInfo = v as wantAgent.WantAgentInfo;
        console.log("成功了")
      }).catch(() => {
        console.log("错误错误错")
      })
      this.template = {
        name: "downloadTemplate",
        data: {
          progressValue: this.progressValue,
          progressMaxValue: 100,
          fileName: "7bit.mp4",
          title: "7—bit下载文件模板:" + this.stateNotification
        }
      }
      this.request = this.progressValue < 100 ? {
        id: this.id1,
        template: this.template,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: "7_bit ：" + this.stateNotification,
            text: "777",
            additionalText: `${this.progressValue}%`
          }
        }
      } : {
        id: this.id1,
        template: this.template,
        wantAgent: this.wantInfo,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: "7_bit ：" + this.stateNotification,
            text: "777",
            additionalText: `${this.progressValue}%`
          }
        }
      }
      this.click(this.request!)
    }, 200)
    this.stateNotification = StateNotification.X
  }

  //重置
  reset() {
    this.stateNotification = StateNotification.W
    this.progressValue = 0;
  }

  build() {
    Navigation() {
      Column({ space: 20 }) {
        Button('文本通知栏').ButtonStyleMy()
          .onClick(() => {
            this.click(this.requestText)
          })
        Button('长文本通知栏').ButtonStyleMy()
          .onClick(() => {
            this.click(this.requestTextLong)
          })
        Button('多行通知栏').ButtonStyleMy()
          .onClick(() => {
            this.click(this.requestTextLines)
          })
        Row({ space: 10 }) {
          Text("下载状态：" + this.progressValue + "%" + this.stateNotification)
          Blank()
          if (this.stateNotification === StateNotification.W) {
            Button('开始').ButtonStyleMy()
              .onClick(() => this.starPublish())
          } else if (this.stateNotification === StateNotification.X) {
            Button('暂停').ButtonStyleMy()
              .onClick(() => {
                this.stateNotification = StateNotification.Z
                clearInterval(this.timeId)
              })

            Button('结束').ButtonStyleMy()
              .onClick(() => this.reset())
          } else if (this.stateNotification === StateNotification.Z) {
            Button('继续').ButtonStyleMy()
              .onClick(() => {
                this.starPublish()
              })
          } else {
            Button('完成').ButtonStyleMy()
              .onClick(() => this.reset())
          }
        }

      }
      .height('100%')
      .width('100%')
      .padding(20)
    }.title(this.title)
  }
}

@Extend(Button)
function ButtonStyleMy() {
  .width(80)
  .fontWeight(20)
}

enum StateNotification {
  W = "未开始",
  X = "下载中",
  Z = "暂停",
  C = "完成"
}
