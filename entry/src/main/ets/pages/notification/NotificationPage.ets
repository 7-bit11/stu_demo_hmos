import router from '@ohos.router';
import { notificationManager } from '@kit.NotificationKit';

@Entry
@Component
struct NotificationPage {
  @State title: string = "";
  params: object = router.getParams();

  aboutToAppear(): void {
    this.title = this.params['title'];
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

  build() {
    Navigation() {
      Column() {
        Button('文本通知栏').ButtonStyleMy()
          .onClick(() => {
            notificationManager.publish(this.requestText).then(() => {
              console.log("推送通知成功")
            }).catch(() => console.log("推送通知失败"))
          })
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