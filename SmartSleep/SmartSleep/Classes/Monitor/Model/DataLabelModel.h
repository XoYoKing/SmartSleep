//
//  DataLabelModel.h
//  SmartSleep
//
//  Created by William Cai on 16/7/20.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataLabelModel : NSObject

@property (nonatomic, strong) NSDictionary *sleepDate;
@property (nonatomic, strong) NSDictionary *offBedTime;
@property (nonatomic, strong) NSDictionary *fallAsleepTime;
@property (nonatomic, strong) NSDictionary *wakeTime;
@property (nonatomic, assign) NSInteger sleepDuration;
@property (nonatomic, assign) double fallAsleepDuration;

@property (nonatomic, assign) double deepSleep;
@property (nonatomic, assign) double lightSleep;
@property (nonatomic, assign) double dreamSleep;
@property (nonatomic, assign) double wakeSleep;

@property (nonatomic, assign) NSInteger efficiency;

@property (nonatomic, assign) NSInteger sleepLeave;
@property (nonatomic, assign) NSInteger sleepMove;

@end
