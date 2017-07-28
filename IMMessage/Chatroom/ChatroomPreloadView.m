//
//  ChatroomPreloadView.m
//  IMMessage
//
//  Created by 杨晓宇 on 2017/7/26.
//  Copyright © 2017年 com.ywart. All rights reserved.
//

#import "ChatroomPreloadView.h"

#pragma mark - 头视图
@interface ChatroomPreloadView()

@property (nonatomic, strong) UIView *downLine;

@end

@implementation ChatroomPreloadView

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
    
}

- (void)configView
{
    [self addSubview:self.leftBtn];
    [self addSubview:self.headLabel];
    [self addSubview:self.rightBtn];
    [self addSubview:self.downLine];
    [self addSubview:self.imgView];
}

- (void)configData
{
    
}

- (void)configConstraint
{
    [self viewExpend];
    [self viewNotExpend];
    
}

- (void)viewExpend{
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(11);
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(self).offset(-11);
        make.width.offset(22);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftBtn.mas_centerY);
        make.right.equalTo(self).offset(-20);
        make.height.offset(9.7);
    }];
    [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftBtn.mas_centerY);
        make.left.equalTo(self.leftBtn.mas_right).offset(130);
        make.right.equalTo(self.rightBtn.mas_left).offset(-100);
        make.bottom.equalTo(self).offset(-11);
    }];
    [self.downLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self).offset(0);
        make.height.offset(1);
    }];
}

- (void)viewNotExpend
{
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(13);
        make.left.equalTo(self).offset(142);
        make.bottom.equalTo(self).offset(-13.2);
        make.width.offset(22);
    }];
}

#pragma mark - Lazy
- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc]init];
        [_leftBtn setImage:themeImage(@"发现") forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UILabel *)headLabel
{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]init];
        _headLabel.textAlignment = NSTextAlignmentLeft;
        //TODO:颜色 字体 大小
        _headLabel.font = kFontNormal(@"PingFang-SC-Medium", 16);
        _headLabel.textColor = thouColor(0, 0, 0);
    }
    return _headLabel;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc]init];
        [_rightBtn setImage:themeImage(@"向下箭头") forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UIView *)downLine
{
    if (!_downLine){
        _downLine = [[UIView alloc]init];
        _downLine.backgroundColor = thouColor(238, 238, 238);
    }
    return _downLine;
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = themeImage(@"发现");
    }
    return _imgView;
}
#pragma mark -action
- (void)leftAction:(UIButton *)sender
{
    
}

- (void)rightAction:(UIButton *)sender
{
    if (sender.selected) {
        //显示键盘
        if (self.delegate && [self.delegate respondsToSelector:@selector(keyBoardIfNeedShow:)]) {
            [self.delegate keyBoardIfNeedShow:YES];
        }
    }else{
        if (self.showKeybraod) { //打开键盘状态
            [self.delegate keyBoardIfNeedShow:NO];
        }else{ // 关闭键盘状态
            [self.delegate headerTheViewIsExpend:NO];
        }
    }
}

@end
