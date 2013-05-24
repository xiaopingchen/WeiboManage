//
//  User.h
//  ZhiWeiboPhone
//
//  Created by junmin liu on 12-8-31.
//  Copyright (c) 2012年 idfsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionaryAdditions.h"

typedef enum {
    GenderUnknow = 0,
    GenderMale,
    GenderFemale,
} Gender;

typedef enum {
    OnlineStatusOffline = 0,
    OnlineStatusOnline = 1,
} OnlineStatus;

@interface User : NSObject<NSCoding> {

}

- (id)initWithJsonDictionary:(NSDictionary*)dic;

@property (nonatomic, assign) long long userId;
@property (nonatomic, copy) NSString *screenName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *profileImageUrl;
@property (nonatomic, copy) NSString *profileLargeImageUrl;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *verifiedReason;
@property (nonatomic, assign) Gender gender;
@property (nonatomic, assign) int followersCount;
@property (nonatomic, assign) int friendsCount;
@property (nonatomic, assign) int statusesCount;
@property (nonatomic, assign) int favoritesCount;
@property (nonatomic, assign) int biFollowersCount;
@property (nonatomic, assign) time_t createdAt;
@property (nonatomic, assign, getter=isFollowing) BOOL following;
@property (nonatomic, assign, getter=isFollowedBy) BOOL followedBy;
@property (nonatomic, assign, getter=isVerified) BOOL verified;
@property (nonatomic, assign, getter=isAllowAllActMsg) BOOL allowAllActMsg;
@property (nonatomic, assign, getter=isGeoEnabled) BOOL geoEnabled;
@property (nonatomic, assign, getter=isAllowComment) BOOL allowComment;
@property (nonatomic, assign) OnlineStatus onlineStatus;


@end
