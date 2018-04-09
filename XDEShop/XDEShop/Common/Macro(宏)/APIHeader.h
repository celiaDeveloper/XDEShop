//
//  APIMacros.h
//  ZHDJ
//
//  Created by Celia on 2017/9/6.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#ifndef APIMacros_h
#define APIMacros_h

#define keychainsServiceName @"com.zhijianshangcheng.cn"//keychains所属的服务

#define RN @"http://zhijianshangcheng.dep.hopex.cn/"  //测试站

#define Ad_RN RN@"data/afficheimg/"//广告拼接域名


#pragma mark - app调用接口

#define goods_cate      RN@"json/api_goods_cate.php?"   //获取商品分类

#define ads_list        RN@"json/api_ads_list.php?"     //获取广告位列表

#define ads_info        RN@"json/api_ads_info.php?"     //获取广告列表信息

#define goods_gallery   RN@"json/api_goods_gallery.php?"//获取单个商品的相册


#endif /* APIMacros_h */
