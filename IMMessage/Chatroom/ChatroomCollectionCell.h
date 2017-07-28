//
//  ChatroomTableCell.h
//  IMMessage
//
//  Created by 杨晓宇 on 2017/7/26.
//  Copyright © 2017年 com.ywart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

#define thouColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kFontNormal(t,s) [UIFont fontWithName:t size:s]
#define themeImage(img) [UIImage imageNamed:img]

@interface ChatroomCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *faceImage;
@property (nonatomic, strong) UILabel *nickName;
@property (nonatomic, strong) UILabel *detailLab;

@end
