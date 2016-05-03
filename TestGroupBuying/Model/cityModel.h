//
//  cityModel.h
//  TestGroupBuying
//
//  Created by SMartP on 16/2/13.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cityModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *pinYin;
@property (nonatomic,copy) NSString *pinYinHead;
@property (nonatomic,strong) NSArray *regions;

+(NSArray *)getCitys;

@end
