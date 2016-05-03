//
//  regionModel.h
//  TestGroupBuying
//
//  Created by SMartP on 16/2/25.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface regionModel : NSObject

@property (nonatomic , copy) NSString * district_name;
@property (nonatomic , strong) NSArray * neighborhoods;

+(NSArray *)createWithArray:(NSArray *)array;


@end
