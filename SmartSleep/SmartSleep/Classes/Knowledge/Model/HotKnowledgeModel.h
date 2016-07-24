//
//  HotKnowledgeModel.h
//  SmartSleep
//
//  Created by William Cai on 16/7/24.
//  Copyright © 2016年 William Cai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotKnowledgeModel : NSObject

@property (nonatomic, copy) NSString *knowTitle;
@property (nonatomic, copy) NSString *knowImage;
@property (nonatomic, copy) NSString *knowContent;
@property (nonatomic, assign) NSInteger visitCapacity;
@property (nonatomic, assign) NSInteger knowledgeId;

//@property (nonatomic, copy) NSString *knowTag;
//@property (nonatomic, assign) NSInteger knowClassifyId;
//@property (nonatomic, copy) NSDictionary *knowTime;

@end
