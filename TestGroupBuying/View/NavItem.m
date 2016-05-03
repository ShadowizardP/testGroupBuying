//
//  NavItem.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/1.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "NavItem.h"

@interface NavItem ()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end

@implementation NavItem

+(instancetype)makeItem{
    return [[[NSBundle mainBundle]loadNibNamed:@"NavItem" owner:self options:nil]firstObject];
}

-(void)addTarget:(id)target action:(SEL)action
{
    [self.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

-(void)makeNavItemUITop:(NSString *)top
{
    self.topLabel.text = top;
}

-(void)makeNavItemUIBottom:(NSString *)bottom
{
    self.bottomLabel.text = bottom;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
