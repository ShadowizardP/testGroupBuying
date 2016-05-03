//
//  popView.h
//  TestGroupBuying
//
//  Created by SMartP on 16/2/4.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class popView;

@protocol MyPopViewDataSource <NSObject>

-(NSInteger)numberOfRowsInLeftTable:(popView *)popView;

-(NSString *)popView:(popView *)popView textForRowAtIndexPath:(NSInteger)row;

-(NSArray *)popView:(popView *)popView subcategoriesForRowAtIndexPath:(NSInteger)row;

@optional
-(NSString *)popView:(popView *)popView imageForRowAtIndexPath:(NSInteger)row;


@end

@protocol MyPopViewDelegate <NSObject>

@optional
-(void)popView:(popView *)popView didSelectRowAtLeftTable:(NSInteger)row;

-(void)popView:(popView *)popView didSelectRowAtRightTable:(NSInteger)row;

@end

@interface popView : UIView


@property (assign , nonatomic) id<MyPopViewDataSource> dataSource;

@property (assign , nonatomic) id<MyPopViewDelegate> delegate;

-(void)reloadData;

+(instancetype)makePopView;

@end
