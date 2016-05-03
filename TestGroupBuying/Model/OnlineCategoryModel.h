//
//  OnlineCategoryModel.h
//  TestGroupBuying
//
//  Created by SMartP on 16/2/18.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnlineCategoryModel : NSObject

@property (nonatomic , copy) NSString * name;
@property (nonatomic , strong) NSArray * subcategories;

+(NSArray *)createWithArray:(NSArray *)arr;

@end
