//
//  NavItem.h
//  TestGroupBuying
//
//  Created by SMartP on 16/2/1.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavItem : UIView

+(instancetype)makeItem;

-(void)addTarget:(id)target action:(SEL)action;

-(void)makeNavItemUITop:(NSString *)top;
-(void)makeNavItemUIBottom:(NSString *)bottom;

@end
