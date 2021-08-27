//
//  HALogConfig.h
//  HiAnalytics
//
//  Created by  epro123 on 2021/6/21.
//  Copyright © 2021 cbg_bigdata. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HALogConfig : NSObject

/**
 * Initialize configuration.
 */
+ (nullable HALogConfig *)configWithRegion:(nonnull NSString *)region projectId:(nonnull NSString *)projectId groupId:(nonnull NSString *)groupId streamId:(nonnull NSString *)streamId tags:(nullable NSDictionary<NSString *,NSString *> *)tags;

@end

NS_ASSUME_NONNULL_END
