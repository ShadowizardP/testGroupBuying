//
//  SecondPopViewController.h
//  TestGroupBuying
//
//  Created by SMartP on 16/2/5.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SecondPopViewControllerDelegate <NSObject>

@optional
-(void)changeCityOnClicked:(UIButton *)btn;
-(void)dismissPopover;

@end

@interface SecondPopViewController : UIViewController

@property(assign,nonatomic) id<SecondPopViewControllerDelegate> delegate;
@property (nonatomic , copy) NSString * selectedCity;

@end
