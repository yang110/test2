//
//  SendViewController.h
//  HWWeibo
//
//  Created by gj on 15/8/30.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "BaseViewController.h"
#import "ZoomImageView.h"
#import "FaceScrollView.h"
#import <CoreLocation/CoreLocation.h>
@interface SendViewController : BaseViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
    //1 文本编辑栏
    UITextView *_textView;
    
    
    //2 工具栏
    UIView *_editorBar;
    
    
    ZoomImageView *_zoomImageView;
    
    //4
    CLLocationManager *_locationManager;
    //5 表情面板
    
    FaceScrollView *_faceViewPanel;
}

@end
