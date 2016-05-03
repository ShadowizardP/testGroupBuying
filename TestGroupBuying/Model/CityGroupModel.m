//
//  CityGroupModel.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/5.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "CityGroupModel.h"

@implementation CityGroupModel{
    NSArray *plistArray;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self loadPlistData];
    }
    return self;
}

-(void)loadPlistData
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"cityGroups.plist" ofType:nil];
    plistArray = [NSArray arrayWithContentsOfFile:path];
}

-(NSArray *)getCityModelArray
{
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in plistArray) {
        CityGroupModel *md = [[CityGroupModel alloc]init];
        md.title = [dict objectForKey:@"title"];
        md.cities = [dict objectForKey:@"cities"];
        [arrM addObject:md];
    }
    return arrM;
}

-(NSArray *)getCityTitleArray
{
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in plistArray) {
        [arrM addObject:[dict objectForKey:@"title"]];
    }
    return arrM;
}

@end
