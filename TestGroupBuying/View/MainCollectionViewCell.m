//
//  MainCollectionViewCell.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/25.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "MainCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "dealModel.h"
#import "LabelWithLine.h"

@interface MainCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *current_priceLabel;
@property (weak, nonatomic) IBOutlet LabelWithLine *list_priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchase_countLabel;

@end

@implementation MainCollectionViewCell

-(void)makeUIWithModel:(dealModel *)model
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    self.titleLabel.text = model.title;
    self.current_priceLabel.text = [NSString stringWithFormat:@"¥%@",model.current_price];
    self.list_priceLabel.text = [NSString stringWithFormat:@"¥%@",model.list_price];
    self.purchase_countLabel.text = [NSString stringWithFormat:@"已售%@",model.purchase_count];
}

- (void)awakeFromNib {
    // Initialization code
    //设置背景
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dealcell"]];

}

@end
