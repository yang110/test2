//
//  Common.h
//  HWWeiBo
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#ifndef HWWeiBo_Common_h
#define HWWeiBo_Common_h


#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


#define kwidth  self.view.bounds.size.width
#define kheight self.view.bounds.size.height

#define unread_count @"remind/unread_count.json"  //未读消息
#define home_timeline @"statuses/home_timeline.json"  //微博列表
#define comments  @"comments/show.json"   //评论列表
#define geo_to_address @"/2/location/geo/geo_to_address.json"

#define nearBy @"/2/place/nearby/pois.json"

#define nearby_timeline  @"/2/place/nearby_timeline.json" //附近动态


#define userWeibo @"/2/users/show.json"

//微博字体
#define FontSize_Weibo(isDetail) isDetail?16:15
#define FontSize_ReWeibo(isDetail) isDetail?15:14


#define kVersion     [[UIDevice currentDevice].systemVersion floatValue]

#endif
