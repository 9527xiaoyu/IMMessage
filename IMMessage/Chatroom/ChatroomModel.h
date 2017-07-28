//
//  ChatroomModel.h
//  IMMessage
//
//  Created by 杨晓宇 on 2017/7/27.
//  Copyright © 2017年 com.ywart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatroomModel : NSObject

@property (nonatomic, strong) NSString *imgURL;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *detail;

+ (instancetype)chatroomModelWithDict:(NSDictionary *)dict;

@end
