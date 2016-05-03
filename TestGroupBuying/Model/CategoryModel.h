//
//  CategoryModel.h
//  TestGroupBuying
//
//  Created by SMartP on 16/2/5.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

#pragma mark - 声明属性
@property (copy,nonatomic)NSString *highlighted_icon;
@property (copy,nonatomic)NSString *small_highlighted_icon;
@property (copy,nonatomic)NSString *icon;
@property (copy,nonatomic)NSString *small_icon;
@property (copy,nonatomic)NSString *name;

@property (strong,nonatomic)NSArray *subcategories;

-(NSArray *)loadPlistData;

@end
