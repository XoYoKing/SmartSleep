//
//  MyRecordModel.h
//  SmartSleep
//
//  Created by William Cai on 16/7/19.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRecordModel : NSObject

@property (nonatomic, assign) NSInteger efficiency;
@property (nonatomic, assign) NSInteger sleepDuration;

@property (nonatomic, strong) NSDictionary *sleepDate;

@end
