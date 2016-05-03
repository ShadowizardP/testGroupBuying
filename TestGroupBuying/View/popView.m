//
//  popView.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/4.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "popView.h"

@interface popView ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger _selectedLeftRow;
    BOOL _selected;
//       int _selectedLeftRow;

    
}
//@property (nonatomic , assign) NSInteger selectedLeftRow;

@property (weak, nonatomic) IBOutlet UITableView *leftTV;
@property (weak, nonatomic) IBOutlet UITableView *rightTV;

@end

@implementation popView



+(instancetype)makePopView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"popView" owner:self options:nil]firstObject];
}

-(void)reloadData
{
    [self.leftTV reloadData];
//    [self.rightTV reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _leftTV) {
        return [self.dataSource numberOfRowsInLeftTable:self];
    }
    else
    {
        if (_selected) {
            return [self.dataSource popView:self subcategoriesForRowAtIndexPath:_selectedLeftRow].count;
        }
        else{
            return 0;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTV) {
        static NSString *cellStr = @"MyCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        cell.textLabel.text = [self.dataSource popView:self textForRowAtIndexPath:indexPath.row];
        if ([self.dataSource respondsToSelector:@selector(popView:imageForRowAtIndexPath:)]) {
            cell.imageView.image = [UIImage imageNamed:[self.dataSource popView:self imageForRowAtIndexPath:indexPath.row]];
        }
        if ([self.dataSource popView:self subcategoriesForRowAtIndexPath:indexPath.row].count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
    else{
        static NSString *cellStr = @"MyCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"全部";
        }
        else
        {
            cell.textLabel.text = [self.dataSource popView:self subcategoriesForRowAtIndexPath:_selectedLeftRow][indexPath.row - 1];
        }
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTV) {
        _selected = YES;
        _selectedLeftRow = indexPath.row;
        [_rightTV reloadData];
        
        if ([self.delegate respondsToSelector:@selector(popView:didSelectRowAtLeftTable:)]) {
            [self.delegate popView:self didSelectRowAtLeftTable:indexPath.row];
        }
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(popView:didSelectRowAtRightTable:)]) {
            [self.delegate popView:self didSelectRowAtRightTable:indexPath.row];
        }
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
