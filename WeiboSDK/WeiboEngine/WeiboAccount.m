//
//  WeiboAccount.m
//  WeiboManage
//
//  Created by chen xiaoping on 5/20/13.
//  Copyright (c) 2013 chen xiaoping. All rights reserved.
//

#import "WeiboAccount.h"

@implementation WeiboAccount

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userId forKey:@"userID"];
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
    [aCoder encodeObject:self.expirationDate forKey:@"expirationDate"];
    [aCoder encodeObject:self.profileImageUrl forKey:@"profileImageUrl"];
    [aCoder encodeBool:self.selected forKey:@"selected"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super init];
    if (self) {
        self.userId=[aDecoder decodeObjectForKey:@"userID"];
        self.accessToken=[aDecoder decodeObjectForKey:@"accessToken"];
        self.expirationDate=[aDecoder decodeObjectForKey:@"expirationDate"];
        self.profileImageUrl=[aDecoder decodeObjectForKey:@"profileImageUrl"];
        self.selected=[aDecoder decodeBoolForKey:@"selected"];
    }
    
    return self;
}

@end
