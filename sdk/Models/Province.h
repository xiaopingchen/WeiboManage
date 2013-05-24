//
//  Province.h
//  ZhiWeiboPhone
//
//  Created by junmin liu on 12-8-31.
//  Copyright (c) 2012年 idfsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject<NSCoding> {

}

- (id)initWithDictionary:(NSDictionary *)dict;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSMutableDictionary *cities;

@end
