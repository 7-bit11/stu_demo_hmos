import preferences from '@ohos.data.preferences';

class PreferencesUtil {
  pref: Map<string, preferences.Preferences> = new Map()
  private defaultName: string = "DefaultName";

  async init(context, name?: string) {
    try {
      // 加载初始化Preferences
      let data = await preferences.getPreferences(context, name?? this.defaultName)
      this.pref.set(name ?? this.defaultName, data)
      console.log("PreferencesUtil.init.SUCCESS")
    } catch (e) {
      console.log("PreferencesUtil.init.ERROR", e)
    }
  }
  async init1(context, name?: string) {
    try {
      // 加载初始化Preferences
      let data = await preferences.getPreferences(context, name?? this.defaultName)
      this.pref.set(name ?? this.defaultName, data)
      console.log("PreferencesUtil.init.SUCCESS")
    } catch (e) {
      console.log("PreferencesUtil.init.ERROR", e)
    }
  }

  async getValue(key: string, defValue: preferences.ValueType, name?: string) {
    if (!this.pref.has(name ?? this.defaultName)) {
      console.log("PreferencesUtil.getValue.IsNotKey", "没有找到初始化的Preferences")
      return
    }
    try {
      let data = this.pref.get(name ?? this.defaultName);
      let preValue = await data.get(key, defValue)
      console.log("PreferencesUtil.getValue.SUCCESS", `成功获取${key}=${preValue}]`)
      return preValue;
    } catch (e) {
      console.log("PreferencesUtil.getValue.ERROR", e)
    }
  }

  async putValue(key: string, value: preferences.ValueType, name?: string) {
    if (!this.pref.has(name ?? this.defaultName)) {
      console.log("PreferencesUtil.getValue.IsNotKey", "没有找到初始化的Preferences")
      return
    }
    try {
      let data = this.pref.get(name ?? this.defaultName);
      await data.put(key, value)
      await data?.flush();
      console.log("PreferencesUtil.putValue.SUCCESS", `成功写入${key}-${value}=[${value}]`)
    } catch (e) {
      console.log("PreferencesUtil.getValue.ERROR", e)
    }
  }
}

const preferencesUtil = new PreferencesUtil();

export default preferencesUtil as PreferencesUtil;