//
//  Status.h
//  ZhiWeiboPhone
//
//  Created by junmin liu on 12-9-4.
//  Copyright (c) 2012年 idfsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionaryAdditions.h"
#import "GeoInfo.h"
#import "User.h"

@interface Status : NSObject<NSCoding> {

    NSNumber *_statusKey;
}

+ (Status *)statusWithJsonDictionary:(NSDictionary*)dic;
- (id)initWithJsonDictionary:(NSDictionary*)dic;

@property (nonatomic, copy) NSString *statusIdString;
@property (nonatomic, assign) time_t createdAt;
@property (nonatomic, assign) long long statusId;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *sourceUrl;
@property (nonatomic, assign, getter=isFavorited) BOOL favorited;
@property (nonatomic, assign, getter=isTruncated) BOOL truncated;
@property (nonatomic, assign) long long inReplyToStatusId;
@property (nonatomic, assign) long long inReplyToUserId;
@property (nonatomic, copy) NSString *inReplyToScreenName;
@property (nonatomic, assign) long long mid;
@property (nonatomic, copy) NSString *middleImageUrl;
@property (nonatomic, copy) NSString *originalImageUrl;
@property (nonatomic, copy) NSString *thumbnailImageUrl;
@property (nonatomic) int repostsCount;
@property (nonatomic) int commentsCount;
@property (nonatomic, strong) GeoInfo *geo;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Status *retweetedStatus;
@property (nonatomic, readonly) NSNumber *statusKey;

- (NSString*)statusTimeString;
- (NSString*)statusDateTimeString;


@end
