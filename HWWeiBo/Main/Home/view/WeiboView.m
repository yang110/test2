//
//  WeiboView.m
//  HWWeiBo
//
//  Created by Mac on 15/8/24.
//  Copyright (c) 2015年 杨梦佳. All rights reserved.
//

#import "WeiboView.h"
#import "UIImageView+WebCache.h"
#import "ThemeManager.h"
@implementation WeiboView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame  ];
    if (self)
    {
        [self createSubViews];

    }
    return self;
    
}


-(void)createSubViews
{
    
    _textLabel=[[WXLabel alloc]initWithFrame:CGRectZero];
    _textLabel.linespace=5;
    _textLabel.font=[UIFont systemFontOfSize:15];
    _textLabel.wxLabelDelegate=self;
    [self addSubview:_textLabel];
    
    
    _sourceLabel=[[WXLabel alloc]initWithFrame:CGRectZero];
    _sourceLabel.linespace=5;
    _sourceLabel.font=[UIFont systemFontOfSize:14];
    _sourceLabel.wxLabelDelegate=self;
    [self addSubview:_sourceLabel];
    
    
    
    
    _imageView=[[ZoomImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:_imageView];
    
    
    _bgImageView=[[ThemeImageView alloc]initWithFrame:CGRectZero];
    _bgImageView.leftCapWidth=25;
    _bgImageView.topCapWidth=25;
    _bgImageView.imgName=@"timeline_rt_border_9.png";
      [self insertSubview:_bgImageView atIndex:0  ];

    
    
    //监听
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(themeChangeAction:) name:kThemeDidChangeNotification object:nil];
    
    
    //开始调用下
    [self themeChangeAction:nil];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter ]removeObserver:self name:kThemeDidChangeNotification object:nil];
    
}


-(void)themeChangeAction:(NSNotification *)not
{
    _textLabel.textColor=[[ThemeManager shareInstance]getThemeColor:@"Timeline_Content_color"];
    
    _sourceLabel.textColor=[[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    
    
}



-(void)setLayouFrame:(WeiboViewLayoutFrame *)layouFrame
{
    
    if (_layouFrame!=layouFrame) {
        _layouFrame=layouFrame  ;
        [self setNeedsLayout];
        
    }
    
    
    
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    WeiboModel *weiboModel=self.layouFrame.weiboModel;
    
    
    

    
    _textLabel.frame=self.layouFrame.textFrame;
    _textLabel.text=weiboModel.text;

    
    
    
    if (weiboModel.reWeiboModel!=nil)
    {
        //转发的
        self.bgImageView.hidden=NO;
        self.sourceLabel.hidden=NO;
        
        self.sourceLabel.text=weiboModel.reWeiboModel.text;
        self.sourceLabel.frame=self.layouFrame.sourceTextFrame;
        
        
        self.bgImageView.frame=self.layouFrame.bgImageFrame;
        
        
        NSString *imgurl=weiboModel.reWeiboModel.thumbnailImage ;
        if (imgurl!=nil)
        {
            self.imageView.hidden=NO;
            self.imageView.frame=self.layouFrame.imgFrame;
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgurl]];
            
            
            //121212
            self.imageView.fullImageUrlString=weiboModel.reWeiboModel.originalImage;
            
            

            
        
        }
        else
        {
            
            self.imageView.hidden=YES;

            
            
        }
        
        
    }
    else
    {
        //不实转发的
        self.bgImageView.hidden=YES;
        self.sourceLabel.hidden=YES;
        
        
        NSString *imgurl=weiboModel.thumbnailImage;
        
        
        //121212
        self.imageView.fullImageUrlString=weiboModel.originalImage;
        

        
        // 是否有图片
        if (imgurl==nil)
        {
            self.imageView.hidden=YES;
            
                    
            
        }
        else
        {
            self.imageView.hidden=NO;
            
            self.imageView.frame=self.layouFrame.imgFrame;
            
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgurl]];
            
        
            
        }

        
    }
    
// 判断图片是否是GIF
    if (self.imageView.hidden == NO) {
        
        UIImageView *iconView = self.imageView.iconImageView;
        
        iconView.frame = CGRectMake(_imageView.width-24, _imageView.height-15, 24, 15);
       
        
        NSString *extension = [weiboModel.reWeiboModel.thumbnailImage pathExtension];
        if ([extension isEqualToString:@"gif"]) {
            iconView.hidden = NO;
            self.imageView.isGif = YES;
            
        } else {
            iconView.hidden = YES;
            self.imageView.isGif = NO;
            
        }
        
 
        
    }

    
    
}



#pragma  mark - WXLabel delegate
//手指离开当前超链接文本响应的协议方法
- (void)toucheEndWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context
{
    NSLog(@"%@",context);
    
}

- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel
{
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString *regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}

//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel
{
    
    
    return [[ThemeManager shareInstance] getThemeColor:@"Link_color"];
    
    
    
    
}


//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel
{
    return [UIColor blueColor];
}

@end
