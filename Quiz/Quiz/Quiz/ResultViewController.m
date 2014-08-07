//
//  ResultViewController.m
//  Quiz
//
//  Created by okitokagechika on 2014/04/11.
//  Copyright (c) 2014年 okito.kagechika. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController {
    // メンバー変数
    IBOutlet UILabel *percantageLabel;
    IBOutlet UILabel *levelLabel;
    IBOutlet UIImageView *levelImage;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(_correctPercentage < 30){
        levelLabel.text = @"猿レベル";
        levelImage.image = [UIImage imageNamed:@"monkey.png"];
    }else if(_correctPercentage >= 30 && _correctPercentage < 90){
        levelLabel.text = @"一般人レベル";
        levelImage.image = [UIImage imageNamed:@"human.png"];
    }else if(_correctPercentage >= 90){
        levelLabel.text = @"神レベル";
        levelImage.image = [UIImage imageNamed:@"god.png"];
    }
    
    percantageLabel.text = [NSString stringWithFormat:@"%d %%", _correctPercentage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
