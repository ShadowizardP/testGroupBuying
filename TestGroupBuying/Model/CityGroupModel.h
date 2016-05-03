//
//  CityGroupModel.h
//  TestGroupBuying
//
//  Created by SMartP on 16/2/5.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityGroupModel : NSObject

@property(copy,nonatomic) NSString *title;
@property(strong,nonatomic) NSArray *cities;

-(NSArray *)getCityModelArray;
-(NSArray *)getCityTitleArray;

@end
