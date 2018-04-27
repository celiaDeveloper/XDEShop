# XDEShop
商城项目框架，逐步添加商城各部分功能。
各个大功能模块都放在单独文件夹中，方便研究和集成。

### 商品属性选择模块：
当购买商品的时候，可能需要选择商品的颜色、大小等属性，所以商品的属性选择是商城类项目必不可少的部分。

属性选择模块是模态出来的，大概分为4个部分。数据是来自本地的plist文件。
* 最上面有一部分空白，点击空白出可以退出当前视图。
* 接着是展示商品的图片、价格、库存和用户选择的商品属性等信息，用tableview搭建的。
* 然后是商品的属性列表，选择以后可实时更新上面已选属性信息，用collectionview搭建。
* 商品数量选择器，和确定按钮放在低端。

![attributes module](https://github.com/celiaDeveloper/XDEShop/blob/master/Screenshots/attributes.png)

***
### 搜索模块：
搜索框是由UITextField和几个Button构成，可选择搜索商品或者店铺，目前未加模糊搜索。
搜索记录和热门搜索是用collectionview搭建。
* 搜索记录：本地数据库存储搜索记录，根据搜索情况显示最近10条搜索记录，可清空搜索记录。
* 热门搜索数据可从后台获取，然后显示。目前项目中是固定的几个数据，并未调用接口。

说明：
XDAutoresizeLabelFlow有一个根据文字来布局cell的collectionView，由数据数组可以实现分组，例如数据数组@[@[@"韩版女装",@"书架"],@[@"运动鞋",@"耳机"]] 就是两个分组，每个分组有自己的头视图。

![search module](https://github.com/celiaDeveloper/XDEShop/blob/master/Screenshots/search.png)



项目参考：MSSAutoresizeLabelFlow
            　　CDDMall
