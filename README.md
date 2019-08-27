# UserGuideView
一个简单的新特性，新手引导的组件，优点是非常简单、灵活。

组件的命名没有写前缀的用意在于，你把 UserGuideView 引入到自己的工程中，在此基础上修改模拟的按钮样式，遮罩颜色等。

## 结构
整个组件很简单，通过分离 DataSource 和 delegate，可以处理各种需求的新手引导。
单步多步等。

但对于新手引导页面的基本结构有个约定；
1. 全屏
2. 从上到下，依次是中空的圈 -> 文字描述和图片  -> 按钮区域

## 效果图
![视觉稿](https://github.com/hite/UserGuideView/blob/master/UserGuideView/5cfbcee79d7b4ca5838d8d8d434ebe2f_d90ed6a563f114092d11917bb6f948fd.jpg)

## demo
demo 工程实际展示了如何引入，更多设置见源码注释。
