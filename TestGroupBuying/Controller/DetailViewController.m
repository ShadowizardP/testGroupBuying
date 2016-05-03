//
//  DetailViewController.m
//  TestGroupBuying
//
//  Created by SMartP on 16/2/26.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import "DetailViewController.h"
#import "LabelWithLine.h"
#import "dealModel.h"
#import "UIImageView+WebCache.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *current_priceLabel;
@property (weak, nonatomic) IBOutlet LabelWithLine *list_priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *perchase_countLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"团购详情";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backToVC)];
    self.navigationItem.leftBarButtonItem = backItem;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_md.image_url]];
    self.titleLabel.text = _md.title;
    self.descriptionLabel.text = _md.Description;
    self.current_priceLabel.text = [NSString stringWithFormat:@"¥%@",_md.current_price];
    self.list_priceLabel.text = [NSString stringWithFormat:@"¥%@",_md.list_price];
    self.perchase_countLabel.text = [NSString stringWithFormat:@"已售%@",_md.purchase_count];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 返回firstViewController
-(void)backToVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
