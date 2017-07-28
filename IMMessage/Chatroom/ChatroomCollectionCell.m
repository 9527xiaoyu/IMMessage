//
//  ChatroomTableCell.m
//  IMMessage
//
//  Created by 杨晓宇 on 2017/7/26.
//  Copyright © 2017年 com.ywart. All rights reserved.
//

#import "ChatroomCollectionCell.h"

@implementation ChatroomCollectionCell

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
    self.backgroundColor = [UIColor whiteColor];
}

- (void)configView
{
    [self.contentView addSubview:self.faceImage];
    [self.contentView addSubview:self.nickName];
    [self.contentView addSubview:self.detailLab];
}

- (void)configData{}

- (void)configConstraint
{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.equalTo(self.detailLab.mas_bottom);
    }];
    [self.faceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.faceImage.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-136);
        make.height.offset(20);
    }];
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickName.mas_bottom).offset(0);
        make.left.equalTo(self.faceImage.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
    }];
}

#pragma mark - Lazy load
- (UIImageView *)faceImage
{
    if (!_faceImage) {
        _faceImage = [[UIImageView alloc]init];
        _faceImage.layer.cornerRadius = 13;
    }
    return _faceImage;
}

- (UILabel *)nickName
{
    if (!_nickName) {
        _nickName = [[UILabel alloc]init];
        _nickName.textAlignment = NSTextAlignmentLeft;
        //TODO:颜色 字体 大小
        _nickName.textColor = thouColor(60,148,139);
        _nickName.font = kFontNormal(@"PingFang-SC-Medium",14);
    }
    return _nickName;
}

- (UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.numberOfLines = 0;
        //TODO:颜色 字体 大小
        _detailLab.textColor = thouColor(51,51,51);
        _detailLab.font = kFontNormal(@"PingFangSC-Regular",14);
    }
    return _detailLab;
}

- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    
    [self setNeedsLayout];
    
    [self layoutIfNeeded];
    
    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];
    
    CGRect cellFrame = layoutAttributes.frame;
    
    cellFrame.size.height= size.height;
    
    layoutAttributes.frame= cellFrame;
    
    return layoutAttributes;
    
}

@end
