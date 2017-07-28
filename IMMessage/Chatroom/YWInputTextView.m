//
//  YWInputTextView.m
//  IMMessage
//
//  Created by 杨晓宇 on 2017/7/28.
//  Copyright © 2017年 com.ywart. All rights reserved.
//

#import "YWInputTextView.h"
#import "STEmojiKeyboard.h"

@interface YWInputTextView()
@property (nonatomic, strong) NSMutableArray *muArray;
@property (nonatomic, strong) STEmojiKeyboard *emojiKB;
@end
@implementation YWInputTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self anywayInit];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self anywayInit];
}

- (void)anywayInit
{
    [self configParam];
    [self configView];
    [self configData];
    [self configConstraint];
}

- (void)configParam
{
    self.muArray = [@[] mutableCopy];
    self.emojiKB = [STEmojiKeyboard keyboard];
}

- (void)configView
{
    [self addSubview:self.emojiBtn];
    [self addSubview:self.inputText];
    [self addSubview:self.sendBtn];
    [self addSubview:self.topLine];
}

- (void)configData{}

- (void)configConstraint
{
    [self.emojiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10.5);
        make.left.equalTo(self).offset(14);
        make.bottom.equalTo(self).offset(-10.5);
        make.width.offset(27);
    }];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.emojiBtn.mas_centerY);
        make.right.equalTo(self).offset(-20);
        make.size.mas_equalTo(CGSizeMake(32, 22));
    }];
    [self.inputText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.emojiBtn.mas_centerY);
        make.left.equalTo(self.emojiBtn.mas_right).offset(14);
        make.right.equalTo(self.sendBtn.mas_left).offset(-20);
        make.height.offset(34);
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).offset(0);
        make.height.offset(1);
    }];
}

#pragma mark - Lazy
- (UIButton *)emojiBtn
{
    if (!_emojiBtn) {
        _emojiBtn = [[UIButton alloc]init];
        [_emojiBtn setImage:themeImage(@"发现") forState:UIControlStateNormal];
        [_emojiBtn addTarget:self action:@selector(emojiAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emojiBtn;
}

- (UITextField *)inputText
{
    if (!_inputText) {
        _inputText = [[UITextField alloc]init];
        _inputText.delegate = self;
        _inputText.placeholder = @"请畅所欲言";
        _inputText.textAlignment = NSTextAlignmentLeft;
        _inputText.layer.cornerRadius = 15;
        _inputText.backgroundColor = thouColor(248, 248, 248);
        UIView *leftVeiw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 16, 0)];
        leftVeiw.backgroundColor = [UIColor clearColor];
        _inputText.leftView = leftVeiw;
        _inputText.leftViewMode = UITextFieldViewModeAlways;
        //TODO: 颜色 字体 大小
        _inputText.textColor = thouColor(0, 0, 0);
        _inputText.font = kFontNormal(@"PingFangSC-Medium", 14);
    }
    return _inputText;
}

- (UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [[UIButton alloc]init];
        [_sendBtn setImage:themeImage(@"发现") forState:UIControlStateNormal];
        [_sendBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}

- (UIView *)topLine
{
    if (!_topLine){
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = thouColor(238, 238, 238);
    }
    return _topLine;
}

#pragma mark - action
- (void)emojiAction:(UIButton *)sender
{
    if (sender.selected) {
        [self.emojiKB setTextView:self.inputText];
        [self.inputText reloadInputViews];
        [self.inputText becomeFirstResponder];
    }else{
        [self.inputText setInputView:nil];
        [self.inputText reloadInputViews];
        [self.inputText becomeFirstResponder];
    }
    sender.selected = !sender.selected;
}

- (void)sendAction:(UIButton *)sender
{
    if ([self.inputText.text  isEqualToString:@""] || self.inputText.text == nil) {
        
    }else{
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"发现",@"imgURL",self.inputText.text,@"detail", @"GG",@"nickName", nil];
        ChatroomModel *model = [ChatroomModel chatroomModelWithDict:dict];
        [self.muArray addObject:model];
        if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldInputDetail:)]) {
            [self.delegate textFieldInputDetail:self.muArray];
        }
        self.inputText.text = nil;
    }
    [self.inputText setInputView:nil];
    [self manualDismissKeyBoard];
}

- (void)manualShowKeyBoard
{
    [self.inputText becomeFirstResponder];
}

- (void)manualDismissKeyBoard
{
    [self.inputText resignFirstResponder];
}

#pragma mark - textField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self manualDismissKeyBoard];
    return YES;
}

@end
