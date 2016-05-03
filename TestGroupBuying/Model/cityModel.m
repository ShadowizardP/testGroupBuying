//
//  cityModel.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/13.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "cityModel.h"

@implementation cityModel

+(NSArray *)getCitys
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"cities.plist" ofType:nil];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *cityArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in plistArray) {
        cityModel *model = [[cityModel alloc]init];
        model.name = [dict objectForKey:@"name"];
        model.pinYin = [dict objectForKey:@"pinYin"];
        model.pinYinHead = [dict objectForKey:@"pinYinHead"];
        model.regions = [dict objectForKey:@"regions"];
        [cityArray addObject:model];
    }
    return cityArray;
}

@end
