//
//  ChatroomModel.m
//  IMMessage
//
//  Created by 杨晓宇 on 2017/7/27.
//  Copyright © 2017年 com.ywart. All rights reserved.
//

#import "ChatroomModel.h"

@implementation ChatroomModel

+ (instancetype)chatroomModelWithDict:(NSDictionary *)dict
{
    ChatroomModel *model = [[ChatroomModel alloc]init];
    NSString *imgURL = [dict objectForKey:@"imgURL"];
    model.imgURL = imgURL;
    NSString *nickName = [dict objectForKey:@"nickName"];
    model.nickName = nickName;
    NSString *detail = [dict objectForKey:@"detail"];
    model.detail = detail;
    return model;
}
@end
