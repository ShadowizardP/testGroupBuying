//
//  regionModel.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/25.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "regionModel.h"

@implementation regionModel

+(NSArray *)createWithArray:(NSArray *)array
{
    NSMutableArray *data = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in array) {
        regionModel *md = [[regionModel alloc]init];
        md.district_name = [dict objectForKey:@"district_name"];
        md.neighborhoods = [dict objectForKey:@"neighborhoods"];
        [data addObject:md];
    }
    return data;
}

@end
