//
//  ChatroomTableView.m
//  IMMessage
//
//  Created by 杨晓宇 on 2017/7/26.
//  Copyright © 2017年 com.ywart. All rights reserved.
//

#import "ChatroomCollectionView.h"
#import "ChatroomCollectionCell.h"


#define kCell @"kCell"

@interface ChatroomCollectionView()

@property (nonatomic, strong) NSArray *muArray;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation ChatroomCollectionView

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
    self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchHeaderView)];
    [self addGestureRecognizer:self.tapGesture];
}

- (void)configView
{
    [self addSubview:self.header];
    [self addSubview:self.chatDetail];
    [self addSubview:self.textInputView];
}

- (void)configData{}

- (void)configConstraint
{
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self).offset(0);
        make.height.offset(44);
    }];
    [self.textInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self).offset(0);
        make.height.offset(48);
    }];
    [self.chatDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.header.mas_bottom).offset(0);
        make.bottom.equalTo(self.textInputView.mas_top).offset(0);
        make.left.right.equalTo(self).offset(0);
    }];
    
}

#pragma mark - Lazy load
- (ChatroomPreloadView *)header
{
    if (!_header) {
        _header = [[ChatroomPreloadView alloc]init];
        _header.delegate = self;
        [_header.delegate headerTheViewIsExpend:NO];
        _header.backgroundColor = thouColor(255, 255, 255);
    }
    return _header;
}

- (YWInputTextView *)textInputView
{
    if (!_textInputView) {
        _textInputView = [[YWInputTextView alloc]init];
        _textInputView.delegate = self;
        _textInputView.backgroundColor = thouColor(0, 0, 0);
    }
    return _textInputView;
}
- (UICollectionView *)chatDetail
{
    if (!_chatDetail) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.estimatedItemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
        _chatDetail = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        _chatDetail.showsVerticalScrollIndicator = NO;
        _chatDetail.delegate = self;
        _chatDetail.dataSource = self;
        [_chatDetail registerClass:[ChatroomCollectionCell class] forCellWithReuseIdentifier:kCell];
        _chatDetail.backgroundColor = [UIColor whiteColor];
    }
    return _chatDetail;
}

#pragma mark - tap
- (void)touchHeaderView
{
    [self.chatDelegate touchHeaderView:YES];
}

#pragma mark - header Delegate
- (void)headerTheViewIsExpend:(BOOL)isexpend
{
    if (isexpend) {
        self.header.headLabel.text = @"聊天";
        [self.header.imgView setHidden:YES];
        [self.header.leftBtn setHidden:NO];
        [self.header.rightBtn setHidden:NO];
        
        self.textInputView.emojiBtn.selected = YES;
        self.header.rightBtn.selected = YES;
        [self removeGestureRecognizer:self.tapGesture];
    }else{
        self.header.headLabel.text = @"实时聊天";
        [self.header.leftBtn setHidden:YES];
        [self.header.rightBtn setHidden:YES];
        [self.header.imgView setHidden:NO];
        [self.chatDelegate chatroomHide];
        
        self.textInputView.emojiBtn.selected = NO;
        self.header.rightBtn.selected = NO;
        [self addGestureRecognizer:self.tapGesture];
    }
}

- (void)keyBoardIfNeedShow:(BOOL)show
{
    if (show) {
        [self.textInputView manualShowKeyBoard];
        self.textInputView.emojiBtn.selected = YES;
    }else{
        [self.textInputView manualDismissKeyBoard];
        self.textInputView.emojiBtn.selected = YES;
    }
}

#pragma mark - inputView Delegate
- (void)textFieldInputDetail:(NSArray *)array
{
    [self.chatDetail reloadData];
    self.muArray = array;
    [self.chatDetail reloadData];
}

#pragma mark - collection Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.muArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChatroomModel *model = self.muArray[indexPath.row];
    ChatroomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
    cell.faceImage.image = themeImage(model.imgURL);
    cell.nickName.text = model.nickName;
    cell.detailLab.text = model.detail;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(self.frame.size.width, 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 14;
}

@end

