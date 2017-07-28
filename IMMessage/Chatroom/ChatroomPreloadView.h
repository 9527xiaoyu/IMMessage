//
//  ChatroomPreloadView.h
//  IMMessage
//
//  Created by 杨晓宇 on 2017/7/26.
//  Copyright © 2017年 com.ywart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "ChatroomModel.h"
#import "YWInputTextView.h"

#define thouColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kFontNormal(t,s) [UIFont fontWithName:t size:s]
#define themeImage(img) [UIImage imageNamed:img]

@class ChatroomPreloadView;
@protocol ChatroomPreloadViewDelegate <NSObject>

- (void)headerTheViewIsExpend:(BOOL)isexpend;
- (void)keyBoardIfNeedShow:(BOOL)show;

@end

@interface ChatroomPreloadView : UIView

@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, assign) BOOL showKeybraod; //是否显示键盘
@property (nonatomic, assign) BOOL isExpend; //是否展开
@property (nonatomic, weak) id<ChatroomPreloadViewDelegate> delegate;

@end

