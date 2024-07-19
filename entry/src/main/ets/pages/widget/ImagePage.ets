@Entry
@Component
struct ImagePage {
  build() {
    Column({ space: 10 }) {
      // net work image
      Image('https://konachan.net/sample/1dcfaece1e0738c40aec219403509b8e/Konachan.com%20-%20379176%20sample.jpg')//展位图
        .alt($rawfile("loading.gif"))//拓展方式
        .objectFit(ImageFit.Auto)
      // local media image
      Image($r("app.media.img"))

      //local rawfile image
      Image($rawfile("img.png"))
    }
  }
}