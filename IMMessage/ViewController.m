//
//  ViewController.m
//  IMMessage
//
//  Created by 杨晓宇 on 2017/7/26.
//  Copyright © 2017年 com.ywart. All rights reserved.
//

#import "ViewController.h"
#import "ChatroomCollectionView.h"
#import <Masonry.h>

@interface ViewController ()<ChatroomDelegate>
@property (nonatomic, strong) ChatroomCollectionView *chatroomView;
@property (nonatomic, assign) CGRect rect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self yw_configParams];
    [self yw_configDatas];
    [self yw_configViews];
    [self yw_configConstraints];
}

- (void)yw_configParams
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboadWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)yw_configDatas
{
    self.rect = CGRectMake(0, 220, self.view.frame.size.width, 447);
    self.chatroomView.header.isExpend = NO;
}

- (void)yw_configConstraints
{
    [self.chatroomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view.mas_bottom).offset(-44);
        make.height.offset(447);
    }];
}

-(void)yw_configViews
{
    [self.view addSubview:self.chatroomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ChatroomCollectionView *)chatroomView
{
    if (!_chatroomView) {
        _chatroomView = [[ChatroomCollectionView alloc]init];
        _chatroomView.chatDelegate = self;
        _chatroomView.backgroundColor = [UIColor redColor];
    }
    return _chatroomView;
}

#pragma mark - 点击hederView 委托事件
- (void)touchHeaderView:(BOOL)tap
{
    if (tap) {
        self.chatroomView.header.showKeybraod = NO;
        [self.chatroomView.header.delegate headerTheViewIsExpend:YES];
//        [UIView animateWithDuration:0.3 animations:^{
//            [self.chatroomView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.view).offset(220);
//                make.bottom.equalTo(self.view).offset(0);
//            }];
//        } completion:^(BOOL finished) {
//            [self.view layoutIfNeeded];
//        }];
        [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
        [UIView setAnimationDuration:0.3];//设置动画时间 秒为单位
        [self.chatroomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view).offset(0);
            make.top.equalTo(self.view).offset(220);
            make.bottom.equalTo(self.view).offset(0);
        }];
        [UIView commitAnimations];
    }
}

#pragma mark - textView KeyBoard
//键盘出现时候调用的事件
//-(void) keyboadWillShow:(NSNotification *)note{
//    self.chatroomView.header.showKeybraod = YES;
//    self.chatroomView.header.rightBtn.selected = NO;
//    
//    NSDictionary *info = [note userInfo];
//    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//键盘的frame
//    CGFloat offY = ([UIScreen mainScreen].bounds.size.height-keyboardSize.height)-20;//屏幕总高度-键盘高度-UITextField高度
//    
//    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
//    [UIView setAnimationDuration:0.3];//设置动画时间 秒为单位
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        [self.chatroomView mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view.mas_top).offset(20);
//            make.left.right.equalTo(self.view).offset(0);
//            make.height.offset(offY);
//        }];
//    } completion:^(BOOL finished) {
//        [self.view layoutIfNeeded];
//    }];
//    [UIView commitAnimations];//开始动画效果
//    
//}
//
////键盘消失时候调用的事件
//-(void)keyboardWillHide:(NSNotification *)note{
//    self.chatroomView.header.showKeybraod = NO;
//    self.chatroomView.header.rightBtn.selected = NO;
//    
//    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
//    [UIView setAnimationDuration:0.3];
//    [self.chatroomView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view).offset(0);
//        make.top.equalTo(self.view).offset(220);
//        make.bottom.equalTo(self.view).offset(0);
//    }];
//    [UIView commitAnimations];
//}

- (void)keyboardChangeFrame:(NSNotification *)note
{
    CGFloat time = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat endY = rect.origin.y;
    [UIView animateWithDuration:time animations:^{
        [self.chatroomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view).offset(0);
            make.top.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.view).offset(endY-[UIScreen mainScreen].bounds.size.height);
        }];
        
    } completion:^(BOOL finished) {
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - 聊天窗口 “实时聊天”
- (void)chatroomHide
{
    [UIView beginAnimations:nil context:NULL];//此处添加动画，使之变化平滑一点
    [UIView setAnimationDuration:0.3];
    [self.chatroomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view.mas_bottom).offset(-44);
        make.height.offset(447);
    }];
    [UIView commitAnimations];
}

@end
