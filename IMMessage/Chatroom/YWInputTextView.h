//
//  YWInputTextView.h
//  IMMessage
//
//  Created by 杨晓宇 on 2017/7/28.
//  Copyright © 2017年 com.ywart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "ChatroomModel.h"

#define thouColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kFontNormal(t,s) [UIFont fontWithName:t size:s]
#define themeImage(img) [UIImage imageNamed:img]

@protocol YWInputTextViewDelegate <NSObject>

- (void)textFieldInputDetail:(NSArray *)array;

@end

@interface YWInputTextView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *emojiBtn;
@property (nonatomic, strong) UITextField *inputText;
@property (nonatomic, strong) UIButton *sendBtn;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, weak) id<YWInputTextViewDelegate> delegate;

- (void)manualShowKeyBoard;
- (void)manualDismissKeyBoard;

@end
