//
//  ChatroomTableView.h
//  IMMessage
//
//  Created by 杨晓宇 on 2017/7/26.
//  Copyright © 2017年 com.ywart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatroomPreloadView.h"
#import "YWInputTextView.h"

@protocol ChatroomDelegate <NSObject>

- (void)chatroomHide;
- (void)touchHeaderView:(BOOL)tap;

@end

@interface ChatroomCollectionView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ChatroomPreloadViewDelegate,YWInputTextViewDelegate>

@property (nonatomic, strong) UICollectionView *chatDetail;
@property (nonatomic, strong) ChatroomPreloadView *header;
@property (nonatomic, strong) YWInputTextView *textInputView;

@property (nonatomic, assign) CGRect rect;

@property (nonatomic, weak) id<ChatroomDelegate> chatDelegate;

@end
