//
//  CategoryModel.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/5.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "CategoryModel.h"
#import "DPAPI.h"

@interface CategoryModel ()<DPRequestDelegate>
{
//    NSDictionary *_result;
//    BOOL _loadOK;
}

@end

@implementation CategoryModel

-(NSArray *)loadPlistData
{
//    _loadOK = NO;
//    [self sendRequest];
//    while (!_loadOK) {
//        
//    }
    NSString *path = [[NSBundle mainBundle]pathForResource:@"categories.plist" ofType:nil];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:path];
    NSArray *dataArray = [self getDataWithArray:plistArray];
    return dataArray;
    
}

//-(void)sendRequest
//{
//    DPAPI *api = [[DPAPI alloc]init];
//    [api requestWithURL:@"v1/metadata/get_categories_with_deals" params:nil delegate:self];
//}



-(NSArray *)getDataWithArray:(NSArray *)array
{
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in array) {
        CategoryModel *model = [[CategoryModel alloc]init];
        [model makeModelWithDict:dict];
        [arrM addObject:model];
    }
    return arrM;
}

-(CategoryModel*)makeModelWithDict:(NSDictionary *)dict
{
    self.highlighted_icon = [dict objectForKey:@"highlighted_icon"];
    self.small_highlighted_icon = [dict objectForKey:@"small_highlighted_icon"];
    self.icon = [dict objectForKey:@"icon"];
    self.small_icon = [dict objectForKey:@"small_icon"];
    self.name = [dict objectForKey:@"name"];
//    NSArray *arr = [_result objectForKey:@"categories"];
//    for (NSDictionary *dictionary in arr) {
//        if ([(NSString *)[dictionary objectForKey:@"category_name"] isEqualToString:self.name]) {
//            self.subcategories = [dictionary objectForKey:@"subcategories"];
//        }
//    }
    self.subcategories = [dict objectForKey:@"subcategories"];
    return self;
}

//-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
//{
//    NSLog(@"%@",result);
//    NSError *err;
//    _result = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:&err];
//    _loadOK = YES;
//}
//
//-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
//{
//    NSLog(@"%@",error);
//}

@end
