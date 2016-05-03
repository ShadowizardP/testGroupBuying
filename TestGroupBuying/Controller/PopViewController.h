//
//  PopViewController.h
//  TestGroupBuying
//
//  Created by SMartP on 16/2/2.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopViewController;

@protocol PopViewControllerDelegate <NSObject>

@optional
-(void)dismissPopover;

@end

@interface PopViewController : UIViewController

@property (nonatomic , assign) id<PopViewControllerDelegate> delegate;


@end
