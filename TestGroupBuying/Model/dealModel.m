//
//  dealModel.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/18.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "dealModel.h"

@implementation dealModel

+ (NSArray *)asignModelWithDict:(NSDictionary *)dict{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *dictArray = [dict objectForKey:@"deals"];
    for (NSDictionary *dict in dictArray) {
        dealModel *md = [[dealModel alloc]init];
        md.categories = dict[@"categories"];
        md.city = dict[@"city"];
        md.current_price = [dict[@"current_price"]stringValue];
        md.deal_h5_url = dict[@"deal_h5_url"];
        md.deal_url = dict[@"deal_url"];
        md.Description = dict[@"description"];
        md.image_url = dict[@"image_url"];
        md.s_image_url = dict[@"s_image_url"];
        md.list_price = [dict[@"list_price"]stringValue];
        md.purchase_count = [dict[@"purchase_count"]stringValue];
        md.title = dict[@"title"];
        [arr addObject:md];
    }
    return arr;
}


@end
