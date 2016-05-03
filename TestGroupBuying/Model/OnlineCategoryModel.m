//
//  OnlineCategoryModel.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/18.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "OnlineCategoryModel.h"

@implementation OnlineCategoryModel

+(NSArray *)createWithArray:(NSArray *)arr
{
    NSMutableArray *data = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in arr) {
        OnlineCategoryModel *md = [[OnlineCategoryModel alloc]init];
        md.name = [dict objectForKey:@"category_name"];
        md.subcategories = [dict objectForKey:@"subcategories"];
        [data addObject:md];
    }
    return data;
}

@end
