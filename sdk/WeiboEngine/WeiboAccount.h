//
//  WeiboAccount.h
//  ZhiWeiboPhone
//
//  Created by junmin liu on 12-8-20.
//  Copyright (c) 2012年 idfsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboAccount : NSObject {

}

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *accessToken;
@property (unsafe_unretained, nonatomic) NSDate *expirationDate;
@property (nonatomic, copy) NSString *screenName;
@property (nonatomic, copy) NSString *profileImageUrl;
@property (nonatomic) BOOL selected;

@end
