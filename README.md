# iOSSDKDemo

## 楔子
framework只暴露少许接口却能实现强大功能，简直把封装做到了极致。本文以Xcode8.3.3为工具，介绍怎么简洁有效的新鲜出炉一个热乎的framework。顺带给看官朋友们赠送了CPU架构和lipo操作静态包的点心，希望合乎大家口味。

## 知识点
大家都知道计算机CPU又称中央处理器，X86和ARM两种架构几乎是当今世界CPU类型的两大王者。
* #### X86 
>X86是英特尔Intel首先开发制造的一种微处理器体系结构的泛称，包括Intel8086、80186、80286、80386以及80486以86结尾系列，英特尔统治整个CPU产业链长达数十年，**是PC端当之无愧的王者。使用的是复杂指令集。**

* ####  ARM
>ARM（Advanced RISC Machines）公司是苹果、Acorn、VLSI、Technology等公司的合资企业。ARM采用将芯片的设计方案授权（licensing）给其他公司生产的模式，在世界范围结成了超过100个的合作伙伴（Partners），将封闭设计的Intel公司变成全民公敌。现在几乎所有的智能手机CPU 都是 采用 ARM架构，Apple的A系列处理器也是在ARM结构之上的。**ARM在便携式设备的地位也是无人能及。ARM用的是精简指令集。**

**欲知详情，且看这篇文章：[ARM与X86 CPU架构对比区别](http://blog.csdn.net/watermusicyes/article/details/50526863)**

------------------------------------------------
认真看看下面列表，认真看看下面列表，认真看看下面列表，回过头来再看。

|CPU架构|对应设备|
|----|----|
|**armv6**|**iPhone， iPhone2， iPhone 3G， 第一代、第二代iPod Touch**|
|**armv7**|**iPhone 3GS，iPhone 4，iPhone 4S，   iPad ，iPad 2，iPod Touch 3G，iPod Touch 4**|
|**armv7s**|**iPhone 5，iPhone 5c，    iPad4**|
|**arm64**|**iPhone 5S，iphone6，iphone6plus，iPhone6s，iPhone6s Plus，iPhone７，iPhone７ Plus， iPad Air**|
|**i386**|**Mac上跑32位模拟器**|
|**x86_64**|**Mac上跑64位模拟器**|
----------------------------------------------------

**terminal lipo命令**
有兴趣的同学可以戳这篇文章: [lipo命令](http://www.jianshu.com/p/e590f041c5f6)

|lipo|用途|
|---|---|
|** ` lipo -create [真机包路径] [模拟器包路径] -output [合并包输出路径] ` **|合并静态包|
|** ` lipo -thin [合并包路径] -output [拆分包路径] ` **|拆分静态包|
|** ` lipo -info [包路径] ` **| 查看包信息|
___________________________________________________________
## 干货
#### 1. 创建一个 iOS framework 项目
打开Xcode，选中** `iOS-->Cocoa Touch Framework` **
![创建framework](http://upload-images.jianshu.io/upload_images/2752872-0df417c7fadf1ae8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![SDK信息](http://upload-images.jianshu.io/upload_images/2752872-5d008741f13518d0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 2. 配置framework各项编译参数

######   2.1. 适配最低iOS SDK 版本

![PROJECT SDK](http://upload-images.jianshu.io/upload_images/2752872-59f15eab5c44ffe3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![TARGET SDK](http://upload-images.jianshu.io/upload_images/2752872-9f30bd7c54992699.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

######   2.2. Build Settings设置
1.添加armv7s 适配iPhone5、iPhone 5c
Xcode6后，默认不支持armv7s，需要选择是否支持armv7s 

![添加armv7s.png](http://upload-images.jianshu.io/upload_images/2752872-02bacc21d08eaf0a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

2.设置编译打包时支持所有版本

Build Active Architecture Only 设置为NO

![打包所有版本.png](http://upload-images.jianshu.io/upload_images/2752872-262a842c65751f15.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

3.链接设置
** `选择工程文件>target>Build Setting>linking`**

|项目|值|作用|
|------|-----|------|
|** `Mach-O Type` ** | ** `Static Library` **| framework可以是动态库也可以是静态库，系统的framework是动态库，用户制作的framework只能是静态库|
|** `Dead Code Stripping` **|** `NO`**|现在设置为YES似乎也行|
|** `Link With Standard Libraries` **|**`NO`**|避免重复链接|

![静态设置.png](http://upload-images.jianshu.io/upload_images/2752872-60b65f5fc3a0b10a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


4.添加 UIKit
>用到UIKit框架内容的需要将UIKit框架添加进去一起打包，否则framework建成之后相关部分会出现问题，此处特别需要注意

![添加UIKit.png](http://upload-images.jianshu.io/upload_images/2752872-a92c718e20ca0521.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

5.设置公开权限
设置公开和非公开的文件,也就是framework里headers文件夹下显露的文件
`TARGET-->Build Phases-->headers`

![设置暴露文件.png](http://upload-images.jianshu.io/upload_images/2752872-4ef61da7e71daf02.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

设置SDK公开的头文件，使用时只需引入`#import <MySDK/MySDK.h>`即可

![设置暴露头文件.png](http://upload-images.jianshu.io/upload_images/2752872-4747cbe888ba0c6f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 3. 编译生成framework
###### 3.1. 编译
command+B 选择Generic iOS Device或一部真机，Build在真机上跑的包

![编译真机对应的包](http://upload-images.jianshu.io/upload_images/2752872-c65db044514ee396.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

command+B 选择任一模拟器，Build在模拟器上跑的包

![编译模拟器对应的包](http://upload-images.jianshu.io/upload_images/2752872-1d43a1af55c4ce4a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### 3.2. 合并
在terminal用命令行合并两个包，使framework同时适用于真机和模拟器
先找到之前build的framework

![找到生成framework.png](http://upload-images.jianshu.io/upload_images/2752872-d06c6729d2cb12fb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

生成的真机包路径：`Debug-iphoneos-->MySDK.framework-->MySDK`
生成的模拟器包路径：`Debug-iphonesimulator-->MySDK.framework-->MySDK`

![找到生成的包.png](http://upload-images.jianshu.io/upload_images/2752872-709a4d4293d36bfc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

terminal 执行合并命令，指定目录生成合并包
** ` lipo -create [真机包路径] [模拟器包路径] -output [合并包输出路径] ` **
```
bogon:~ guoxiangyang$ lipo -create /Users/guoxiangyang/Library/Developer/Xcode/DerivedData/MySDK-dnpdqcirtujccudetmplklzdxttf/Build/Products/Debug-iphoneos/MySDK.framework/MySDK  /Users/guoxiangyang/Library/Developer/Xcode/DerivedData/MySDK-dnpdqcirtujccudetmplklzdxttf/Build/Products/Debug-iphonesimulator/MySDK.framework/MySDK  -output /Users/guoxiangyang/Desktop/Test/text/MySDK
```

terminal 执行命令，查看合并包的信息，支持 armv7 armv7s i386 x86_64 arm64，符合各真机及模拟器的要求
```
bogon:~ guoxiangyang$ lipo -info /Users/guoxiangyang/Desktop/Test/text/MySDK
Architectures in the fat file: /Users/guoxiangyang/Desktop/Test/text/MySDK are: armv7 armv7s i386 x86_64 arm64
```

###### 3.3. 组合framework

用输出的MySDK替换掉前面Debug-iphoneos中framework中的MySDK
将做好的framework直接拖入要使用的工程中

然后直接引入开放头文件即可
```
#import <MySDK/MySDK.h>

```

## 他山之石
本文特别感谢包括并不限于以下优秀文章：
[iOS开发：Framework的创建](http://blog.csdn.net/nine_yao/article/details/72845087)
[ios开发：Xcode8制作framework及使用](http://m.blog.csdn.net/dp948080952/article/details/52749120)