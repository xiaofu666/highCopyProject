![image](https://github.com/Wzxhaha/WWeChat/raw/master/WWeChat.png)
# WWeChat
[![License](https://img.shields.io/packagist/l/doctrine/orm.svg)](https://github.com/Wzxhaha/WWeChat/blob/master/LICENSE)
[github地址](https://github.com/Wzxhaha/WWeChat)
- 2016.1.28开始，仿做一个微信，将持续更新直至完成.
- 另外请别在这个项目里面通过改头像来打广告!谢谢!
- 更新的同时将在简书上讲解,[简书:WzxJiang](http://www.jianshu.com/users/389c20d5a244).
- 如果你喜欢，欢迎Star、Fork!
- **如果在模拟器上进入聊天页面发现聊天栏位置不对..那就是你没开键盘..**
- **注册功能页面太多还没加，先直接用测试帐号来体验吧**

##测试帐号
 * 测试帐号1: 手机号:11111111111 密码:123456
 * 测试帐号2: 手机号:00000000000 密码:123456

##目录
- [更新日志](#更新日志)
- [GIF](#GIF)
  - [UI部分](#UI部分)
  - [更改资料部分](#更改资料部分)
  - [登陆注册部分](#登陆注册部分)
  - [IM部分](#IM部分)
- [Bug反馈](#Bug反馈)
- [联系我](#联系我) 


##<a id="更新日志"></a>更新日志
 * 2016.1.28 完成基本框架
 * 2016.1.29 搭建三个界面的UI
 * 2016.1.31 完成全部主界面UI
 * 2016.2.02 导入`LeanCloud`动态库做服务器，完成登录注册接口
 * 2016.2.04 完成部分朋友圈，以及修复一点小问题
 * 2016.2.05 完成更改头像功能，以及写好了其他资料更新的方法
 * 2016.2.15 完成更改昵称，更改性别功能，以及更新更改头像功能(微信竟然更新了..)
 * 2016.2.17 完成加好友页面UI，以及优化了一下各个页面的`UISearchViewContrller`
 * 2016.2.24 加入部分IM
 * 2016.3.02 补上登录注册页面(手机注册还没写)，明天可能会把融云集成进去，不用LeanCloud的IM了
 * 2016.3.03 加入部分IM以及修改部分框架，目前能接受到信息，但是还有部分细节问题.
 * 2016.3.04 加入发送信息功能，可以用两个帐号测试，具体聊天记录要自己创表本地化
 * 2016.3.06 修复BUG:消息为空时菊花一直转以及无法点击tabbar的问题
 * 2016.3.07 文字内容能随意发送了，加入历史纪录.
 * 2016.3.08 优化聊天键盘弹入弹出的滑动效果，增加了退出登录功能.
 * 2016.3.10 再次优化聊天键盘弹入弹出的滑动效果
 * 2016.3.15 在服务器新建了一个Class:Friend，好友功能开始逐步实现。
 * 2016.3.17 在登陆模块加入弹框自适应（暂时先用AutoLayout的隐式动画），优化朋友圈UI，明天考虑加入完整朋友圈功能。
 * 2016.3.23 修复好友列表属于#组的不显示，优化头像缓存。

 

##<a id="GIF"></a>GIF

###<a id="IM部分"></a>IM部分
![image](https://github.com/Wzxhaha/WWeChat/raw/master/wechat0304.gif)
<div>
</div>
![image](https://github.com/Wzxhaha/WWeChat/raw/master/wechat0307.gif)
###<a id="登陆注册部分"></a>登陆注册部分
![image](https://github.com/Wzxhaha/WWeChat/raw/master/wechat0302.gif)
###<a id="更改资料部分"></a>更改资料部分
 ![image](https://github.com/Wzxhaha/WWeChat/raw/master/wechat0215.gif)
###<a id="UI部分"></a>UI部分
 ![image](https://github.com/Wzxhaha/WWeChat/raw/master/wechat0131.gif)

##<a id="Bug反馈"></a>Bug反馈
[Bug反馈](https://github.com/Wzxhaha/WWeChat/issues/new)

##<a id="联系我"></a>联系我
如果你有建议欢迎发邮件至email: wzxjiang@foxmail.com
